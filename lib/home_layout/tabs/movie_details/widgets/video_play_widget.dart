import 'package:flutter/material.dart';
import 'package:movie_app/core/responsive/size_config.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/image/app_assets.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/text/app_text.dart';

class VideoPlayWidget extends StatelessWidget {
  const VideoPlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryBlack.withValues(alpha: 0.2),
                AppColors.primaryBlack.withValues(alpha: 1),
              ],
            ).createShader(rect);
          },
          blendMode: BlendMode.srcATop,
          child: SizedBox(
              height: h(645),
              width: double.infinity,
              child: Image.asset(
                AppAssets.discoverMovies,
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: h(645),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w(20),
            ),
            child: SafeArea(
              child: Column(
                spacing: h(5),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: h(32),
                          color: Colors.white,
                        ),
                      ),
                      Image.asset(AppAssets.saveIcon)
                    ],
                  ),
                  InkWell(
                      onTap: () {}, child: Image.asset(AppAssets.playButton)),
                  Column(
                    spacing: h(15),
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "Doctor Strange in the Multiverse of Madness",
                        style: AppText.boldTextRoboto(
                            color: AppColors.white, fontSize: sp(26)),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "2022",
                        style: AppText.boldTextRoboto(
                            color: AppColors.grey, fontSize: sp(24)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
