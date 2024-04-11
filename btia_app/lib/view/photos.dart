import 'package:btia_app/view/custom_appbar.dart';
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
            const Positioned.fill(child: PhotoListView()),
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
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedContainer(
                duration: const Duration(microseconds: 2000),
                curve: Curves.linear,
                transform: Matrix4.translationValues(0, toast ? 0 : -100, 0),
                onEnd: () {
                  Future.delayed(const Duration(seconds: 5))
                      .then((value) => toastOff());
                },
              ),
            ),
          ],
        ));
  }
}
