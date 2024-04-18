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

  void setController(CameraController newController) {
    controller = newController;
    controller.getMaxZoomLevel().then((value) => maxZoomLevel = value);
    controller.getMinZoomLevel().then((value) => minZoomLevel = value);
  }

  Future<void> takePicture() async {
    if (isTakingPicture) return;
    if (photos.length >= 10) {
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
    notifyListeners();
    try {
      DateTime now = DateTime.now();
      String createdAt = DateFormat('yyyy-MM-dd').format(now);
      Uri url = Uri.parse(
          'https://btia.app/receive-image?userCode=$code&createdAt=$createdAt');
      var request = http.MultipartRequest("POST", url);
      MediaType contentType = MediaType('image', 'jpeg');
      for (var imageInfo in photos) {
        var image = http.MultipartFile.fromBytes(
          'images',
          imageInfo['image'],
          contentType: contentType,
          filename: imageInfo['id'],
        );
        request.files.add(image);
      }
      var response = await request.send();

      isUploading = false;
      notifyListeners();
      if (response.statusCode == 200) {
        photos.clear();
        return {"success": true};
      } else if (response.statusCode == 500) {
        return {"success": false, "msg": "serverErr"};
      } else {
        return {"success": false, "msg": "appErr"};
      }
    } catch (e) {
      isUploading = false;
      notifyListeners();
      if (e is SocketException) {
        return {"success": false, "msg": "network"};
      }
      return {"success": false, "msg": "appErr"};
    }
  }

  Future<Map<String, dynamic>> selcetImages() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      List<XFile> images = await imagePicker.pickMultiImage();
      if (photos.length + images.length >= 10) {
        return {"success": false, "msg": "exceed"};
      }
      for (var image in images) {
        Uint8List imageBytes = File(image.path).readAsBytesSync();
        String imageId = getRandomId();
        addImage(imageId, imageBytes);
      }
      return {"success": true};
    } catch (e) {
      print(e);
      return {"success": false, "msg": "innerErr"};
    }
  }
}
