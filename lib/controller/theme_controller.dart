import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/app_dark_theme.dart';
import 'package:flutter_study_app/configs/themes/app_light_theme.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController{
  //create instance of light and dark theme
  late ThemeData _lightTheme;
  late ThemeData _darkTheme;
  @override
  void onInit() {
    initializeThemeData();
    super.onInit();
  }
  initializeThemeData(){
    _lightTheme=LightTheme().buildLightTheme();
    _darkTheme=DarkTheme().buildDarkTheme();

  }
  //set getters methods for light & dark theme
ThemeData get darkTheme=> _darkTheme;
  ThemeData get lightTheme=> _lightTheme;
}