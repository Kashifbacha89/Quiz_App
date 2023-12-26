import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/app_colors.dart';
import 'package:flutter_study_app/controller/auth_controller.dart';
import 'package:flutter_study_app/widgets/common/main_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName='/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          decoration: BoxDecoration(
            gradient: mainGradient(),

          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/app_splash_logo.png',width: 200,height: 200,),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60,horizontal: 30),
                child:  Text('This is a study app you can use as you want.You have the full access to all the materials in this course',
                textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                  color: onSurfaceTextColor
                ),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20 ),
                child: MainButton(
                    onTap: (){
                      controller.signInWithGoogle();
                      print('*******************${controller.signInWithGoogle()}*******************');
                    },
                    child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/google.svg'),
                          const SizedBox(width: 40,),

                          Center(
                            child: Text('Sign in with google',style: TextStyle(fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),),
                          ),
                        ],
                      ),
                    )


                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
