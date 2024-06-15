import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UtilModal extends StatelessWidget {
  const UtilModal({
    super.key,
    required this.title,
    required this.content,
    required this.modalOff,
  });

  final String title;
  final String content;
  final Function modalOff;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.6),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(35, 33, 33, 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                  child: Text(
                    content,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1.2,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    modalOff();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Color.fromARGB(255, 91, 91, 91)),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "확인",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
