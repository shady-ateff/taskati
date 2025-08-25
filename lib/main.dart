import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/features/splash/page/splash_screen.dart';

void main() async {
  await Hive.initFlutter(); //intialize hive -> create a box
  
  await HiveHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          foregroundColor: AppColors.primary,
        ),
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          suffixIconColor: AppColors.primary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 1),
            
          ),
          
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      home: const SplashScreen(),
    );
  }
}
