import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.btnTitle,
      required this.bgColor,
      required this.onTapFunc,
      super.key});
  final String btnTitle;
  final Color bgColor;
  final void Function() onTapFunc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunc,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          btnTitle,
          style: const TextStyle(
            height: 1,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.05,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
