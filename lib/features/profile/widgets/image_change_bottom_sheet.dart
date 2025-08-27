import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/components/buttons/custom_button.dart';

class ImageChangeBottomSheet extends StatelessWidget {
  const ImageChangeBottomSheet({super.key, required this.onImageChanged});
  final Function(String filePath) onImageChanged;


  @override
  Widget build(BuildContext context) {

    Future<void> uploadImage({bool isCamera = false}) async {
      var image = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (image != null) {
        onImageChanged(image.path); // pass back the file path
        Navigator.pop(context); // close bottom sheet after selecting
      }
    }

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 15,
            children: [
              CustomButton(
                width: double.infinity,
                label: "Take A Picture",
                onPressed: () async {
                  await uploadImage(isCamera: true);
                  // setState(() {});
                },
              ),
              CustomButton(
                width: double.infinity,
                label: "Upload From Gallery",
                onPressed: () async {
                  await uploadImage();
                  // setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
