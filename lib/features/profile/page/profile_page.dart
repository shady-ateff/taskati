import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/components/buttons/custom_button.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/profile/widgets/edit_name_bottom_sheet.dart';
import 'package:taskati/features/profile/widgets/image_change_bottom_sheet.dart';
import 'package:taskati/features/signup/page/signup_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    bool isDark =
        HiveHelper.getData(HiveHelper.isDarkTheme) ??
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              HiveHelper.cacheData(HiveHelper.isDarkTheme, !isDark);
              setState(() {});
            },
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ImageChangeBottomSheet(
                        onImageChanged: (filePath) {
                          HiveHelper.cacheData(
                            HiveHelper.userImagePath,
                            filePath,
                          );
                          setState(() {});
                        },
                      );
                    },
                  );
                },
                child: Stack(
                  // alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      backgroundImage: FileImage(
                        File(HiveHelper.getData(HiveHelper.userImagePath)),
                      ),
                      radius: 110,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.white,
                        child: Icon(
                          Icons.photo_camera_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(15),
              Divider(),
              Gap(15),
              ListTile(
                iconColor: AppColors.primary,
                textColor: AppColors.primary,
                title: Text(
                  HiveHelper.getData(HiveHelper.userName),
                  style: TextStyles.getTitle(fontWeight: FontWeight.w600),
                ),
                trailing: IconButton.outlined(
                  onPressed: () {
                    var nameController = TextEditingController(
                      text: HiveHelper.getData(HiveHelper.userName),
                    );
                    showModalBottomSheet(
                      isScrollControlled: true,

                      context: context,
                      builder: (context) {
                        return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(
                            context,
                          ).viewInsets.bottom, 
                        ),
                          child: EditNameBottomSheet(
                            nameController: nameController,
                            onNameChenged: (changedNameController) {
                              setState(() {});
                            },
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.edit_outlined),
                  color: AppColors.primary,
                ),
              ),
              Gap(70),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
        child: CustomButton(
          onPressed: () {
            HiveHelper.deleteData(HiveHelper.userName);
            HiveHelper.deleteData(HiveHelper.userImagePath);
            pushAndRemoveUntil(context, SignupPage());
          },
          width: double.infinity,
          // height: 40,
          label: 'Logout',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: true,
    );
  }
}
