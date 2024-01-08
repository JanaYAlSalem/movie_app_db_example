import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_db_example/core/utils/theme/color.dart';

ThemeData darkTheme() => ThemeData(
  scaffoldBackgroundColor: AppColors.blue40,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    // backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.blue40,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: AppColors.blue40,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.green30,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: AppColors.blue40,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return AppColors.gray30;
      }
      if (states.contains(MaterialState.disabled)) {
        return Colors.white;
      }
      return AppColors.blue40;
    }),
    trackColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return AppColors.green30;
      }
      if (states.contains(MaterialState.disabled)) {
        return Colors.white;
      }
      return AppColors.gray30;
    }),
  ),
);