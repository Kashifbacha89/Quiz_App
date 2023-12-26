import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/app_colors.dart';
import 'package:flutter_study_app/configs/themes/costom_text_style.dart';
import 'package:flutter_study_app/configs/themes/ui_parameters.dart';
import 'package:flutter_study_app/controller/question_paper/question_controller.dart';
import 'package:flutter_study_app/firebase_ref/loading_status.dart';
import 'package:flutter_study_app/screens/question/test_overview_screen.dart';
import 'package:flutter_study_app/widgets/common/background_decoration.dart';
import 'package:flutter_study_app/widgets/common/custom_appBar.dart';
import 'package:flutter_study_app/widgets/common/main_button.dart';
import 'package:flutter_study_app/widgets/common/screen_place_holder.dart';
import 'package:flutter_study_app/widgets/content_area.dart';
import 'package:flutter_study_app/widgets/question/countDown_timer.dart';
import 'package:flutter_study_app/widgets/question/answers_card.dart';
import 'package:get/get.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  const QuestionsScreen({Key? key}) : super(key: key);
  static const String routeName = '/QuestionsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: const ShapeDecoration(
                shape: StadiumBorder(
                    side: BorderSide(color: onSurfaceTextColor, width: 2))),
            child: Obx(() => CountdownTimer(
                  time: controller.time.value,
                  color: onSurfaceTextColor,
                )),
          ),
          showActionIcon: true,
          titleWidget: Obx(() => Text(
                'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                style: appBarTS,
              ))),
      body: BackgroundDecoration(
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller.loadingStatus.value == LoadingStatus.loading)
                    const Expanded(
                        child: Center(
                            child: ContentArea(
                                child: QuestionScreenPlaceHolder()))),
                  if (controller.loadingStatus.value == LoadingStatus.completed)
                    Expanded(
                        child: ContentArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              controller.currentQuestion.value!.question,
                              style: questionText,
                            ),
                            GetBuilder<QuestionsController>(
                                id: 'answers_list',
                                builder: (context) {
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 25),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final answer = controller
                                            .currentQuestion
                                            .value!
                                            .answers[index];
                                        return AnswersCards(
                                          answer:
                                              '${answer.identifier}.${answer.answer}',
                                          onTap: () {
                                            controller.selectedAnswer(
                                                answer.identifier);
                                          },
                                          isSelected: answer.identifier ==
                                              controller.currentQuestion.value!
                                                  .selectedAnswer,
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(
                                                height: 10,
                                              ),
                                      itemCount: controller.currentQuestion
                                          .value!.answers.length);
                                }),
                          ],
                        ),
                      ),
                    )),
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: UIParameters.mobileScreenPadding,
                      child: Row(
                        children: [
                          Visibility(
                              visible: controller.isFirstQuestion,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: SizedBox(
                                  height: 55,
                                  width: 55,
                                  child: MainButton(
                                    onTap: () {
                                      controller.prevQuestion();
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Get.isDarkMode
                                          ? onSurfaceTextColor
                                          : Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                            child: Visibility(
                                visible: controller.loadingStatus.value ==
                                    LoadingStatus.completed,
                                child: MainButton(
                                  onTap: () {
                                    controller.isLastQuestion
                                        ?Get.toNamed(TestOverviewScreen.routeName)
                                        : controller.nextQuestion();
                                  },
                                  title: controller.isLastQuestion
                                      ? 'Complete'
                                      : 'Next',
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
