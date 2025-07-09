import 'package:flutter/material.dart';
import 'package:news_app/features/home/presentation/screen/home_screen.dart';

class Routes {
  static const String homeScreen = '/homeScreen';
  static const String loginScreen = '/loginScreen';

  static Map<String, WidgetBuilder> get routes => {
    homeScreen: (context) => const HomeScreen(),
  };
}