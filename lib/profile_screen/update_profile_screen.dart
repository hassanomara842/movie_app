import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/responsive/responsive.dart';
import 'package:movie_app/core/text/app_text.dart';
class UpdateProfileScreen extends StatelessWidget {
   UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primaryYellow,size: 30),
        backgroundColor: AppColors.primaryBlack,
        title: Text('Pick Avatar'.tr(),style: AppText.boldText(color: AppColors.primaryYellow, fontSize: 16),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(AppImages.avatar),
            ),
            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15,vertical:7),
              decoration: BoxDecoration(
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                style: ( AppText.regularText(color: AppColors.white, fontSize:20 )),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.person, color: AppColors.white),
                  hintText: "John Safwat",
                  hintStyle: TextStyle(color: AppColors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15,vertical:7),
              decoration: BoxDecoration(
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                style: ( AppText.regularText(color: AppColors.white, fontSize:20 )),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.phone_rounded, color: AppColors.white),
                  hintText: "0114333333",
                  hintStyle: TextStyle(color: AppColors.white),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
