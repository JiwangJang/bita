import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-9383754596343414~1585948099';
      // 우선은 테스트용으로 작성
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      // return '<YOUR_IOS_BANNER_AD_UNIT_ID>';
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      // 테스트용
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isIOS) {
      // 테스트용
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      // 테스트용
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      // 테스트용
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
