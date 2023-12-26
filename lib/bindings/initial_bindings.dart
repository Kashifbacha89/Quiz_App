import 'package:flutter_study_app/controller/auth_controller.dart';
import 'package:flutter_study_app/controller/theme_controller.dart';
import 'package:flutter_study_app/services/firebase_storage_services.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(FirebaseStorageServices());
    Get.put(AuthController(),permanent: true);
  }
}