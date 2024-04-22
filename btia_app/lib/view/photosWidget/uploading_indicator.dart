import 'package:btia_app/model/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class UploadingIndicator extends StatelessWidget {
  const UploadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosModel>(
      builder: (context, data, child) {
        return Visibility(
          visible: data.isUploading,
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.6),
            child: Center(
                child: CircularPercentIndicator(
              radius: 60,
              lineWidth: 5,
              percent: data.photos.isEmpty
                  ? 1
                  : data.curUploadedImage / data.photos.length,
              center: const Text(
                '업로드중',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              progressColor: const Color.fromRGBO(255, 107, 0, 1),
            )),
          ),
        );
      },
    );
  }
}
