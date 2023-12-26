import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_study_app/models/question_paper_model.dart';

/// id : "ppr004"
/// title : "Biology"
/// image_url : ""
/// Description : "Basic Biology Multiple Choice Questions (MCQ) to practice basic Biology quiz answers"
/// time_seconds : 900
/// questions : [{"id":"ppr004q001","question":"A relationship in which one animal hunts, kills and eats another","answers":[{"identifier":"A","Answer":"Symbiosis"},{"identifier":"B","Answer":"Mutualism"},{"identifier":"C","Answer":"Parasitism"},{"identifier":"D","Answer":"Predation"}],"correct_answer":"D"},{"id":"ppr004q002","question":"The animal that is hunted and killed for food.","answers":[{"identifier":"A","Answer":"Decomposer"},{"identifier":"B","Answer":"Predator"},{"identifier":"C","Answer":"Scavenger"},{"identifier":"D","Answer":"Prey"}],"correct_answer":"D"},{"id":"ppr004q003","question":"A close relationship between two different species of organisms living together.","answers":[{"identifier":"A","Answer":"Mutualism"},{"identifier":"B","Answer":"Symbiosis"},{"identifier":"C","Answer":"Competition"},{"identifier":"D","Answer":"Commensialism"}],"correct_answer":"B"},{"id":"ppr004q004","question":"A symbiotic relationship in which both species benefit.","answers":[{"identifier":"A","Answer":"Mutualism"},{"identifier":"B","Answer":"Commensialism"},{"identifier":"C","Answer":"Parasitism"},{"identifier":"D","Answer":"Predation"}],"correct_answer":"A"},{"id":"ppr004q005","question":"Which organelle is found in most plants, some bacteria and some protists?","answers":[{"identifier":"A","Answer":"ribosomes"},{"identifier":"B","Answer":"mitochondria"},{"identifier":"C","Answer":"endoplasmic reticulum"},{"identifier":"D","Answer":"chloroplasts"}],"correct_answer":"D"}]

class QuestionPaperModel{
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  List<Questions>? questions;
  int questionCount;
  QuestionPaperModel({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.description,
    required this.timeSeconds,
    required this.questionCount,
    this.questions

});
  QuestionPaperModel.fromJson(Map<String,dynamic>json):
      id=json['id']as String,
  title=json['title'] as String,
  imageUrl=json['image_url'] as String,
  description=json['description'] as String,
  questionCount=0,
  timeSeconds=json['time_seconds'] ,
  questions=(json['questions'] as List)
      .map((dynamic e) =>Questions.fromJson(e as Map<String,dynamic>) ).toList();


  QuestionPaperModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>json):
        id=json.id,
        title=json['title'] ,
        imageUrl=json['image_url'] ,
        description=json['description'] ,
        questionCount=json['question_count'] as int  ,
        timeSeconds=json['time_seconds'] ,
        questions=[];
  String timeInMinutes()=>"${(timeSeconds /60).ceil()} mins";

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=  Map<String,dynamic>();
    data['id']= this.id;
    data['title']=this.title;
    data['image_url']=this.imageUrl;
    data['description']=this.description;
    data['time_seconds']=this.timeSeconds;
    return data;
  }



}


/// id : "ppr004q001"
/// question : "A relationship in which one animal hunts, kills and eats another"
/// answers : [{"identifier":"A","Answer":"Symbiosis"},{"identifier":"B","Answer":"Mutualism"},{"identifier":"C","Answer":"Parasitism"},{"identifier":"D","Answer":"Predation"}]
/// correct_answer : "D"

class Questions{
  String id;
  String question;
  List<Answers> answers;
  String? correctAnswer;
  String?selectedAnswer;
  Questions({
    required this.id,
    required this.question,
    required this.answers,
    this.correctAnswer,
});
  Questions.fromJson(Map<String,dynamic>json):
      id= json['id'],
  question=json['question'],
  answers=(json['answers'] as List).map((e) => Answers.fromJson(e)).toList(),
  correctAnswer=json['correct_answer'];

  Questions.fromSnapshot(QueryDocumentSnapshot<Map<String,dynamic>> snapshot):
      id=snapshot.id,
  question=snapshot['question'],
  answers=[],
  correctAnswer=snapshot['correct_answer'];

  Map<String,dynamic>toJson(){
    final Map<String,dynamic> data=  Map<String,dynamic>();
    data['id']=this.id;
    data['question']=this.question;
    if(this.answers != null){
      data['answers']=this.answers.map((v) => v.toJson()).toList();
    }
    data['correct_answer']=this.correctAnswer;
    return data;
  }
}

/// identifier : "A"
/// Answer : "Symbiosis"

class Answers{
  String? identifier;
  String? answer;
  Answers({
    this.identifier,
    this.answer
});
  Answers.fromJson(Map<String,dynamic> json):
        identifier=json['identifier'],
  answer=json['answer'];

  Answers.fromSnapshot(QueryDocumentSnapshot<Map<String,dynamic>> snapshot):
      identifier=snapshot['identifier']as String?,
  answer=snapshot['answer']as String?;


  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data= <String,dynamic>{};
    data['identifier']=identifier;
    data['answer']=answer;
    return data;
  }
}