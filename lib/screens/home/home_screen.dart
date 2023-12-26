import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/app_colors.dart';
import 'package:flutter_study_app/configs/themes/costom_text_style.dart';
import 'package:flutter_study_app/configs/themes/ui_parameters.dart';
import 'package:flutter_study_app/controller/question_paper/question_paper_controller.dart';
import 'package:flutter_study_app/controller/zoom_drawer_controller.dart';
import 'package:flutter_study_app/screens/menu_screen.dart';
import 'package:flutter_study_app/widgets/app_cicular_button.dart';
import 'package:flutter_study_app/widgets/content_area.dart';
import 'package:flutter_study_app/widgets/question_card.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName='/HomeScreen';

  @override
  Widget build(BuildContext context) {
    QuestionPaperController quizPprController=Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(builder: (_){
        return ZoomDrawer(
          borderRadius: 50.0 ,
          style: DrawerStyle.DefaultStyle,
          backgroundColor: Colors.white.withOpacity(0.3),
          angle: 0.0,
          showShadow: true,
          slideWidth: MediaQuery.of(context).size.width*0.4,
          controller: _.zoomDrawerController,
          menuScreen:const MyMenuScreen(),
          mainScreen: Container(
            decoration: BoxDecoration(
              gradient: mainGradient(),
            ),

            child: SafeArea(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //1st section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.all(mobileScreenPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppCircularButton(
                              onTap: controller.toogleDrawer,
                              child:  const Icon(Icons.menu ,size: 28,),),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  const Icon(Icons.clean_hands,size: 16,),
                                   const SizedBox(width: 4,),
                                  Text('Kashif Bacha',style: detailText.copyWith(
                                    color: onSurfaceTextColor,
                                  ),),


                                ],
                              ),
                            ),
                            const Text('what do you want to learn today?',style: headerText,)
                          ],
                        ),)

                    ],
                  ),
                  //stack section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ContentArea(
                        addPadding: false,
                        child: Obx(()=>
                            ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              itemBuilder: (BuildContext context,int index){
                                return QuestionCard(model: quizPprController.allPapers[index]);

                              },
                              separatorBuilder: (BuildContext context,int index){
                                return const SizedBox(height: 20,);
                              },
                              itemCount:quizPprController.allPapers.length ,

                            ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },)
    );
  }
}
