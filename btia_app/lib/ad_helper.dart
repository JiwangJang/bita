import 'dart:io';

// 테스트용
// class AdHelper {
//   // 배너광고
//   static String get bannerAdUnitId {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-3940256099942544/6300978111';
//     } else if (Platform.isIOS) {
//       return 'ca-app-pub-3940256099942544/2934735716';
//     } else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }

//   // 전면광고
//   static String get interstitialAdUnitId {
//     if (Platform.isAndroid) {
//       return "ca-app-pub-3940256099942544/1033173712";
//     } else if (Platform.isIOS) {
//       return "ca-app-pub-3940256099942544/4411468910";
//     } else {
//       throw UnsupportedError("Unsupported platform");
//     }
//   }
// }

// 실전용
class AdHelper {
  // 배너광고
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7430534869579134/9759162561';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // 전면광고
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7430534869579134/5028730009";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
