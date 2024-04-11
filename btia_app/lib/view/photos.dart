import 'package:btia_app/view/custom_appbar.dart';
import 'package:btia_app/view/photosWidget/confirm_modal.dart';
import 'package:btia_app/view/photosWidget/custom_toast.dart';
import 'package:btia_app/view/photosWidget/photolist_view.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(49, 51, 48, 1),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppbar(title: '사진들'),
        ),
        body: Stack(
          children: [
            Positioned.fill(
                child: PhotoListView(
              modalOnFunc: modalOn,
            )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: UploadBtn(
                toastOnFunc: toastOn,
              ),
            ),
            const Positioned.fill(
              child: UploadingIndicator(),
            ),
            Positioned.fill(
              child: modal
                  ? ConfirmModal(
                      cancelFunc: modalOff,
                    )
                  : const SizedBox(),
            ),
            AnimatedPositioned(
                left: 0,
                right: 0,
                bottom: toast ? 20 : -100,
                duration: const Duration(milliseconds: 500),
                onEnd: () {
                  Future.delayed(const Duration(seconds: 3))
                      .then((value) => toastOff());
                },
                curve: Curves.easeInOut,
                child: CustomToast(
                  mainMessage: toastMainMessage,
                  subMessage: toastSubMessage,
                )),
          ],
        ));
  }
}
