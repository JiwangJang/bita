import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/cameraWidget/camera_ui.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;
  late Future<void> controllerFuture;

  @override
  void initState() {
    super.initState();
    final List<CameraDescription> cameras =
        Provider.of<PhotosModel>(context, listen: false).cameras;
    _controller = CameraController(cameras.first, ResolutionPreset.veryHigh,
        enableAudio: false);
    controllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controllerFuture,
      builder: (context, snapshot) {
        try {
          // 카메라 권한을 얻었을때
          if (snapshot.connectionState == ConnectionState.done) {
            Provider.of<PhotosModel>(context, listen: false)
                .setController(_controller);
            return const CameraUI();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        } catch (e) {
          if (e is CameraException) {
            // 카메라 권한이 없을때
            late String errorMsg;
            switch (e.code) {
              case 'CameraAccessDenied':
              case 'CameraAccessDeniedWithoutPrompt':
                errorMsg = '앱을 사용하시기 위해선, 카메라 권한 허용이 필수입니다. 설정에서 허용해주세요';
                break;
              case 'CameraAccessRestricted':
                errorMsg = '앱 사용이 불가능한 기기입니다';
                break;
              default:
                errorMsg = '에러코드 : ${e.code}. 개발자에게 보여주세요.';
            }

            return Center(
              child: Text(errorMsg),
            );
          } else {
            return const Center(
              child: Text('개발자에게 문의하세요'),
            );
          }
        }
      },
    );
  }
}
