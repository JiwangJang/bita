import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PhotosModel extends ChangeNotifier {
  PhotosModel({required this.cameras});

  final List<CameraDescription> cameras;
  final List<XFile> photos = [];

  List<CameraDescription> getCameras() => cameras;

  // 임시저장사진목록 불러오는거
  List<XFile> getPhotos() => photos;

  // 임시저장사진에 넣는거
  void addPhotos(XFile photo) {
    photos.add(photo);
  }
}
