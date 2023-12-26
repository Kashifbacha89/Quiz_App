import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/bindings/initial_bindings.dart';
import 'package:flutter_study_app/configs/themes/app_light_theme.dart';
import 'package:flutter_study_app/controller/theme_controller.dart';
import 'package:flutter_study_app/routes/app_routes.dart';
import 'package:flutter_study_app/screens/data_uploader_screen.dart';
import 'package:flutter_study_app/screens/introduction/app_introduction_screen.dart';
import 'package:flutter_study_app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

//use for uploading data to firebase
/*Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: DataUploaderScreen(),
  ));
}*/
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  await Firebase.initializeApp();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
    theme: Get.find<ThemeController>().lightTheme,
      debugShowCheckedModeBanner: false,
      getPages:AppRoutes.routes(),

    );
  }
}




