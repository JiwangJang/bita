import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/photosWidget/photo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoListView extends StatelessWidget {
  const PhotoListView(
      {required this.modalOnFunc, required this.toastOn, super.key});

  final Function modalOnFunc;
  final Function toastOn;

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosModel>(builder: (_, photoData, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            const Text(
              '사진업로드는 한번에 최대 5장까지 가능합니다',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: -0.05,
                  fontWeight: FontWeight.w800),
            ),
            Text(
              '현재 : ${photoData.photos.length}/5',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: -0.05,
              ),
            ),
            GestureDetector(
              onTap: () async {
                Map<String, dynamic> result = await photoData.selcetImages();
                if (result['success']) {
                  toastOn("성공", '사진을 불러오는데 성공했습니다');
                } else {
                  if (result['msg'] == 'exceed') {
                    toastOn('사진 갯수 초과', '5장을 초과할 수 없습니다');
                  } else {
                    toastOn('의문의 에러', "계속되면 개발자에게 문의해주세요");
                  }
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(83, 83, 83, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  '갤러리에서 추가하기',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  padding: const EdgeInsets.only(top: 10, bottom: 120),
                  itemCount: photoData.photos.length,
                  itemBuilder: (context, idx) {
                    return Photo(
                        imageInfo: photoData.photos[idx],
                        modalOnFunc: modalOnFunc);
                  }),
            ),
          ],
        ),
      );
    });
  }
}
