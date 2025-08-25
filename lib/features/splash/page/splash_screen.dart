import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/features/home/page/home_page.dart';
import 'package:taskati/features/signup/page/signup_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      if (HiveHelper.box.isNotEmpty &&
          HiveHelper.getData(HiveHelper.userImagePath) != null &&
          HiveHelper.getData(HiveHelper.userName) != null) {
        replaceTo(context, HomePage());
      } else {
        print(
          'splash : ${HiveHelper.getData(HiveHelper.userImagePath)}  -  ${HiveHelper.getData(HiveHelper.userName)}',
        );
        replaceTo(context, SignupPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Lottie.asset(
              'assets/lotties/Task Done.json',
              width: 200,
              height: 200,
            ),
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 50,
              height: 50,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            SizedBox(height: 25),
            Text(
              "it's Time to Get Organized !",
              style: TextStyle(color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
