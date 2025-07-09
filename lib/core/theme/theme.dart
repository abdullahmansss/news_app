import 'package:flutter/material.dart';
import 'package:news_app/core/theme/colors.dart';
import 'package:news_app/core/theme/text_styles.dart';

class ThemesManager {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: ColorsManager.primaryColor,
    scaffoldBackgroundColor: ColorsManager.scaffoldBackgroundColor,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.primaryColor,
      // titleTextStyle: TextStylesManager.bold20.copyWith(
      //   color: ColorsManager.whiteColor,
      // ),
      iconTheme: IconThemeData(
        color: ColorsManager.whiteColor,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: ColorsManager.primaryDarkColor,
    scaffoldBackgroundColor: ColorsManager.scaffoldDarkBackgroundColor,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.primaryDarkColor,
      // titleTextStyle: TextStylesManager.bold20.copyWith(
      //   color: ColorsManager.whiteColor,
      // ),
      iconTheme: IconThemeData(
        color: ColorsManager.whiteColor,
      ),
    ),
  );
}
