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
        Provider.of<PhotosModel>(context, listen: false).getCameras();
    _controller = CameraController(cameras.first, ResolutionPreset.max);
    controllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '출장사진 저장소',
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: FutureBuilder(
          future: controllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraUI(controller: _controller);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
