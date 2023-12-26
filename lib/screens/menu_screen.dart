import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/app_colors.dart';
import 'package:flutter_study_app/configs/themes/ui_parameters.dart';
import 'package:flutter_study_app/controller/zoom_drawer_controller.dart';
import 'package:get/get.dart';
class MyMenuScreen extends GetView<MyZoomDrawerController> {
  const MyMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIParameters.mobileScreenPadding,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: mainGradient(),
      ),
      child: Theme(
        data: ThemeData(textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: onSurfaceTextColor,
          )
        )),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  child: BackButton(
                color: Colors.white,
                onPressed: (){
                  controller.toogleDrawer();
                },
              )),
              Column(
                children: [
                  Obx(() => controller.user.value==null?const SizedBox():
                  Text(controller.user.value!.displayName??'',
                  style: const TextStyle(
                    color: onSurfaceTextColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 18
                  ),),
                  ),
                  const Spacer(flex: 1,),
                  MyDrawerButton(icon: Icons.web, label: 'website', onTap: ()=>controller.website()),
                  MyDrawerButton(icon: Icons.facebook, label: 'facebook', onTap: ()=>controller.facebook()),
                  MyDrawerButton(icon: Icons.email, label: 'email', onTap: ()=>controller.email()),
                 const  Spacer(flex: 4,),
                  MyDrawerButton(icon: Icons.logout, label: 'logout', onTap: ()=>controller.signOut()),

                ],
              )
            ],
          ),

        ),
      ),
    );
  }
}
class MyDrawerButton extends StatelessWidget {
  const MyDrawerButton({Key? key,
  required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(onPressed:onTap ,
        icon: Icon(icon,size: 15,),
        label: Text(label),);
  }
}

