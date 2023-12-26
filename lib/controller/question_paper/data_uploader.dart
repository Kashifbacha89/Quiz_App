import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study_app/firebase_ref/loading_status.dart';
import 'package:flutter_study_app/firebase_ref/refrences.dart';
import 'package:flutter_study_app/models/question_paper_model.dart';
import 'package:get/get.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }
  //*******obs means that variable is observable because we use getX***************************
  final loadingStatus=LoadingStatus.loading.obs;//loading status is observable


//****************//access all the json data here//********************************************
  void uploadData() async {
    loadingStatus.value=LoadingStatus.loading;//it take value of 0,
    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
    //read the json file and print path
    final paperInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/paper") && path.contains('.json'))
        .toList();
    //print(paperInAssets);

    for (var paper in paperInAssets) {
      List<QuestionPaperModel> questionPaper = [];
      String paperContent = await rootBundle.loadString(paper);
      // print(paperContent);
      questionPaper.add(QuestionPaperModel.fromJson(jsonDecode(paperContent)));
      //print('items number${questionPaper.length}');
      var batch = fireStore.batch();
 //======================collection for subjects===========================================================

      for (var paper in questionPaper) {
        batch.set(questionPaperRF.doc(paper.id), {
          'title': paper.title,
          'image_url': paper.imageUrl,
          'description': paper.description,
          'time_seconds': paper.timeSeconds,
          'question_count':
              paper.questions == null ? 0 : paper.questions!.length,
        });
 //==================== collection for questions======================================================

        for (var questions in paper.questions!) {
          final questionPath =
              questionRF(paperId: paper.id, questionId: questions.id);
          batch.set(
              questionPath,
              ({
                'question': questions.question,
                'correct_answer': questions.correctAnswer,
              }));
 //===================collection for answers========================================================

          for (var answer in questions.answers) {
            batch.set(
                questionPath.collection('answers').doc(answer.identifier),
                ({
                  'identifier': answer.identifier,
                  'answer': answer.answer,
                }));
          }
        }
      }
 //methods used for to fetch all these data to firebase using getx
      await batch.commit();
      loadingStatus.value=LoadingStatus.completed;
    }
  }
}
