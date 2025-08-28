import 'package:flutter/material.dart';
import 'package:taskati/core/utils/app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    fontFamily: 'Poppins',
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.bgColor,
      surfaceTintColor: AppColors.bgColor,
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
  );

  static final ThemeData darkTheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.darkGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
    ),
    // useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
      onSurface: AppColors.white,
      onPrimary: AppColors.darkBG,
      surface: AppColors.darkBG,
    ),
    fontFamily: 'Poppins',
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBG,
      surfaceTintColor: AppColors.darkBG,
      centerTitle: true,
      foregroundColor: AppColors.primaryLight,
    ),
    scaffoldBackgroundColor: AppColors.darkBG,
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.darkBG,
      headerBackgroundColor: AppColors.darkGrey,
      headerForegroundColor: AppColors.white,
      dayStyle: const TextStyle(color: Colors.white),
      weekdayStyle: const TextStyle(color: Colors.white70),
      yearStyle: const TextStyle(color: Colors.white),
      todayBackgroundColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        } else if (states.contains(WidgetState.focused)) {
          return AppColors.darkGrey.withAlpha(70);
        } else if (states.contains(WidgetState.pressed)) {
          return AppColors.primaryLight;
        }
        return AppColors.darkBG;
      }),
      dayBackgroundColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        } else if (states.contains(WidgetState.disabled)) {
          return AppColors.darkGrey.withAlpha(70);
        } else if (states.contains(WidgetState.pressed)) {
          return AppColors.primaryLight;
        }
        return AppColors.darkBG;
      }),
      dayForegroundColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white;
        } else if (states.contains(WidgetState.disabled)) {
          return AppColors.grey;
        }
        return AppColors.white;
      }),
      todayForegroundColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white;
        } else if (states.contains(WidgetState.focused)) {
          return AppColors.primaryLight;
        }
        return AppColors.primary;
      }),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.white),
        backgroundColor: WidgetStatePropertyAll(AppColors.primary),
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.primary),
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.darkBG,
      dialBackgroundColor: AppColors.darkGrey,
      dialHandColor: AppColors.primary,
      hourMinuteTextColor: AppColors.white,
      hourMinuteColor: AppColors.darkGrey,
      dayPeriodTextColor: AppColors.white,
      dayPeriodColor: AppColors.primary,
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.white),
        backgroundColor: WidgetStatePropertyAll(AppColors.primary),
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.primary),
      ),
      dialTextColor: AppColors.white,
    ),
    // textTheme: TextTheme(
    //   bodyLarge: TextStyle(color: AppColors.white),
    //   bodyMedium: TextStyle(color: AppColors.white),
    //   bodySmall: TextStyle(color: AppColors.white),
    //   titleLarge: TextStyle(color: AppColors.white),
    //   titleMedium: TextStyle(color: AppColors.white),
    //   titleSmall: TextStyle(color: AppColors.white),
    //   labelLarge: TextStyle(color: AppColors.white),
    //   labelMedium: TextStyle(color: AppColors.white),
    //   labelSmall: TextStyle(color: AppColors.white),
    // ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.white), // لون الـ hint
      labelStyle: TextStyle(color: Colors.white), // لون الـ label
      suffixIconColor: AppColors.primary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
    ),
  );
}
