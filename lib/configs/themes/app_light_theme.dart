import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/sub_theme_data_mixin.dart';

const Color primaryLightColorLight = Color(0xFF3ac3cb);
const Color primaryColorLight = Color(0xFFf85187);

//**********color for all text******************
const Color mainTextColorLight = Color.fromARGB(255, 40, 40, 40);
const Color cardColor =Color.fromARGB(255,254,254,255);

//*********************************************************************************
//set theme data for light theme//this is the mother function for light theme
class LightTheme with SubThemeData {
  buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      iconTheme: getIconTheme(),
      primaryColor: primaryColorLight,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardColor:cardColor,
      textTheme: getTextTheme().apply(
        bodyColor: mainTextColorLight,
        displayColor: mainTextColorLight,
      ),
    );
  }
}
