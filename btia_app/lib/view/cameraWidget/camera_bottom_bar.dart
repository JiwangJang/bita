import 'dart:io';
import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/util/get_random_id.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CameraBottomBar extends StatelessWidget {
  const CameraBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Consumer<PhotosModel>(builder: (context, data, child) {
        CameraController controller = data.controller;
        return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.push('/photos'),
                child: Container(
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
              ),
              CustomtakePictureBtn(controller: controller),
              GestureDetector(
                onTap: () => context.push('/code'),
                child: const Icon(
                  Icons.vpn_key_rounded,
                  size: 64,
                  color: Colors.white,
                ),
              )
            ]);
      }),
    );
  }
}

class CustomtakePictureBtn extends StatefulWidget {
  const CustomtakePictureBtn({required this.controller, super.key});
  final CameraController controller;

  @override
  State<CustomtakePictureBtn> createState() => _CustomtakePictureBtnState();
}

class _CustomtakePictureBtnState extends State<CustomtakePictureBtn> {
  bool isPicture = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosModel>(builder: (_, photoData, child) {
      return GestureDetector(
        onTap: () async {
          if (isPicture) return;
          setState(() {
            isPicture = true;
          });
          HapticFeedback.heavyImpact();
          await widget.controller.initialize();
          XFile xFile = await widget.controller.takePicture();
          setState(() {
            isPicture = false;
          });
          String path = xFile.path;
          Uint8List byteImage = await File(path).readAsBytes();
          String imageId = getRandomId();
          photoData.addImage(imageId, byteImage);
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
