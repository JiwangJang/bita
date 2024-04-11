import 'package:btia_app/model/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadingIndicator extends StatelessWidget {
  const UploadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosModel>(
      builder: (context, data, child) {
        if (data.isUploading) {
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
