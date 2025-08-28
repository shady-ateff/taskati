import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/app_themes.dart';
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
    return ValueListenableBuilder(
      valueListenable: HiveHelper.box.listenable(),
      builder: (BuildContext context, value, Widget? child) {
        bool isDark =
            HiveHelper.getData(HiveHelper.isDarkTheme) ??
            Theme.of(context).brightness == Brightness.dark;
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: isDark
              ? ThemeMode.dark
              : ThemeMode.light, //ThemeMode.system
          home: const SplashScreen(),
        );
      },
    );
  }
}
