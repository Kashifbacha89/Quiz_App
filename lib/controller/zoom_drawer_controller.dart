import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_study_app/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class MyZoomDrawerController extends GetxController{
  final zoomDrawerController=ZoomDrawerController();
  Rxn<User?> user=Rxn();
  @override
  void onReady() {
    user.value=Get.find<AuthController>().getUser();

    super.onReady();
  }
  void toogleDrawer(){
    zoomDrawerController.toggle?.call();
    update();

  }
  void signOut(){
    Get.find<AuthController>().signOut();

  }
  void website(){
    _launch("http://www.dbesteach.com");

  }
  void facebook(){
    _launch("http://www.facebook.com");
  }
  void email(){
    final Uri emailLunchUri=Uri(
      scheme: 'mailTo',
      path: 'muhammadkashif3779@gmail.com',
    );
    _launch(emailLunchUri.toString());

  }
  Future<void> _launch(String url)async{
   if(! await launch(url)){
     throw 'could not launch $url';
   }


  }

}