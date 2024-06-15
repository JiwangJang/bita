import 'dart:convert';

import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/cameraWidget/camera_permission.dart';
import 'package:btia_app/view/cameraWidget/camera_ui.dart';
import 'package:btia_app/view/cameraWidget/update_attract_modal.dart';
import 'package:btia_app/view/layoutWidget/util_modal.dart';
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
  bool updateAttractModal = false;
  bool adNFmodal = false;
  bool onBoardingModal = false;

  void updateAttractModalOff() {
    setState(() {
      updateAttractModal = false;
    });
  }

  void adNFmodalOff() {
    setState(() {
      adNFmodal = false;
    });

    SharedPreferences.getInstance().then((pref) {
      pref.setBool("notified", true);
    });
  }

  void onBoardingModalOff() {
    setState(() {
      onBoardingModal = false;
    });

    SharedPreferences.getInstance().then((pref) {
      pref.setBool("onBoarding", true);
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
            updateAttractModal = true;
            isUpdate = true;
            isForce = true;
          });
        } else if (update) {
          setState(() {
            updateAttractModal = true;
            isUpdate = true;
          });
        }
      });
    }

    SharedPreferences.getInstance().then((pref) {
      bool? isOnboarding = pref.getBool("onBoarding");
      bool? isNotified = pref.getBool("notified");

      // 처음인지 확인
      if (isOnboarding == true) {
        return;
      } else {
        setState(() {
          onBoardingModal = true;
        });
      }
      // 광고 공지 확인했는지 확인
      if (isNotified == true) {
        return;
      } else {
        setState(() {
          adNFmodal = true;
        });
      }
    });

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
              modal: updateAttractModal,
              modalOff: updateAttractModalOff,
            ),
          ),
          if (adNFmodal)
            Positioned.fill(
              child: UtilModal(
                title: "공지사항",
                content:
                    "사용자 증가에 따른 서버비용 증가로 인해, 불가피하게 앱 내 광고를 달게 되었습니다. 넓은 아량으로 이해해주시기 바라며 광고를 클릭해야지만 저에게 돈이 들어오니 한 번씩 클릭부탁드립니다. 당신의 클릭 한 번이 다른이들이 이 서비스를 더 오래 이용할 수 있게 해줍니다.",
                modalOff: adNFmodalOff,
              ),
            ),
          if (onBoardingModal)
            Positioned.fill(
              child: UtilModal(
                title: "사용간 주의사항",
                content:
                    "이 어플로 촬영한 사진은 앱 종료시 영구 삭제 되오니, 서버에 업로드 하시거나, 저장 기능을 활용해 기기에 저장해주시기 바랍니다.",
                modalOff: onBoardingModalOff,
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
    } else if (int.parse(originMinor) < int.parse(latestMinor) &&
        int.parse(originMajor) < int.parse(latestMajor)) {
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
