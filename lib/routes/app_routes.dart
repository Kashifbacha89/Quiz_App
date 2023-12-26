import 'package:flutter_study_app/controller/question_paper/question_controller.dart';
import 'package:flutter_study_app/controller/question_paper/question_paper_controller.dart';
import 'package:flutter_study_app/controller/zoom_drawer_controller.dart';
import 'package:flutter_study_app/screens/home/home_screen.dart';
import 'package:flutter_study_app/screens/introduction/app_introduction_screen.dart';
import 'package:flutter_study_app/screens/login/login_screen.dart';
import 'package:flutter_study_app/screens/question/answer_check_screen.dart';
import 'package:flutter_study_app/screens/question/result_screen.dart';
import 'package:flutter_study_app/screens/question/test_overview_screen.dart';
import 'package:flutter_study_app/screens/question/question_screen.dart';
import 'package:flutter_study_app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes() => [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/introduction', page: ()=>const AppIntroductionScreen()),
    GetPage(name: '/HomeScreen', page: ()=>const HomeScreen(),
    binding: BindingsBuilder((){
      Get.put(QuestionPaperController());
      Get.put(MyZoomDrawerController());
    })),
    GetPage(name: LoginScreen.routeName, page: ()=>const LoginScreen()),
    GetPage(name: QuestionsScreen.routeName, page: ()=>const QuestionsScreen(),
    binding: BindingsBuilder((){
      Get.put<QuestionsController>(QuestionsController());
    })),
    GetPage(
        name: TestOverviewScreen.routeName,
        page: ()=>const TestOverviewScreen()),
    GetPage(name: ResultScreen.routeName,
        page: ()=>const ResultScreen()),
    GetPage(name: AnswerCheckScreen.routeName,
        page: ()=>const AnswerCheckScreen()),
  ];
}