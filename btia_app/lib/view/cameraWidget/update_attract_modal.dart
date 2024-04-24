import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:url_launcher/url_launcher.dart';

class UpdateAttractModal extends StatelessWidget {
  const UpdateAttractModal({
    super.key,
    required this.isUpdate,
    required this.isForce,
    required this.modal,
    required this.modalOff,
  });

  final bool isUpdate;
  final bool isForce;
  final bool modal;
  final Function modalOff;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: modal,
      child: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.6)),
        child: Center(
          child: Container(
            width: 300,
            height: 180,
            padding:
                const EdgeInsets.only(top: 28, left: 28, right: 28, bottom: 16),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(35, 33, 33, 1),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '새로운 버전이 출시됐어요!',
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
                isForce
                    ? const Expanded(
                        child: Text(
                          '필수 업데이트입니다',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            height: 1.1,
                          ),
                        ),
                      )
                    : const Expanded(
                        child: Text(
                          '필수 업데이트는 아니나, 업데이트시 신규기능을 만나보실수 있습니다',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: -0.2,
                              height: 1.1),
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isForce
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () => modalOff(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: const Text(
                                '나중에하기',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                    GestureDetector(
                      onTap: () {
                        bool isAndroid = foundation.defaultTargetPlatform ==
                            foundation.TargetPlatform.android;
                        String storeUrl = isAndroid
                            ? 'https://play.google.com/store/apps/details?id=jiwang.btia_app'
                            : '앱스토어 링크';

                        // 안드로이드, 아이폰 구분하기
                        launchUrl(Uri.parse(storeUrl));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: const Text(
                          '업데이트하기',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
