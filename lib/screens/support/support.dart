import 'dart:developer';

import 'package:find_friend/services/system.dart';
import 'package:find_friend/services/users.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/utils/googleAd.dart';
import 'package:find_friend/utils/utils.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/support/supportButton.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  SupportScreenState createState() => SupportScreenState();
}

class SupportScreenState extends State<SupportScreen> {
  final UsersService _usersService = UsersService();
  final SystemService _systemService = SystemService();

  bool isProcessing = false;

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
            log('Ad showed fullscreen content.',
                name: 'SupportScreenState.onAdShowedFullScreenContent');
          },
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {
            log('Ad impression.', name: 'SupportScreenState.onAdImpression');
          },
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
            // Dispose the ad here to free resources.
            log('Ad failed to show fullscreen content: $err',
                name: 'SupportScreenState.onAdFailedToShowFullScreenContent');
            ad.dispose();
          },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
            // Dispose the ad here to free resources.
            log('Ad dismissed fullscreen content.',
                name: 'SupportScreenState.onAdDismissedFullScreenContent');

            _systemService.getAuthKey().then((uuid) {
              _usersService.getUserInfoData(uuid).then((res) async {
                await _usersService.updateUserPoint(
                    res.data['point'] + GOOGLE_REWARD_AD_ADD_POINT);

                CustomSnackbar.showSuccessSnackbar(
                    title: 'Success',
                    message: '$GOOGLE_REWARD_AD_ADD_POINTポイントを獲得しました。');
              });
            });

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
              log('User rewarded: ${rewardItem.amount}',
                  name: 'SupportScreenState.onUserEarnedReward');
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('RewardedAd failed to load: $error',
              name: 'SupportScreenState.onAdFailedToLoad');
          CustomSnackbar.showErrorSnackbar(
              title: 'Error', error: Exception('広告ロードへ失敗しました。'));
          writeLogs(name: '_loadRewardAd.onAdFailedToLoad', error: error);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      text:
                          '広告なしで快適にアプリを利用していただけるように、皆さんが楽しく利用できる環境を作りたいと考えています。',
                      kind: 'body',
                    ),
                    CustomTextWidget(
                      text:
                          'ただし、アプリの運営、向上した機能の提供、より安定したサービスのためには、皆さんのサポートが不可欠です。',
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
          callBack: () {
            CustomSnackbar.showSuccessSnackbar(
                title: '100円支援 click', message: 'show me the money');
          },
          text: '100円支援 (+$PAYMENT_100_POINTポイント)',
        ),
        SupportButton(
          callBack: () {
            CustomSnackbar.showSuccessSnackbar(
                title: '500円支援 click', message: 'show me the money');
          },
          text: '500円支援 (+$PAYMENT_500_POINTポイント)',
        ),
        SupportButton(
          callBack: () {
            CustomSnackbar.showSuccessSnackbar(
                title: '1000円支援 click', message: 'show me the money');
          },
          text: '1000円支援 (+$PAYMENT_1000_POINTポイント)',
        ),
        SupportButton(
          callBack: () {
            CustomSnackbar.showSuccessSnackbar(
                title: '5000円支援 click', message: 'show me the money');
          },
          text: '5000円支援 (+$PAYMENT_5000_POINTポイント)',
        ),
        SupportButton(
          callBack: () {
            CustomSnackbar.showSuccessSnackbar(
                title: '10000円支援 click', message: 'show me the money');
          },
          text: '1万円支援 (+$PAYMENT_10000_POINTポイント)',
        )
      ],
    );
  }
}
