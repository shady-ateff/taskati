import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/profile/page/profile_page.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, ${HiveHelper.getData(HiveHelper.userName).toString().split(' ').first}",
                style: TextStyles.getTitle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              Text("Have a nice day"),
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            pushTo(context, ProfilePage());
          },
          child: CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary,
            child: CircleAvatar(
              radius: 21,
              backgroundImage:
                  HiveHelper.getData(HiveHelper.userImagePath) != null
                  ? FileImage(File(HiveHelper.getData(HiveHelper.userImagePath)))
                  : AssetImage('assets/images/user.png'),
            ),
          ),
        ),
      ],
    );
  }
}
