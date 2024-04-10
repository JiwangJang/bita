import 'package:btia_app/model/photos_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraBody extends StatelessWidget {
  const CameraBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosModel>(
      builder: (context, data, child) {
        return CameraPreview(
          data.controller,
        );
      },
    );
  }
}
