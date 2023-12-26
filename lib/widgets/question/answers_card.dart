import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/app_colors.dart';
import 'package:flutter_study_app/configs/themes/ui_parameters.dart';
enum AnswerStatus{
  correct,wrong,answered,notAnswered
}

class AnswersCards extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswersCards({Key? key,
  required this.answer,
   this.isSelected=false,
  required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        decoration: BoxDecoration(
          color: isSelected?answerSelectedColor():Theme.of(context).cardColor,
          border: Border.all(
            color: isSelected?answerSelectedColor():answerBorderColor()
          )
        ),
        child: Text(answer,
        style: TextStyle(
          color: isSelected?onSurfaceTextColor:null
        ),),
      ),
    );
  }
}
class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({Key? key,required this.answer}) : super(key: key);
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding:const  EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: correctAnswerColor.withOpacity(0.1),
      ),
      child: Text(answer,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: correctAnswerColor,
      ),),

    );
  }
}
class WrongAnswer extends StatelessWidget {
  const WrongAnswer({Key? key,required this.answer}) : super(key: key);
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding:const  EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: wrongAnswerColor.withOpacity(0.1),
      ),
      child: Text(answer,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: wrongAnswerColor,
        ),),

    );
  }
}
class NotAnswer extends StatelessWidget {
  const NotAnswer({Key? key,required this.answer}) : super(key: key);
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding:const  EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: notAnswerColor.withOpacity(0.1),
      ),
      child: Text(answer,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: notAnswerColor,
        ),),

    );
  }
}

