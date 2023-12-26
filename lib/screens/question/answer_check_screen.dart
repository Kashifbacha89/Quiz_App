import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/costom_text_style.dart';
import 'package:flutter_study_app/controller/question_paper/question_controller.dart';
import 'package:flutter_study_app/screens/question/result_screen.dart';
import 'package:flutter_study_app/widgets/common/background_decoration.dart';
import 'package:flutter_study_app/widgets/common/custom_appBar.dart';
import 'package:flutter_study_app/widgets/content_area.dart';
import 'package:flutter_study_app/widgets/question/answers_card.dart';
import 'package:get/get.dart';
class AnswerCheckScreen extends GetView<QuestionsController> {
  const AnswerCheckScreen({Key? key}) : super(key: key);
  static const String routeName='/AnswerCheckScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(

        titleWidget: Obx(
            ()=>Text('Q. ${(controller.questionIndex.value+1).toString().padLeft(2,'0')}',style: appBarTS,),
        ),
        showActionIcon: true,
        onMenuActionTap: (){
          //
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(()=>Column(
          children: [
            Expanded(child: ContentArea(child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text(
                      controller.currentQuestion.value!.question,
                    ),
                    GetBuilder<QuestionsController>(
                      id: 'answer_review_list',
                        builder: (_){
                        return ListView.separated(

                          shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.currentQuestion.value!.answers.length,
                            itemBuilder: (_,index){
                            final answer=controller.currentQuestion.value!.answers[index];
                            final selectedAnswer=controller.currentQuestion.value!.selectedAnswer;
                            final correctAnswer=controller.currentQuestion.value!.correctAnswer;
                            final String answerText='${answer.identifier}.${answer.answer}';
                            if(correctAnswer==selectedAnswer && answer.identifier==selectedAnswer){
                             //correct answer
                              return CorrectAnswer(answer: answerText);

                            }else if(selectedAnswer==null){
                              //not answer
                              return NotAnswer(answer: answerText);

                            }else if(correctAnswer!= selectedAnswer && answer.identifier==selectedAnswer){
                              //wrong answer
                              return WrongAnswer(answer: answerText);
                            }else if(correctAnswer==answer.identifier){
                              //correct answer
                              return CorrectAnswer(answer: answerText);
                            }
                            //show option of question
                            return AnswersCards(
                                answer: answerText,
                                isSelected: false,
                                onTap: (){});

                            },
                            separatorBuilder: (_,index){
                            return const SizedBox(height: 10,);
                            },
                            );

                    })
                  ],
                  
                ),
              ),
            )))
          ],
        ))
      ),
    );
  }
}
