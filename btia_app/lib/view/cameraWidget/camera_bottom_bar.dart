import 'dart:async';
import 'package:btia_app/model/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:native_camera_sound/native_camera_sound.dart';
import 'package:provider/provider.dart';

class CameraBottomBar extends StatelessWidget {
  const CameraBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Consumer<PhotosModel>(
        builder: (context, data, child) {
          return Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.push('/photos'),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(57, 57, 57, 1),
                          ),
                          width: 64,
                          height: 64,
                          clipBehavior: Clip.hardEdge,
                          child: data.photos.isEmpty
                              ? const SizedBox()
                              : Image.memory(data.photos.last['image'],
                                  fit: BoxFit.cover),
                        ),
                        const Text(
                          "사진보기",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomtakePictureBtn(
                    pictureFunc: data.takePicture,
                  ),
                  GestureDetector(
                    onTap: () => context.push('/code'),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.vpn_key_rounded,
                          size: 64,
                          color: Colors.white,
                        ),
                        Text(
                          "코드보기",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomtakePictureBtn extends StatelessWidget {
  const CustomtakePictureBtn({required this.pictureFunc, super.key});
  final Future<void> Function() pictureFunc;

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosModel>(builder: (_, photoData, child) {
      return GestureDetector(
        onTap: () async {
          NativeCameraSound.playShutter();
          await pictureFunc();
        },
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(255, 255, 107, 0),
                  width: 5,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(100),
              color: const Color.fromARGB(255, 255, 255, 255)),
        ),
      );
    });
  }
}
