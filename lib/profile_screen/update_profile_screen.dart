import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/responsive/responsive.dart';
import 'package:movie_app/core/text/app_text.dart';
class UpdateProfileScreen extends StatelessWidget {
   UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primaryYellow,size: 30),
        backgroundColor: AppColors.darkGrey,
        title: Text('Pick Avatar'.tr(),style: AppText.boldText(color: AppColors.primaryYellow, fontSize: 16),),
        centerTitle: true,
      ),
    );
  }
}
