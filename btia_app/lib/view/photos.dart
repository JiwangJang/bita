import 'dart:async';

import 'package:btia_app/view/custom_appbar.dart';
import 'package:btia_app/view/photosWidget/adding_indicator.dart';
import 'package:btia_app/view/photosWidget/confirm_modal.dart';
import 'package:btia_app/view/photosWidget/custom_toast.dart';
import 'package:btia_app/view/photosWidget/photolist_view.dart';
import 'package:btia_app/view/photosWidget/save_btn.dart';
import 'package:btia_app/view/photosWidget/upload_btn.dart';
import 'package:btia_app/view/photosWidget/uploading_indicator.dart';
import 'package:flutter/material.dart';

class Photos extends StatefulWidget {
  const Photos({super.key});

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  bool toast = false;
  bool modal = false;
  String toastMainMessage = '';
  String toastSubMessage = '';

  void toastOn(String mainMessage, String subMessage) {
    setState(() {
      toast = true;
      toastMainMessage = mainMessage;
      toastSubMessage = subMessage;
    });
  }

  void toastOff() {
    setState(() {
      toast = false;
    });
  }

  void modalOn() {
    setState(() {
      modal = true;
    });
  }

  void modalOff() {
    setState(() {
      modal = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(49, 51, 48, 1),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppbar(title: '사진들'),
        ),
        body: Stack(
          children: [
            // 사진 목록(갤러리추가버튼도 있음)
            Positioned.fill(
                child: PhotoListView(
              modalOnFunc: modalOn,
              toastOn: toastOn,
            )),
            // 업로드버튼
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  SaveBtn(
                    toastOnFunc: toastOn,
                  ),
                  UploadBtn(
                    toastOnFunc: toastOn,
                  ),
                ],
              ),
            ),
            // 업로딩 인디케이터
            const Positioned.fill(
              child: UploadingIndicator(),
            ),
            // 사진추가 인디케이터
            const Positioned.fill(
              child: AddingIndicator(),
            ),
            // 삭제할 때 모달
            Positioned.fill(
              child: modal
                  ? ConfirmModal(
                      cancelFunc: modalOff,
                    )
                  : const SizedBox(),
            ),
            // 커스텀 토스트
            AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: toast ? 80 : -100,
              duration: const Duration(milliseconds: 500),
              onEnd: () {
                Timer(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    toastOff();
                  }
                });
              },
              curve: Curves.easeInOut,
              child: CustomToast(
                mainMessage: toastMainMessage,
                subMessage: toastSubMessage,
              ),
            ),
          ],
        ));
  }
}
