import 'dart:developer';

import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/payment.dart';
import 'package:find_friend/services/users.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/utils/googleAd.dart';
import 'package:find_friend/utils/message/common.dart';
import 'package:find_friend/utils/utils.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/support/supportButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  SupportScreenState createState() => SupportScreenState();
}

class SupportScreenState extends State<SupportScreen> {
  final UsersService _usersService = UsersService();
  final UserInfoProvider _userInfoProvider = Get.put(UserInfoProvider());

  bool isProcessing = false;

  @override
  void initState() {
    _userInfoProvider.initUserInfo();
    super.initState();
  }

  void _loadRewardAd() {
    setState(() {
      isProcessing = true;
    });
    RewardedAd.load(
      adUnitId: GoogleAdManager.getRewardAdUnitId(),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {
            log('Ad showed fullscreen content.', name: 'SupportScreenState.onAdShowedFullScreenContent');
          },
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {
            log('Ad impression.', name: 'SupportScreenState.onAdImpression');
          },
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
            // Dispose the ad here to free resources.
            log('Ad failed to show fullscreen content: $err', name: 'SupportScreenState.onAdFailedToShowFullScreenContent');
            ad.dispose();
          },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) async {
            // Dispose the ad here to free resources.
            log('Ad dismissed fullscreen content.', name: 'SupportScreenState.onAdDismissedFullScreenContent');

            final int point = _userInfoProvider.point.value + GOOGLE_REWARD_AD_ADD_POINT;
            final int exp = _userInfoProvider.exp.value + GOOGLE_REWARD_AD_ADD_EXP;
            await _usersService.updateUserPoint(point, exp);

            CustomSnackbar.showSuccessSnackbar(title: 'Success', message: '$GOOGLE_REWARD_AD_ADD_POINTポイントを獲得しました。');

            setState(() {
              isProcessing = false;
            });

            ad.dispose();
          },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {
            log('Ad clicked.', name: 'SupportScreenState.onAdClicked');
          });

          ad.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
              // Reward the user for watching an ad.
              log('User rewarded: ${rewardItem.amount}', name: 'SupportScreenState.onUserEarnedReward');
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('RewardedAd failed to load: $error', name: 'SupportScreenState.onAdFailedToLoad');
          setState(() {
            isProcessing = false;
          });
          CustomSnackbar.showErrorSnackbar(title: 'Error', error: Exception('広告ロードへ失敗しました。'));
          writeLogs(name: '_loadRewardAd.onAdFailedToLoad', error: error);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(InAppPurchaseService());
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        automaticallyImplyLeading: false,
        title: const CustomTextWidget(text: '支援ページ', kind: 'headTitle'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    CustomTextWidget(
                      text: 'このアプリで広告を提供しない理由は、皆さんの利用経験を最優先に考えているからです。',
                      kind: 'body',
                    ),
                    CustomTextWidget(
                      text: '広告なしで快適にアプリを利用していただけるように、皆さんが楽しく利用できる環境を作りたいと考えています。',
                      kind: 'body',
                    ),
                    CustomTextWidget(
                      text: 'ただし、アプリの運営、向上した機能の提供、より安定したサービスのためには、皆さんのサポートが不可欠です。',
                      kind: 'body',
                    ),
                    CustomTextWidget(
                      text: 'アプリの運営、アップデート、新機能追加には皆さんの協力とサポートが必要です',
                      kind: 'body',
                    ),
                    CustomTextWidget(
                      text: '一緒により良いアプリを作るために、支援お願いいたします。',
                      kind: 'body',
                    ),
                    CustomTextWidget(
                      text: 'このアプリの企画者はあなたです。',
                      kind: 'body',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _renderButtonWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderButtonWidget() {
    if (isProcessing) {
      return const Padding(
        padding: EdgeInsets.all(100),
        child: LinearProgressIndicator(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SupportButton(
          callBack: _loadRewardAd,
          text: '広告を見る (+$GOOGLE_REWARD_AD_ADD_POINTポイント)',
        ),
        SupportButton(
          callBack: () async {
            try {
              await InAppPurchaseService.to.purchaseProduct(PRODUCT_ID_100EN);
            } catch (e) {
              CustomSnackbar.showErrorSnackbar(title: 'Error', error: Exception(PAYMENT_MODULE_LOAD_ERROR));
            }
          },
          text: '100円支援 (+$PRODUCT_ID_100EN_POINTポイント)',
        ),
        SupportButton(
          callBack: () async {
            try {
              await InAppPurchaseService.to.purchaseProduct(PRODUCT_ID_500EN);
            } catch (e) {
              CustomSnackbar.showErrorSnackbar(title: 'Error', error: Exception(PAYMENT_MODULE_LOAD_ERROR));
            }
          },
          text: '500円支援 (+$PRODUCT_ID_500EN_POINTポイント)',
        ),
      ],
    );
  }
}
