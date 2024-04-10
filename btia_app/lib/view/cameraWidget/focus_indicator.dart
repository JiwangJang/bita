import 'dart:async';

import 'package:btia_app/model/photos_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FocusIndicator extends StatefulWidget {
  const FocusIndicator({super.key});

  @override
  State<FocusIndicator> createState() => _FocusIndicatorState();
}

class _FocusIndicatorState extends State<FocusIndicator> {
  double pointX = 0;
  double pointY = 0;
  bool isTouch = false;
  Timer? timerFunc;

  void onViewFinderTap(LongPressDownDetails details, BoxConstraints constraints,
      CameraController controller) {
    if (timerFunc != null) {
      timerFunc!.cancel();
    }
    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );

    setState(() {
      pointX = details.localPosition.dx - 32;
      pointY = details.localPosition.dy - 32;
      isTouch = true;
      timerFunc = Timer(const Duration(seconds: 1), () {
        setState(() {
          isTouch = false;
        });
        timerFunc = null;
      });
    });

    controller.setExposurePoint(offset);
    controller.setFocusPoint(offset);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosModel>(
      builder: (context, data, child) {
        return LayoutBuilder(builder: (context, constrain) {
          return Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onLongPressDown: (details) {
                  onViewFinderTap(details, constrain, data.controller);
                },
                onScaleUpdate: (details) async {
                  double scale = details.scale;
                  if (scale == 1.0) return;
                  if (scale < 1.0) await data.downZoomLevel();
                  if (scale > 1.0) await data.upZoomLevel();
                },
                child: Container(),
              ),
              Positioned(
                top: pointY,
                left: pointX,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isTouch ? 1 : 0,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(9999)),
                  ),
                ),
              )
            ],
          );
        });
      },
    );
  }
}
