import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/responsive/responsive.dart';
import 'package:movie_app/core/text/app_text.dart';
class UpdateProfileScreen extends StatelessWidget {
   const UpdateProfileScreen({super.key});

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
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(AppImages.avatar),
              ),
              const SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical:4),
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
              const SizedBox(height: 20,),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical:4),
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
              const SizedBox(height: 10),
              Align(alignment: AlignmentGeometry.topStart,
                child: TextButton(
                  onPressed: () {
                    print("Reset Password clicked");
                  },
                  child: Text(
                    "Reset Password".tr(),
                    textAlign: TextAlign.start,
                    style:
                      AppText.regularText(color: AppColors.white, fontSize: 20)
                  ),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity, // ياخد عرض الشاشة بالكامل
                    child: ElevatedButton(
                      onPressed: () {
                        print("Delete clicked");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:AppColors.errorRed,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Delete Account".tr(),
                        style: AppText.regularText(color: AppColors.white, fontSize: 20)
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print("");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:AppColors.primaryYellow,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                          "Update Data".tr(),
                          style: AppText.regularText(color: AppColors.primaryBlack, fontSize: 20)
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
