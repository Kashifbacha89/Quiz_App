import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
//set textStyle for all themes
mixin SubThemeData {
  TextTheme getTextTheme() {
    return GoogleFonts.quicksandTextTheme(const TextTheme(
        bodyText1: TextStyle(
            fontWeight: FontWeight.w400),
        bodyText2: TextStyle(
          fontWeight: FontWeight.w400,
        )));
  }
  //set the colors for icons in the app
 IconThemeData getIconTheme(){
    return const IconThemeData(color: onSurfaceTextColor,size: 16);
}
}
