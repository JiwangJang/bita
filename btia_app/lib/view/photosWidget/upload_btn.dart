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
          height: 120,
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
                bool result = await data.uploadImages();
                late String mainMsg;
                late String subMsg;
                if (result) {
                  mainMsg = '업로드에 성공했습니다';
                  subMsg = '사이트에서 확인해보세요!';
                } else {
                  mainMsg = '업로드에 실패했습니다';
                  subMsg = '잠시후 다시 시도해보세요';
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
