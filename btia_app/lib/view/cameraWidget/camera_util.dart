import 'package:btia_app/model/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraUtil extends StatelessWidget {
  const CameraUtil({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosModel>(builder: (_, data, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // 플래시 온오프
            Container(
              height: 76,
              width: 76,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                  borderRadius: BorderRadius.circular(999)),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  await data.toggleFlash();
                },
                child: Icon(
                  data.isFlashAuto ? Icons.flash_auto : Icons.flash_off,
                  size: 44,
                  color: Colors.white,
                ),
              ),
            ),
            // 배율초기화
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: Colors.black,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  await data.resetZoomLevel();
                },
                child: const Text(
                  '배율초기화',
                  style: TextStyle(
                      fontSize: 24,
                      letterSpacing: -0.05,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
            // 현재배율
            Container(
              width: 76,
              height: 76,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                  borderRadius: BorderRadius.circular(999)),
              child: Text(
                "${data.curZoomLevel.toStringAsFixed(1)}x",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    decoration: TextDecoration.none,
                    letterSpacing: -3),
              ),
            ),
          ],
        ),
      );
    });
  }
}
