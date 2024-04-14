import 'package:flutter/material.dart';

class CameraPermission extends StatelessWidget {
  const CameraPermission({required this.errCode, super.key});
  final String errCode;

  @override
  Widget build(BuildContext context) {
    late String errorMsg;
    switch (errCode) {
      case 'CameraAccessDenied':
      case 'CameraAccessDeniedWithoutPrompt':
        errorMsg = '앱을 사용하시기 위해선\n카메라 권한 허용이 필수입니다.\n설정에서 허용해주세요';
        break;
      case 'CameraAccessRestricted':
        errorMsg = '앱 사용이 불가능한 기기입니다';
        break;
      default:
        errorMsg = '에러코드 : $errCode. 개발자에게 보여주세요.';
    }
    return Container(
      color: const Color.fromRGBO(49, 51, 48, 1),
      child: Center(
        child: Text(
          errorMsg,
          textAlign: TextAlign.center,
          style: const TextStyle(
            letterSpacing: -1,
            height: 1,
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
