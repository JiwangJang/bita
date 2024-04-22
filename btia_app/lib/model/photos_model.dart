import 'dart:io';
import 'package:btia_app/util/get_random_id.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
// ignore: implementation_imports
import 'package:http_parser/src/media_type.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PhotosModel extends ChangeNotifier {
  PhotosModel({required this.cameras, required this.code});
  final String code;
  final List<CameraDescription> cameras;
  final List<Map<String, dynamic>> photos = [];
  late CameraController controller;
  double minZoomLevel = 1.0;
  double maxZoomLevel = 1.0;
  double curZoomLevel = 1.0;
  bool isFlashAuto = false;
  bool isUploading = false;
  bool isTakingPicture = false;
  bool pictureModal = false;
  late String deleteTarget;
  int curUploadedImage = 0;

  void setController(CameraController newController) {
    controller = newController;
    controller.getMaxZoomLevel().then((value) => maxZoomLevel = value);
    controller.getMinZoomLevel().then((value) => minZoomLevel = value);
  }

  Future<void> takePicture() async {
    if (isTakingPicture) return;
    if (photos.length >= 100) {
      pictureModal = true;
      notifyListeners();
      Future.delayed(const Duration(seconds: 1)).then((value) {
        pictureModal = false;
        notifyListeners();
      });
      return;
    }
    isTakingPicture = true;

    XFile xFile;
    if (isFlashAuto) {
      await controller.setFlashMode(FlashMode.torch);
      xFile = await controller.takePicture();
      await controller.setFlashMode(FlashMode.off);
    } else {
      await controller.setFlashMode(FlashMode.off);
      xFile = await controller.takePicture();
    }
    await HapticFeedback.heavyImpact();
    Uint8List imageBytes = File(xFile.path).readAsBytesSync();
    String imageId = getRandomId();
    addImage(imageId, imageBytes);

    pictureModal = true;
    isTakingPicture = false;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      pictureModal = false;
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> downZoomLevel() async {
    curZoomLevel -= 0.03;
    if (curZoomLevel <= minZoomLevel) {
      curZoomLevel = minZoomLevel;
    }
    await controller.setZoomLevel(curZoomLevel);
    notifyListeners();
  }

  Future<void> upZoomLevel() async {
    curZoomLevel += 0.03;
    if (curZoomLevel >= maxZoomLevel) {
      curZoomLevel = maxZoomLevel;
    }
    await controller.setZoomLevel(curZoomLevel);
    notifyListeners();
  }

  Future<void> resetZoomLevel() async {
    curZoomLevel = 1.0;
    await controller.setZoomLevel(curZoomLevel);
    notifyListeners();
  }

  Future<void> toggleFlash() async {
    isFlashAuto = !isFlashAuto;
    notifyListeners();
  }

  void addImage(String imageId, Uint8List byteImage) {
    Map<String, dynamic> result = {};
    result['id'] = imageId;
    result['image'] = byteImage;
    photos.add(result);
    notifyListeners();
  }

  void removeImage() {
    photos.removeWhere((element) => element['id'] == deleteTarget);
    notifyListeners();
  }

  void setDeleteImage(String imageId) {
    deleteTarget = imageId;
  }

  Future<Map<String, dynamic>> uploadImages() async {
    if (photos.isEmpty) return {"success": false, "msg": "empty"};

    isUploading = true;
    List<String> uploadedKeys = [];
    notifyListeners();
    try {
      DateTime now = DateTime.now();
      String createdAt = DateFormat('yyyy-MM-dd').format(now);
      Uri url = Uri.parse(
          'https://btia.app/receive-image?userCode=$code&createdAt=$createdAt');
      MediaType contentType = MediaType('image', 'jpeg');
      curUploadedImage = 0;
      // 이 위까진 공통적으로 필요

      var request = http.MultipartRequest("POST", url);
      // int MAX_BODY_SIZE = 4300000;
      int MAX_BODY_SIZE = 300000;

      for (var imageInfo in photos) {
        int remain = MAX_BODY_SIZE - request.contentLength;
        var image = http.MultipartFile.fromBytes(
          'images',
          imageInfo['image'],
          contentType: contentType,
          filename: imageInfo['id'],
        );

        if (remain < image.length) {
          await Future.delayed(const Duration(seconds: 1)).then((value) {
            print('현재 파일길이 : ${request.files.length}');
            request.files.clear();
          });
        }
        print('업로드 파일길이 : ${request.files.length}');
        request.files.add(image);
        uploadedKeys.add(imageInfo['id']);
        curUploadedImage = uploadedKeys.length;
        notifyListeners();
      }

      await Future.delayed(const Duration(seconds: 1)).then((value) {
        print('현재 파일길이 : ${request.files.length}');
        curUploadedImage = request.files.length;
        notifyListeners();
        request.files.clear();
      });
      // var response = await request.send();
      isUploading = false;
      notifyListeners();
      // if (response.statusCode == 200) {
      //   photos.clear();
      //   return {"success": true};
      // } else if (response.statusCode == 413) {
      //   return {"success": false, "msg": "tooLarge"};
      // } else if (response.statusCode == 500) {
      //   return {"success": false, "msg": "serverErr"};
      // } else {
      //   return {"success": false, "msg": "appErr"};
      // }
      photos.clear();
      return {"success": true};
    } catch (e) {
      isUploading = false;
      photos.removeWhere((element) => uploadedKeys.contains(element['id']));
      notifyListeners();
      print("err $e");
      if (e is SocketException) {
        return {"success": false, "msg": "network"};
      }
      return {"success": false, "msg": "appErr"};
    }
  }

  Future<Map<String, dynamic>> selcetImages() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      List<XFile> images = await imagePicker.pickMultiImage(imageQuality: 50);
      if (photos.length + images.length > 5) {
        return {"success": false, "msg": "exceed"};
      }
      for (var image in images) {
        Uint8List imageBytes = File(image.path).readAsBytesSync();
        String imageId = getRandomId();
        addImage(imageId, imageBytes);
      }
      return {"success": true};
    } catch (e) {
      return {"success": false, "msg": "innerErr"};
    }
  }
}
