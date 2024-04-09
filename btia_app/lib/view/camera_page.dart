import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({required this.controller, super.key});

  final CameraController controller;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CameraPreview(controller),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            decoration: const BoxDecoration(color: Colors.black),
            height: 100,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.perm_media_outlined,
                  color: Colors.white,
                  size: 64,
                ),
                Icon(
                  Icons.vpn_key_outlined,
                  color: Colors.white,
                  size: 64,
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          child: CustomtakePictureBtn(
            controller: controller,
          ),
        )
      ],
    );
  }
}

class CustomtakePictureBtn extends StatelessWidget {
  const CustomtakePictureBtn({required this.controller, super.key});

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await controller.initialize();
        final img = await controller.takePicture();
      },
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 255, 107, 0),
                width: 8,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }
}
