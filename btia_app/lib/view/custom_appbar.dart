import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          color: Colors.black,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Positioned(
            left: 20,
            top: 20,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 48,
                color: Colors.white,
              ),
            ))
      ],
    );
  }
}
