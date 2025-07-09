import 'package:flutter/material.dart';
import 'package:news_app/features/home/presentation/logic/home_cubit.dart';

class ColorsManager {
  static Color get primaryColor => Color(0xFF009688);
  static Color get primaryColor2 => homeCubit.isDark ? Color(0xFF000000) : Color(0xFF009688);
  static const Color primaryDarkColor = Color(0xFF000000);
  static const Color scaffoldBackgroundColor = Color(0xFFF5F5F5);
  static const Color scaffoldDarkBackgroundColor = Color(0xFF2F302E);

  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static Color get textColor => homeCubit.isDark ? Color(0xFFFFFFFF) : Color(0xFF2F302E);
}