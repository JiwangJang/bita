import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  const CustomToast(
      {required this.mainMessage, required this.subMessage, super.key});
  final String mainMessage;
  final String subMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(0, 0, 0, 0.7),
      ),
      child: Column(
        children: [
          Text(
            mainMessage,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          Text(
            subMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 1,
                letterSpacing: -0.05),
          ),
        ],
      ),
    );
  }
}
