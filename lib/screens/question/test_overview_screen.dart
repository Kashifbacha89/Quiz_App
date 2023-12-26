import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/costom_text_style.dart';
import 'package:flutter_study_app/configs/themes/ui_parameters.dart';
import 'package:flutter_study_app/controller/question_paper/question_controller.dart';
import 'package:flutter_study_app/widgets/common/background_decoration.dart';
import 'package:flutter_study_app/widgets/common/custom_appBar.dart';
import 'package:flutter_study_app/widgets/common/main_button.dart';
import 'package:flutter_study_app/widgets/content_area.dart';
import 'package:flutter_study_app/widgets/question/answers_card.dart';
import 'package:flutter_study_app/widgets/question/countDown_timer.dart';
import 'package:flutter_study_app/widgets/question/question_number_card.dart';
import 'package:flutter_study_app/widgets/question_card.dart';
import 'package:get/get.dart';
class TestOverviewScreen extends GetView<QuestionsController> {
  const TestOverviewScreen({Key? key}) : super(key: key);
  static const String routeName='/TestOverviewScreen';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  CustomAppBar(
        title: controller.completeTest,
      ),
      body:  BackgroundDecoration(
        child: Column(
          children: [
            Expanded(child: ContentArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      CountdownTimer(color:UIParameters.isDarkMode()?
                      Theme.of(context).cardColor:
                      Theme.of(context).primaryColor,

                          time: ''),
                      Obx(() => Text('${controller.time}remaining',style: countDownTimerTS(),)),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.allQuestions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width~/75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (_,index){
                          AnswerStatus _status=AnswerStatus.notAnswered;
                        if(controller.allQuestions[index].selectedAnswer!=null){
                          _status=AnswerStatus.answered;
                        }
                        return QuestionNumberCard(
                          index: index+1,
                          status: _status,
                            onTap: (){
                            controller.jumpToQuestion(index);
                            },
                            );
                        
                        }),
                  )
                ],

              )
            )),
            ColoredBox(color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: UIParameters.mobileScreenPadding,
              child: MainButton(
                  onTap: (){
                    controller.complete();
                  },
              title: 'complete',
              ),
            ),)

          ],
        )
      ),
    );
  }
}
