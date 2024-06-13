import 'dart:io';
import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/util/id_generator.dart';
import 'package:btia_app/view/camera.dart';
import 'package:btia_app/view/code.dart';
import 'package:btia_app/view/photos.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    GoRoute(
      path: '/code',
      builder: (context, state) => const Code(),
    ),
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  final String path = directory.path;
  final File file = File('$path/user_code.txt');
  late String code;
  if (file.existsSync()) {
    code = file.readAsStringSync();
  } else {
    file.createSync();
    code = idGenerator();
    file.writeAsStringSync(code);
  }

  MobileAds.instance.initialize();
  // 세로모드고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 업데이트 유도 모달이 필요한지
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int? checkDate = prefs.getInt('checkDate');
  final int today = DateTime.now().day;
  bool todayCheck = today == checkDate;

  final List<CameraDescription> cameras = await availableCameras();
  runApp(ChangeNotifierProvider(
    create: (context) =>
        PhotosModel(cameras: cameras, code: code, todayCheck: todayCheck),
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
