import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_study_app/controller/auth_controller.dart';
import 'package:flutter_study_app/firebase_ref/refrences.dart';
import 'package:flutter_study_app/models/question_paper_model.dart';
import 'package:flutter_study_app/screens/question/question_screen.dart';
import 'package:flutter_study_app/services/firebase_storage_services.dart';
import 'package:get/get.dart';

class QuestionPaperController extends GetxController{
  final allPaperImages=<String>[].obs;
  final allPapers=<QuestionPaperModel>[].obs;
  @override
  void onReady() {
    getAllPapers();

    super.onReady();
  }
  Future<void> getAllPapers()async{
    List<String> imgName=[
      "biology",
      "chemistry",
      "maths",
      "physics",
    ];
    try{
      //get all data from firebase
      QuerySnapshot<Map<String,dynamic>> data= await questionPaperRF.get();
      final paperList=data.docs.map((paper) =>QuestionPaperModel.fromSnapshot(paper) ).toList();
      allPapers.assignAll(paperList);

      //get images from firebase
      for(var paper in paperList){
        final imgUrl=await Get.find<FirebaseStorageServices>().getImage(paper.title);
        paper.imageUrl=imgUrl;
        allPaperImages.add(imgUrl!);
      }
      allPapers.assignAll(paperList);
    }catch(e){
      print(e);
    }
    //

  }
  void navigateToQuestions({required QuestionPaperModel  paper,bool tryAgain=false}){
    AuthController _authController= Get.find();
    if(_authController.isLoggedIn()){
      if(tryAgain){
        Get.back();
        //navigate to question screen
        Get.toNamed(QuestionsScreen.routeName,arguments: paper,preventDuplicates: false);

      }else{
        Get.toNamed(QuestionsScreen.routeName,arguments:paper);
      }
    }else{
      _authController.showLoginAlertDialogue();
    }


  }
}