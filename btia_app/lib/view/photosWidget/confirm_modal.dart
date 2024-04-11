import 'package:btia_app/model/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ConfirmModal extends StatelessWidget {
  const ConfirmModal({required this.cancelFunc, super.key});

  final Function cancelFunc;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.5),
      child: Center(
        child: Container(
          width: 268,
          height: 166,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(79, 79, 79, 1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(35, 33, 33, 1),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '주의',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          height: 1,
                          fontSize: 28),
                    ),
                    Text(
                      '삭제하시면 복구가 안됩니다\n그래도 삭제하시겠습니까?',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          height: 1,
                          letterSpacing: -0.5,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color.fromRGBO(79, 79, 79, 1),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<PhotosModel>(context, listen: false)
                              .removeImage();
                          cancelFunc();
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color.fromRGBO(79, 79, 79, 1),
                                width: 1,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          child: const Center(
                            child: Text(
                              '삭제',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 20, height: 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          cancelFunc();
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          child: const Center(
                            child: Text(
                              '취소',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20, height: 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
