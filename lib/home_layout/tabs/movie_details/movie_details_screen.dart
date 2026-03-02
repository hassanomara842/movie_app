import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/cast_widget.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/genres_widget.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/icon_text_widget.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/screen_shots_widget.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/similer_widget.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/video_play_widget.dart';
import 'package:movie_app/widgets/app_button.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/size_config.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: h(16),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const VideoPlayWidget(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w(10),
              ),
              child: Column(
                spacing: h(10),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(
                      buttonTitle: "watch".tr(),
                      onPressed: () {},
                      textColor: AppColors.white,
                      backgroundColor: AppColors.errorRed),
                  Row(
                    spacing: w(10),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(
                          child: IconTextWidget(
                              text: "15", image: AppAssets.favouriteIcon)),
                      Expanded(
                          child: IconTextWidget(
                              text: "90", image: AppAssets.timeIcon)),
                      Expanded(
                          child: IconTextWidget(
                              text: "7.5", image: AppAssets.star)),
                    ],
                  ),
                  title("screen_shots".tr(), context),
                  const ScreenShotsListWidget(),
                  title("similar".tr(), context),
                  const SimilerWidget(),
                  title("summary".tr(), context),
                  Text(
                    "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346",
                    style: AppText.regularTextRoboto(
                        color: Theme.of(context).splashColor, fontSize: sp(16)),
                  ),
                  title("cast".tr(), context),
                  const CastWidget(),
                  title("genres".tr(), context),
                  const GenresListWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text title(String title, BuildContext context) {
    return Text(title.tr(),
        style: AppText.boldTextRoboto(
            color: Theme.of(context).splashColor, fontSize: sp(25)));
  }
}
