import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_study_app/controller/auth_controller.dart';
import 'package:flutter_study_app/controller/question_paper/question_controller.dart';
import 'package:flutter_study_app/firebase_ref/refrences.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

extension QuestionControllerExtension on QuestionsController{
  //extension method use for to access all the properties of older class
  int get  correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer==element.correctAnswer).toList().length;

  String get correctAnsweredQuestions{
    return '$correctQuestionCount out of ${allQuestions.length} are correct';

  }
  String get points{
    var points=(correctQuestionCount/allQuestions.length)*100*
        (questionPaperModel.timeSeconds-remainSeconds)/questionPaperModel.timeSeconds*100;
    return points.toStringAsFixed(2);
  }
  Future<void> saveTestResult()async{
    var batch=fireStore.batch();
    User? _user= Get.find<AuthController>().getUser();
    if(_user==null)return;
    batch.set(
        userRF.doc(_user.email).collection('My_Recent_Tests').doc(questionPaperModel.id),
        {
          'points':points,
          'correct_answer':'$correctQuestionCount/${allQuestions.length}',
          'question_id':questionPaperModel.id,
          'time':questionPaperModel.timeSeconds -remainSeconds,

        });
    batch.commit();
    navigateToHome();

  }

}