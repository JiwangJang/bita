import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  const CustomToast(
      {required this.mainMessage, required this.subMessage, super.key});
  final String mainMessage;
  final String subMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          color: const Color.fromRGBO(255, 166, 102, 1)),
      child: Column(
        children: [
          Text(mainMessage),
          Text(subMessage),
        ],
      ),
    );
  }
}
