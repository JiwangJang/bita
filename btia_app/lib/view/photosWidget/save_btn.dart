import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/layoutWidget/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveBtn extends StatelessWidget {
  const SaveBtn({required this.toastOnFunc, super.key});

  final Function toastOnFunc;

  @override
  Widget build(BuildContext context) {
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
          bgColor: const Color.fromARGB(255, 98, 98, 98),
          btnTitle: "저장",
          onTapFunc: () async {
            bool result = await Provider.of<PhotosModel>(context, listen: false)
                .saveImages();

            toastOnFunc(
              result ? '저장 성공' : '저장 실패',
              result ? '기기에 저장했습니다' : '기기에 저장하지 못했습니다',
            );
          },
        ),
      ),
    );
  }
}
