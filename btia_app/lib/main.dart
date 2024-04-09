import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Camera(),
    ),
    GoRoute(
      path: '/photos',
      builder: (context, state) => const Camera(),
    ),
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final List<CameraDescription> cameras = await availableCameras();
  runApp(ChangeNotifierProvider(
    create: (context) => PhotosModel(cameras: cameras),
    child: MaterialApp.router(
      routerConfig: _router,
    ),
  ));
}
