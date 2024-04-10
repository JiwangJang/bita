import 'dart:typed_data';

import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  const Photo({required this.image, super.key});

  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.memory(
          image,
          fit: BoxFit.cover,
        )),
        Positioned(
            top: 8,
            right: 8,
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
            )),
      ],
    );
  }
}
