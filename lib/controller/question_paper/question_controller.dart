import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_study_app/controller/auth_controller.dart';
import 'package:flutter_study_app/controller/question_paper/question_paper_controller.dart';
import 'package:flutter_study_app/firebase_ref/loading_status.dart';
import 'package:flutter_study_app/firebase_ref/refrences.dart';
import 'package:flutter_study_app/models/question_paper_model.dart';
import 'package:flutter_study_app/screens/home/home_screen.dart';
import 'package:flutter_study_app/screens/question/result_screen.dart';
import 'package:get/get.dart';

class QuestionsController extends GetxController {
  late QuestionPaperModel questionPaperModel;
  final loadingStatus = LoadingStatus.loading.obs;
  final allQuestions = <Questions>[];
  final questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value > 0;
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;
  //reactive variable
  Rxn<Questions> currentQuestion = Rxn<Questions>();
  //Timer
  Timer? _timer;
  int remainSeconds = 1;
  final time = '00:00'.obs;

  @override
  void onReady() {
    final _questionPaper = Get.arguments as QuestionPaperModel;
    loadData(_questionPaper);
    super.onReady();
  }

  //method for load question data from firebase
  Future<void> loadData(QuestionPaperModel questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperRF
              .doc(questionPaper.id)
              .collection('questions')
              .get();
      final questions = questionQuery.docs
          .map((snapshot) => Questions.fromSnapshot(snapshot))
          .toList();
      questionPaper.questions = questions;
      for (Questions _questions in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection('questions')
                .doc(_questions.id)
                .collection('answers')
                .get();
        final answers = answersQuery.docs
            .map((answer) => Answers.fromSnapshot(answer))
            .toList();
        _questions.answers = answers;

      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(questionPaper.questions!);
      currentQuestion.value = questionPaper.questions![0];
      _startTimer(questionPaper.timeSeconds);
      if (kDebugMode) {
        print(questionPaper.questions![0].question);
      }
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list','answer_review_list']);
  }
  //methods for test complete
  String get completeTest{
    final answered=
     allQuestions.where((element)=>element.selectedAnswer!=null).toList().length;
    return '$answered out of ${allQuestions.length} answered';
  }
  //method for jump to question
  void jumpToQuestion(int index,{bool isGoBack=true}){
    questionIndex.value=index;
    currentQuestion.value=allQuestions[index];
    if(isGoBack){
      Get.back();
    }

  }

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void prevQuestion() {
    if (questionIndex.value <= 0) return;
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }


  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
       _timer =Timer.periodic(duration, (Timer timer) {
      if (remainSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value = minutes.toString().padLeft(2, "0")+":"+seconds.toString().padLeft(2, "0");
        remainSeconds--;
      }
    });
  }
  //after complete quiz
void complete(){
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
}
void tryAgain(){
    Get.find<QuestionPaperController>().navigateToQuestions(tryAgain: true
        ,paper: questionPaperModel);
}
void navigateToHome(){
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.routeName, (route) => false);
}

}
