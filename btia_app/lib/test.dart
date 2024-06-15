import 'dart:async';

Future<Map<String, dynamic>> fakeUploadImage(bool isSuccess, String msg) async {
  await Future.delayed(const Duration(seconds: 1));
  return {
    "success": isSuccess,
    "msg": msg,
  };
}
