import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/app_colors.dart';
import 'package:flutter_study_app/configs/themes/ui_parameters.dart';
import 'package:flutter_study_app/widgets/question/answers_card.dart';
import 'package:get/get.dart';
class QuestionNumberCard extends StatelessWidget {
  final int index;
  final AnswerStatus status;
  final VoidCallback onTap;
  const QuestionNumberCard({Key? key,
    required this.index,
    required this.status,
    required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor=Theme.of(context).primaryColor;
    switch(status){
      case AnswerStatus.answered:
        //code your condition here
      _backgroundColor:Get.isDarkMode?
          Theme.of(context).cardColor:
          Theme.of(context).primaryColor;

        break;
      case AnswerStatus.correct:
        _backgroundColor=correctAnswerColor;
        //
        break;
      case AnswerStatus.wrong:
        _backgroundColor=wrongAnswerColor;
        //
        break;
      case AnswerStatus.notAnswered:
        _backgroundColor=Get.isDarkMode?
            Colors.red.withOpacity(0.5):
            Theme.of(context).primaryColor.withOpacity(0.1);


        break;
      default:
        //code your condition here
        _backgroundColor=Theme.of(context).primaryColor.withOpacity(0.1);
    }
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: UIParameters.cardBorderRadius,
        ),
        child: Center(
          child: Text('$index',style: TextStyle(
            color: status==AnswerStatus.notAnswered?
                Theme.of(context).primaryColor:null,
          ),

          ),
        ),

      ),
    );
  }
}
