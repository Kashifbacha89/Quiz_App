import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_study_app/configs/themes/app_colors.dart';
import 'package:flutter_study_app/configs/themes/ui_parameters.dart';
import 'package:get/get.dart';

TextStyle cartTitles(context) => TextStyle(
      color: UIParameters.isDarkMode()
          ? Theme.of(context).textTheme.bodyText1!.color
          : Theme.of(context).primaryColor,
      fontSize: 19,
      fontWeight: FontWeight.bold,
    );
const questionText = TextStyle(fontSize: 16, fontWeight: FontWeight.w800);
const detailText = TextStyle(fontSize: 12);
const headerText = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w700, color: onSurfaceTextColor);

//style for app bar text
const appBarTS = TextStyle(
    fontSize: 16, fontWeight: FontWeight.bold, color: onSurfaceTextColor);

//style for countdown
TextStyle countDownTimerTS() => TextStyle(
    letterSpacing: 2,
    color: UIParameters.isDarkMode()
        ? Theme.of(Get.context!).textTheme.bodyText1!.color
        : Theme.of(Get.context!).primaryColor);
