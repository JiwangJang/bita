import 'package:btia_app/model/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddingIndicator extends StatelessWidget {
  const AddingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosModel>(builder: (_, data, child) {
      return Visibility(
        visible: data.isAdding,
        child: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.6)),
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ),
        ),
      );
    });
  }
}
