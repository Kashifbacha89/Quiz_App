import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/costom_text_style.dart';
import 'package:flutter_study_app/configs/themes/ui_parameters.dart';
import 'package:flutter_study_app/screens/question/test_overview_screen.dart';
import 'package:flutter_study_app/widgets/app_cicular_button.dart';
import 'package:get/get.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;
  const CustomAppBar({Key? key,
  this.title='',
    this.leading,
    this.showActionIcon=false,
    this.onMenuActionTap,
    this.titleWidget,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: mobileScreenPadding,vertical: mobileScreenPadding),
          child: Stack(
      children: [
          Positioned.fill(child: titleWidget==null?Center(
            child: Text(title,style: appBarTS,),
          ):Center(child: titleWidget,),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leading??Transform.translate(offset: const Offset(-14, 0),
            child: const BackButton(),
            ),
            if(showActionIcon)
              Transform.translate(offset: const Offset(10,0),
              child: AppCircularButton(
                onTap: onMenuActionTap??()=>Get.toNamed(TestOverviewScreen.routeName),
                child: const Icon(Icons.dashboard,size: 30,),
              ),),

          ],
        )
      ],
    ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 80);
}
