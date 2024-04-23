import 'package:flutter/material.dart';

class UpdateAttractModal extends StatelessWidget {
  const UpdateAttractModal({
    super.key,
    required this.isUpdate,
    required this.isForce,
    required this.modal,
    required this.modalOff,
  });

  final bool isUpdate;
  final bool isForce;
  final bool modal;
  final Function modalOff;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: modal ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.6)),
        child: Center(
          child: Container(
            width: 300,
            height: 200,
            padding:
                const EdgeInsets.only(top: 28, left: 28, right: 28, bottom: 16),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '새로운 버전이 출시됐어요!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                isForce
                    ? const Text(
                        '필수 업데이트입니다',
                        style: TextStyle(
                            color: Colors.black, fontSize: 18, height: 1.1),
                      )
                    : const Expanded(
                        child: Text(
                          '필수 업데이트는 아니나, 업데이트시 신규기능을 만나보실수 있습니다',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: -0.2,
                              height: 1.1),
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isForce
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () => modalOff(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: const Text(
                                '나중에하기',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              ),
                            ),
                          ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: const Text(
                        '업데이트하기',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
