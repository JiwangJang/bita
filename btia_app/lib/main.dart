import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/camera.dart';
import 'package:btia_app/view/photos.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Camera(),
    ),
    GoRoute(
      path: '/photos',
      builder: (context, state) => const Photos(),
    ),
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleFonts.pendingFonts();
  final List<CameraDescription> cameras = await availableCameras();
  runApp(ChangeNotifierProvider(
    create: (context) => PhotosModel(cameras: cameras),
    child: SafeArea(
      child: MaterialApp.router(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.noScaling),
            child: child!,
          );
        },
        title: '출장사진 저장소',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Pretendard',
        ),
        routerConfig: _router,
      ),
    ),
  ));
}
