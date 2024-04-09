import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import './view/camera_page.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();

  runApp(const Camera());
}

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
    _controller = CameraController(_cameras.first, ResolutionPreset.max);
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
              return CameraPage(controller: _controller);
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
