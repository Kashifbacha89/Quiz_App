import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/costom_text_style.dart';
import 'package:flutter_study_app/configs/themes/ui_parameters.dart';
import 'package:flutter_study_app/controller/question_paper/question_controller.dart';
import 'package:flutter_study_app/controller/question_paper/question_controller_extension.dart';
import 'package:flutter_study_app/screens/question/answer_check_screen.dart';
import 'package:flutter_study_app/widgets/common/background_decoration.dart';
import 'package:flutter_study_app/widgets/common/custom_appBar.dart';
import 'package:flutter_study_app/widgets/common/main_button.dart';
import 'package:flutter_study_app/widgets/content_area.dart';
import 'package:flutter_study_app/widgets/question/answers_card.dart';
import 'package:flutter_study_app/widgets/question/question_number_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({Key? key}) : super(key: key);
  static const String routeName='/ResultScreen';

  @override
  Widget build(BuildContext context) {
    Color textColor=Get.isDarkMode?Colors.white:Theme.of(context).primaryColor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: const SizedBox(height: 80,),
        title: controller.correctAnsweredQuestions,
      ),

      body: BackgroundDecoration(
        child: Column(
          children: [

            Expanded(child:ContentArea(child: Column(
              children: [
                SvgPicture.asset('assets/images/bulb.svg'),
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 5),
                  child: Text('Congratulation',style: headerText.copyWith(color: textColor),),
                ),
                Text('you have  got ${controller.points} points',style: TextStyle(color: textColor),),
                const SizedBox(height: 25,),
                const Text('Tap below question number to view correct answers',
                textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25,),
                Expanded(child: GridView.builder(
                  itemCount: controller.allQuestions.length,
                  shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Get.size.width~/75,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1,
                    ), itemBuilder: (_,index){
                    final _question=controller.allQuestions[index];
                    AnswerStatus _status=AnswerStatus.notAnswered;
                    final _selectedAnswer=_question.selectedAnswer;
                    final _correctAnswer=_question.correctAnswer;
                    if(_selectedAnswer==_correctAnswer){
                      _status=AnswerStatus.correct;
                    }else if(_selectedAnswer==null){
                      _status=AnswerStatus.wrong;
                    }else{
                      _status=AnswerStatus.wrong;
                    }
                      return QuestionNumberCard(
                          index: index+1, status: _status,
                          onTap: (){
                            controller.jumpToQuestion(index,isGoBack: false);
                            Get.toNamed(AnswerCheckScreen.routeName);
                          });
                }))

              ],
            ))),
            ColoredBox(color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: UIParameters.mobileScreenPadding,
              child: Row(
                children: [
                  Expanded(
                    child: MainButton(onTap: (){
                      controller.tryAgain();
                    },
                    color: Colors.blueGrey,
                      title: 'Try again',

                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(child: MainButton(
                    onTap: (){
                      controller.saveTestResult();
                    },
                    color: Colors.blueGrey,
                    title: 'Go home',
                  ))
                ],
              ),
            ),

            )
          ],
        ),
      )
    );
  }
}
