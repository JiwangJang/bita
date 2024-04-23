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
    return Consumer<PhotosModel>(builder: (_, data, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              '개당 최대 4.3MB, ${data.MAX_IMAGE_COUNT}장까지 가능합니다',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: -0.05,
                  height: 1.2,
                  fontWeight: FontWeight.w800),
            ),
            const Text(
              '어플로 촬영하신 사진은 어플종료시 복구할 수 없습니다',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.2,
                letterSpacing: -0.05,
              ),
            ),
            Text(
              '현재 : ${data.photos.length}/${data.MAX_IMAGE_COUNT}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: -0.05,
                  height: 1.2,
                  fontWeight: FontWeight.w700),
            ),
            GestureDetector(
              onTap: () async {
                Map<String, dynamic> result = await data.selcetImages();
                if (result['success']) {
                  toastOn("불러오기 성공", '사진을 불러오는데 성공했습니다');
                } else {
                  if (result['msg'] == 'exceed') {
                    toastOn('사진 갯수 초과', '${data.MAX_IMAGE_COUNT}장을 초과할 수 없습니다');
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
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1,
                      letterSpacing: -0.05),
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
                  padding: const EdgeInsets.only(top: 10, bottom: 90),
                  itemCount: data.photos.length,
                  itemBuilder: (context, idx) {
                    return Photo(
                        imageInfo: data.photos[idx], modalOnFunc: modalOnFunc);
                  }),
            ),
          ],
        ),
      );
    });
  }
}
