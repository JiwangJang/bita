import 'package:btia_app/model/photos_model.dart';
import 'package:flutter/material.dart';
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
            color: const Color.fromRGBO(0, 0, 0, 0.5),
            child: Center(
              child: Text(
                data.curUploadedImage.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
