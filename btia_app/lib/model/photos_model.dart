import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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

  void setController(CameraController newController) {
    controller = newController;
    controller.getMaxZoomLevel().then((value) => maxZoomLevel = value);
    controller.getMinZoomLevel().then((value) => minZoomLevel = value);
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
    curZoomLevel = minZoomLevel;
    await controller.setZoomLevel(minZoomLevel);
    notifyListeners();
  }

  Future<void> toggleFlash() async {
    if (isFlashAuto) {
      await controller.setFlashMode(FlashMode.off);
    } else {
      await controller.setFlashMode(FlashMode.auto);
    }
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

  void removeImage(String imageId) {
    photos.removeWhere((element) => element['id'] == imageId);
    notifyListeners();
  }

  Future<bool> uploadImages() async {
    isUploading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    isUploading = false;
    notifyListeners();
    return true;
  }
}
