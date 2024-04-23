import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/layoutWidget/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadBtn extends StatelessWidget {
  const UploadBtn({required this.toastOnFunc, super.key});

  final Function toastOnFunc;

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
                Map<String, dynamic> result = await data.uploadImages();
                late String mainMsg;
                late String subMsg;
                if (result['success']) {
                  mainMsg = '업로드 성공';
                  subMsg = '사이트에서 확인해보세요!';
                } else {
                  switch (result['msg']) {
                    case 'empty':
                      subMsg = '우선 촬영부터 해주세요';
                      break;
                    case 'network':
                      subMsg = '인터넷연결을 확인해주세요';
                      break;
                    case 'appErr':
                      subMsg = '개발자에게 문의해주세요';
                      break;
                    case 'serverErr':
                      subMsg = '잠시후 다시 시도해보세요';
                      break;
                    case 'tooLarge':
                      subMsg = '너무 커서 보내지 못한\n사진을 남겼습니다';
                    default:
                      subMsg = '잠시후 다시 시도해보세요';
                      break;
                  }
                  mainMsg = '업로드 실패';
                }
                toastOnFunc(mainMsg, subMsg);
              },
            ),
          ),
        );
      },
    );
  }
}
