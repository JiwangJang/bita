import 'dart:io';

// 테스트용
class AdHelper {
  // 배너광고
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // 전면광고
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}

// 실전용
// class AdHelper {
//   // 배너광고
//   static String get bannerAdUnitId {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-9383754596343414/2603516295';
//     } else if (Platform.isIOS) {
//       return 'ca-app-pub-9383754596343414/1983024609';
//     } else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }

//   // 전면광고
//   static String get interstitialAdUnitId {
//     if (Platform.isAndroid) {
//       return "ca-app-pub-9383754596343414/4649211235";
//     } else if (Platform.isIOS) {
//       return "ca-app-pub-9383754596343414/1903133551";
//     } else {
//       throw UnsupportedError("Unsupported platform");
//     }
//   }
// }


/**
 * 안드로이드 
 * 전면 ca-app-pub-9383754596343414/4649211235
 * 배너 ca-app-pub-9383754596343414/2603516295
 * 
 * 아이폰
 * 전면 ca-app-pub-9383754596343414/1903133551
 * 배너 ca-app-pub-9383754596343414/1983024609
 */