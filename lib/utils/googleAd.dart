import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdManager {
  // 전면광고 키값
  String _getInterstitialAdUnitId() {
    if (Platform.isAndroid) {
      return kReleaseMode
          ? 'ca-app-pub-9674517651101637/2601030418'
          : 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return kReleaseMode
          ? 'ca-app-pub-9674517651101637/5672194112'
          : 'ca-app-pub-3940256099942544/4411468910';
    } else {
      return 'none';
    }
  }

  // 전면광고 로드
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _getInterstitialAdUnitId(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    ).catchError(
        (error) => debugPrint('InterstitialAd failed to load: $error'));
  }
}
