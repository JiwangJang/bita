import 'dart:io';
import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/custom_appbar.dart';
import 'package:btia_app/view/layoutWidget/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:btia_app/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Code extends StatefulWidget {
  const Code({super.key});

  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  final TextStyle bodyStyle = const TextStyle(
    color: Colors.white,
    fontSize: 24,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  final TextStyle buttonStyle = const TextStyle(
    color: Colors.white,
    fontSize: 24,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w800,
    height: 1,
  );

  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print("failed to load ad");
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String code = Provider.of<PhotosModel>(context).code;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(49, 51, 48, 1),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppbar(
            title: '나의코드',
          )),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  code,
                  style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                      height: 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '저희 웹사이트 접속시 입력하시면,\n업로드한 사진들을 보실 수 있습니다\n타인에게 노출하지 마세요',
                    style: bodyStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                CustomButton(
                  btnTitle: '웹사이트 방문',
                  bgColor: const Color.fromRGBO(255, 107, 0, 1),
                  onTapFunc: () =>
                      launchUrl(Uri.parse('https://btia.app?userCode=$code')),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                if (Platform.isAndroid) {
                  launchUrl(
                      Uri.parse("market://details?id=quote.post.c90cb169"));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.6)),
                          child: Center(
                            child: Container(
                              width: 300,
                              height: 180,
                              padding: const EdgeInsets.only(
                                  top: 28, left: 28, right: 28, bottom: 16),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(35, 33, 33, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '앱스토어 출시 준비중입니다.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      height: 1.1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: const Text(
                                          '확인',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              },
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage("assets/quote-post-ads.png"),
                  ),
                ),
              ),
            ),
          ),
          if (_bannerAd != null)
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            )
        ],
      ),
    );
  }
}
