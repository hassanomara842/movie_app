import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/responsive/responsive.dart';
import 'package:movie_app/core/responsive/size_config.dart';
import 'package:movie_app/core/text/app_text.dart';
class UpdateProfileScreen extends StatelessWidget {
   const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: AppColors.primaryYellow,size: 30),
        title: Text('Pick Avatar'.tr(),style: AppText.boldText(color: AppColors.primaryYellow, fontSize: 16),),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: w(20)),
          child: Column(
            children: [
               SizedBox(height: h(35),),
               CircleAvatar(
                radius: w(80),
                backgroundImage: const AssetImage(AppImages.avatar),
              ),
               SizedBox(height: h(30),),
              Container(
                padding:  EdgeInsets.symmetric(horizontal: w(15),vertical:h(4)),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness==Brightness.dark?AppColors.darkGrey:AppColors.darkBlack,
                  borderRadius: BorderRadius.circular(w(15)),
                ),
                child: TextField(
                  style: ( AppText.regularText(color: AppColors.white, fontSize:20 )),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.person, color: AppColors.white),
                    hintText: "John Safwat",
                    hintStyle: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              Container(
                padding: EdgeInsets.symmetric(horizontal: w(15),vertical:h(4)),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness==Brightness.dark?AppColors.darkGrey:AppColors.darkBlack,
                  borderRadius: BorderRadius.circular(w(15)),
                ),
                child: TextField(
                  style: ( AppText.regularText(color: AppColors.white, fontSize:20 )),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.phone_rounded, color: AppColors.white),
                    hintText: "0114333333",
                    hintStyle: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
               SizedBox(height:h(10) ),
              Align(alignment: AlignmentGeometry.topStart,
                child: TextButton(
                  onPressed: () {
                    print("Reset Password clicked");
                  },
                  child: Text(
                    "Reset Password".tr(),
                    textAlign: TextAlign.start,
                    style:
                      AppText.regularText(color:Theme.of(context).brightness==Brightness.dark?AppColors.darkGrey:AppColors.darkBlack , fontSize: 20)
                  ),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print("Delete clicked");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:AppColors.errorRed,
                        padding: EdgeInsets.symmetric(vertical: h(14)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w(15)),
                        ),
                      ),
                      child: Text(
                        "Delete Account".tr(),
                        style: AppText.regularText(color: AppColors.white, fontSize: 20)
                        ),
                      ),
                    ),
                   SizedBox(height: h(18)),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print("");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:AppColors.primaryYellow,
                        padding:  EdgeInsets.symmetric(vertical: h(14)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w(15)),
                        ),
                      ),
                      child: Text(
                          "Update Data".tr(),
                          style: AppText.regularText(color: AppColors.primaryBlack, fontSize: 20)
                      ),
                    ),
                  ),
                  SizedBox(height: h(37)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
