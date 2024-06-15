import 'package:btia_app/ad_helper.dart';
import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/layoutWidget/button.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class UploadBtn extends StatefulWidget {
  const UploadBtn({required this.modalOn, super.key});

  final Function modalOn;

  @override
  State<UploadBtn> createState() => _UploadBtnState();
}

class _UploadBtnState extends State<UploadBtn> {
  InterstitialAd? _interstitialAd;

  Future getInterstitialAdId() async {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void initState() {
    getInterstitialAdId();
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build!");
    return Consumer<PhotosModel>(
      builder: (context, data, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _interstitialAd != null ? 1 : 0.4,
          child: Container(
            height: 90,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(49, 51, 48, 1),
                    Color.fromRGBO(49, 51, 48, 0)
                  ]),
            ),
            child: Center(
              child: CustomButton(
                bgColor: const Color.fromRGBO(255, 107, 0, 1),
                btnTitle: _interstitialAd != null ? "업로드" : "준비중",
                onTapFunc: () async {
                  if (data.isAdding || _interstitialAd == null) {
                    return;
                  }

                  _interstitialAd?.show();
                  getInterstitialAdId();
                  Map<String, dynamic> result = await data.uploadImages();

                  late String title;
                  late String content;
                  if (result['success']) {
                    title = '업로드 성공';
                    content = '사이트에서 확인해보세요!';
                  } else {
                    switch (result['msg']) {
                      case 'empty':
                        content = '우선 촬영부터 해주세요';
                        break;
                      case 'network':
                        content = '인터넷연결을 확인해주세요';
                        break;
                      case 'appErr':
                        content = '개발자에게 문의해주세요';
                        break;
                      case 'serverErr':
                        content = '잠시후 다시 시도해보세요';
                        break;
                      case 'tooLarge':
                        content = '너무 커서 보내지 못한\n사진을 남겼습니다';
                      default:
                        content = '잠시후 다시 시도해보세요';
                        break;
                    }
                    title = '업로드 실패';
                  }
                  widget.modalOn(title, content);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
