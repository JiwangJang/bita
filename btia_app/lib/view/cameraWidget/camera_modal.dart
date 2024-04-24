import 'package:btia_app/model/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraModal extends StatelessWidget {
  const CameraModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosModel>(builder: (context, data, child) {
      return AnimatedOpacity(
        opacity: data.pictureModal ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(999),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Text(
            data.photos.length > data.MAX_IMAGE_COUNT
                ? "최대 ${data.MAX_IMAGE_COUNT}장까지 촬영가능합니다"
                : '사진을 촬영했습니다',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.05,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      );
    });
  }
}
