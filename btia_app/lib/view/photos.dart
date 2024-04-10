import 'package:btia_app/model/photos_model.dart';
import 'package:btia_app/view/custom_appbar.dart';
import 'package:btia_app/view/photosWidget/photo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Photos extends StatelessWidget {
  const Photos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(49, 51, 48, 1),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppbar(title: '사진들'),
      ),
      body: Consumer<PhotosModel>(builder: (_, photoData, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              const Text(
                '사진업로드는 한번에 최대 10장까지 가능합니다',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: -0.05,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                '현재 : ${photoData.photos.length}/10',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: -0.05,
                ),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: photoData.photos.length,
                    itemBuilder: (context, idx) {
                      return Photo(image: photoData.photos[idx]);
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
