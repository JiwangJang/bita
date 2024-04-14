import 'package:btia_app/view/cameraWidget/camera_body.dart';
import 'package:btia_app/view/cameraWidget/camera_bottom_bar.dart';
import 'package:btia_app/view/cameraWidget/camera_modal.dart';
import 'package:btia_app/view/cameraWidget/camera_util.dart';
import 'package:btia_app/view/cameraWidget/focus_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraUI extends StatelessWidget {
  const CameraUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) async {
              if (didPop) return;
              await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('주의'),
                      content: const Text('앱을 나가면 사진은 지워집니다.'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text('그래도 나갈래요'))
                      ],
                    );
                  });
            },
            child: const Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                CameraBody(),
                Positioned.fill(child: FocusIndicator()),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  child: CameraUtil(),
                ),
                Positioned(top: 20, child: CameraModal())
              ],
            ),
          ),
        ),
        CameraBottomBar(),
      ],
    );
  }
}
