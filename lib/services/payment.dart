// ignore_for_file: unnecessary_cast

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/users.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:pocketbase/pocketbase.dart';

/// 인앱 결제 서비스
class InAppPurchaseService extends GetxService {
  static InAppPurchaseService get to => Get.find();
  // Instance ▼ ============================================

  final pb = PocketBase(API_URL);
  final UserInfoProvider userInfoProvider = UserInfoProvider();
  final UsersService _usersService = UsersService();

  /// 구매를 위한 인스턴스를 가져옵니다.
  final Rx<InAppPurchase> iap = InAppPurchase.instance.obs;

  // 구매 세부 정보에 대한 업데이트 스트림을 수신하는 구독
  late Rx<StreamSubscription?> subscription = (null as StreamSubscription?).obs;

  // 결제 선택을 한 상품의 ID
  String selectedProductID = '';

  // 결제 상품 아이디 목록
  List<String> productIDList = <String>['100en', '500en'];

  // Playstore 또는 앱 스토어에서 쿼리한 제품 목록 유지
  RxMap<String, dynamic> products = <String, dynamic>{}.obs;
  // 과거 구매 사용자 목록
  RxList<PurchaseDetails> purchases = <PurchaseDetails>[].obs;

  // Function ▼ ============================================

  Future<void> writePaymentLog(String func, dynamic data) async {
    try {
      final body = <String, dynamic>{
        "func": func,
        "user_id": userInfoProvider.id.value,
        "datas": data.toString(),
      };

      await pb.collection('payment').create(body: body);
    } catch (error) {
      log('writePaymentLog.error: $error');
    }
  }

  /// 상품 목록 조회 방법
  ///
  /// Future<void>
  Future<void> fetchUserProducts() async {
    // 구매를 위한 인스턴스를 가져옵니다.
    for (var productID in productIDList) {
      ProductDetailsResponse response = await iap.value.queryProductDetails({
        productID,
      });

      // 제품 목록 데이터 추가
      products[response.productDetails[0].id] = response.productDetails[0];
    }
  }

  /// 과거 구매 사용자를 검색하는 방법
  ///
  /// @return Future<void>
  Future<void> fetchPastPurchases() async {
    /// 모든 이전 구매를 복원합니다.
    /// `applicationUserName`은 초기 `PurchaseParam`에서 전송된 내용과 일치해야 합니다.
    /// 초기 `PurchaseParam`에 `applicationUserName`이 지정되지 않은 경우 null을 사용합니다.
    /// 복원된 구매는 [PurchaseStatus.restored] 상태로 [purchaseStream]을 통해 전달됩니다.
    /// 이러한 구매를 수신하고, 영수증을 확인하고, 콘텐츠를 전달하고, 각 구매에 대해 [finishPurchase] 메서드를 호출하여 구매 완료를 표시해야 합니다.
    /// 이것은 소비된 제품을 반환하지 않습니다.
    /// `사용하지 않는 소모품을 복원하려면 자체 서버에서 사용자에 대한 소모품 정보를 유지해야 합니다.`
    await iap.value.restorePurchases();
  }

  /// 상품을 이미 구매했는지 여부를 확인하는 방법입니다.
  ///
  /// @return void
  void verifyPurchases() async {
    try {
      PurchaseDetails purchase = purchases.firstWhere((purchase) => purchase.productID == selectedProductID);

      if (purchase.status == PurchaseStatus.purchased) {
        //
        // 구매 완료 + 포인트 추가
        writePaymentLog('verifyPurchases Success', {'id': purchase.productID, 'status': purchase.status.toString(), 'purchased': PurchaseStatus.purchased.toString()});
        final Map<String, int> pointMap = {
          '100en': PRODUCT_ID_100EN_POINT,
          '500en': PRODUCT_ID_500EN_POINT,
        };

        final Map<String, int> expMap = {
          '100en': PRODUCT_ID_100EN_EXP,
          '500en': PRODUCT_ID_500EN_EXP,
        };

        // TODO ::: 결제 완료시 포인트 갱신이 좀 느린 느낌?, 갱신은 문제없이 된다.
        userInfoProvider.point.value = userInfoProvider.point.value + pointMap[purchase.productID]!;
        userInfoProvider.exp.value = userInfoProvider.exp.value + expMap[purchase.productID]!;

        await _usersService.updateUserPoint(userInfoProvider.point.value, userInfoProvider.exp.value);
      }
    } catch (error) {
      // 구매 미완료
      writePaymentLog('verifyPurchases.error', error.toString());
      rethrow;
    }
  }

  /// 제품 구매 방법
  ///
  /// [prod] 구매할 제품
  ///
  /// @return 구매 성공 여부
  @required
  Future<void> purchaseProduct(String pid) async {
    try {
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: products[pid]);

      // android 이 경우 autoConsume를 true로 설정하지 않으면 소비성 결제가 되지 않는다
      final bool kAutoConsume = Platform.isIOS || true;
      await iap.value.buyConsumable(purchaseParam: purchaseParam, autoConsume: kAutoConsume);
      selectedProductID = pid;
    } catch (error) {
      writePaymentLog('purchaseProduct.error', error.toString());
      rethrow;
    }
  }

  /// 구매 세부 정보에 대한 업데이트 스트림을 수신하는 구독
  ///
  /// @return Future<void>
  Future<void> initialize() async {
    try {
      // 인앱 구매가 가능한지 체크
      if (await iap.value.isAvailable()) {
        // 구매 가능한 상품 목록 조회
        await fetchUserProducts();
        // 과거 구매 사용자 목록 조회
        await fetchPastPurchases();
        // 상품을 이미 구매했는지 체크
        verifyPurchases();

        // 구매 세부 정보에 대한 업데이트 스트림을 수신하는 구독
        subscription.value = iap.value.purchaseStream.listen((data) {
          // 구매 세부 정보를 업데이트
          purchases.addAll(data);
          // 상품을 이미 구매했는지 체크
          verifyPurchases();
        });
      }
    } catch (error) {
      writePaymentLog('initialize.error', error.toString());
      rethrow;
    }
  }

  @override
  Future<void> onInit() async {
    await initialize();
    await userInfoProvider.initUserInfo();
    super.onInit();
  }

  @override
  void onClose() {
    // 구독 해제
    subscription.value?.cancel();
    super.onClose();
  }
}
