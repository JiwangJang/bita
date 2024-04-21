import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/custom_appbar.dart';
import 'package:btia_app/view/layoutWidget/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Code extends StatelessWidget {
  const Code({super.key});

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
      body: Center(
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
    );
  }
}
