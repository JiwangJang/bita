import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/cameraWidget/camera_permission.dart';
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
    Provider.of<PhotosModel>(context, listen: false).controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: controllerFuture,
        builder: (futureContext, snapshot) {
          try {
            if (snapshot.connectionState == ConnectionState.done) {
              // 카메라 권한이 막혀있을때
              if (snapshot.error is CameraException) {
                CameraException e = snapshot.error as CameraException;
                return CameraPermission(errCode: e.code);
              }
              // 카메라 권한이 있을때
              Provider.of<PhotosModel>(context, listen: false)
                  .setController(_controller);
              return const CameraUI();
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
          } catch (e) {
            return const Center(
              child: Text('개발자에게 문의하세요'),
            );
          }
        },
      ),
    );
  }
}
