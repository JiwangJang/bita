import 'package:btia_app/model/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Photo extends StatelessWidget {
  const Photo({required this.imageInfo, super.key});

  final Map<String, dynamic> imageInfo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.memory(
          imageInfo['image'],
          fit: BoxFit.cover,
        )),
        Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                Provider.of<PhotosModel>(context, listen: false)
                    .removeImage(imageInfo['id']);
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(9999)),
                child: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.white,
                ),
              ),
            )),
      ],
    );
  }
}
