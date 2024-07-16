import 'dart:io';

import 'package:btia_app/ad_helper.dart';
import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/layoutWidget/button.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class UploadBtn extends StatelessWidget {
  const UploadBtn({required this.modalOn, super.key});

  final Function modalOn;

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosModel>(
      builder: (context, data, child) {
        return Container(
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
              btnTitle: "업로드",
              onTapFunc: () async {
                if (Platform.isAndroid) {
                  await InterstitialAd.load(
                    adUnitId: AdHelper.interstitialAdUnitId,
                    request: const AdRequest(),
                    adLoadCallback: InterstitialAdLoadCallback(
                      onAdLoaded: (ad) {
                        ad.show();
                      },
                      onAdFailedToLoad: (err) {
                        return;
                      },
                    ),
                  );
                }

                if (data.isAdding) {
                  return;
                }
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
                modalOn(title, content);
              },
            ),
          ),
        );
      },
    );
  }
}
