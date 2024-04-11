import 'package:btia_app/view/cameraWidget/camera_body.dart';
import 'package:btia_app/view/cameraWidget/camera_bottom_bar.dart';
import 'package:btia_app/view/cameraWidget/camera_util.dart';
import 'package:btia_app/view/cameraWidget/focus_indicator.dart';
import 'package:flutter/material.dart';

class CameraUI extends StatelessWidget {
  const CameraUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              CameraBody(),
              Positioned.fill(child: FocusIndicator()),
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: CameraUtil(),
              ),
            ],
          ),
        ),
        CameraBottomBar(),
      ],
    );
  }
}
