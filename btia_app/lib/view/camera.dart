import 'dart:convert';

import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/cameraWidget/camera_permission.dart';
import 'package:btia_app/view/cameraWidget/camera_ui.dart';
import 'package:btia_app/view/cameraWidget/update_attract_modal.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;
  late Future<void> controllerFuture;
  bool isUpdate = false;
  bool isForce = false;
  bool modal = false;

  void modalOff() async {
    setState(() {
      modal = false;
    });
  }

  @override
  void initState() {
    super.initState();
    bool doCheck = Provider.of<PhotosModel>(context, listen: false).todayCheck;
    if (!doCheck) {
      versionChecker().then((value) {
        bool update = value['update'] as bool;
        bool force = value['force'] as bool;
        if (update && force) {
          setState(() {
            modal = true;
            isUpdate = true;
            isForce = true;
          });
        } else if (update) {
          setState(() {
            modal = true;
            isUpdate = true;
          });
        }
      });
    }

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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FutureBuilder(
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
                      color: Colors.white,
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
          Positioned.fill(
            child: UpdateAttractModal(
              isUpdate: isUpdate,
              isForce: isForce,
              modal: modal,
              modalOff: modalOff,
            ),
          )
        ],
      ),
    );
  }
}

Future<Map<String, bool>> versionChecker() async {
  try {
    var url = Uri.parse('https://btia.app/get-app-version');
    var res = await http.get(url);
    String latestVersion = jsonDecode(res.body)['version'];
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var [originMajor, originMinor, _] = packageInfo.version.split('.');
    var [latestMajor, latestMinor, _] = latestVersion.split('.');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (int.parse(originMajor) < int.parse(latestMajor)) {
      return {
        'update': true,
        'force': true,
      };
    } else if (int.parse(originMinor) < int.parse(latestMinor)) {
      prefs.setInt('checkDate', DateTime.now().day);
      return {
        'update': true,
        'force': false,
      };
    }
    prefs.setInt('checkDate', DateTime.now().day);
    return {
      'update': false,
      'force': false,
    };
  } catch (e) {
    return {
      'update': false,
      'force': false,
    };
  }
}
