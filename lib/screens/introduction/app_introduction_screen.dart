import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/app_colors.dart';
import 'package:flutter_study_app/screens/home/home_screen.dart';
import 'package:flutter_study_app/widgets/app_cicular_button.dart';
import 'package:get/get.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: mainGradient(),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:Get.width*0.2 ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Icon(Icons.star,size: 65,),
              const SizedBox(height: 40,),
              const Text('This is a study app.You can  use it as you want.if you understand how this work,you would be able to scale it.',
              textAlign: TextAlign.center,
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: onSurfaceTextColor,
              ),),
            const SizedBox(height: 40,),
              AppCircularButton(
                child: const Icon(Icons.arrow_forward,size: 35,),

                onTap: ()=> Get.offAndToNamed(HomeScreen.routeName))
            ],
          ),
        )
      ),
    );
  }
}
