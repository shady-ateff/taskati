import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/components/buttons/custom_button.dart';
import 'package:taskati/core/extentions/dialogs.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/features/home/page/home_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? imagePath;
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              String error = "";
              if (imagePath == null) {
                error = " Upload Photo";
              }
              if (_nameController.text.isEmpty) {
                error = "$error, Enter Your Name";
              }
              if (error.isNotEmpty) {
                errorDialog(context, error);
              } else {
                await HiveHelper.cacheData(HiveHelper.userImagePath, imagePath);
                await HiveHelper.cacheData(
                  HiveHelper.userName,
                  _nameController.text,
                );
                print(
                  '${HiveHelper.getData(HiveHelper.userImagePath)}  -  ${HiveHelper.getData(HiveHelper.userName)}',
                );
                replaceTo(context, HomePage());
              }
            },
            child: Text('Done'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.transparent,
              child: imagePath != null
                  ? ClipOval(
                      child: Image.file(
                        File(imagePath!),
                        // height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SvgPicture.asset(
                      'assets/images/user1.svg',
                      colorFilter: ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                      height: 300,
                      width: 300,
                    ),
            ),
            SizedBox(height: 20),
            CustomButton(
              label: "Take A Picture",
              onPressed: () async {
                await uploadImage(isCamera: true);
                setState(() {});
              },
            ),
            Gap(15),
            CustomButton(
              label: "Upload From Gallery",
              onPressed: () async {
                await uploadImage();
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            Divider(indent: 20, endIndent: 20),
            Container(
              padding: EdgeInsets.all(25),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Name',
                  hintText: "name",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadImage({bool isCamera = false}) async {
    var image = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (image != null) {
      debugPrint(imagePath);
      imagePath = image.path;
      debugPrint(imagePath);
    }
  }
}
