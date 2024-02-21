import 'dart:io';

import 'package:flutter/foundation.dart';

class GoogleAdManager {
  // 리워드 광고 키값
  static String getRewardAdUnitId() {
    if (Platform.isAndroid) {
      return kReleaseMode
          ? 'ca-app-pub-9674517651101637/6682220543'
          : 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isIOS) {
      return kReleaseMode ? '' : 'ca-app-pub-3940256099942544/1712485313';
    } else {
      return 'none';
    }
  }
}
