import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/responsive/size_config.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/image/app_assets.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/text/app_text.dart';
import '../../../../model/movie_details_response/movie_details_response.dart';

class VideoPlayWidget extends StatelessWidget {
  final Movie movie;
  const VideoPlayWidget({super.key, required this.movie});

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
            child: CachedNetworkImage(
              imageUrl: movie.largeCoverImage ?? "",
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Image.asset(
                AppAssets.discoverMovies,
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                    children: [
                      Text(
                        movie.title ?? "",
                        textAlign: TextAlign.center,
                        style: AppText.boldTextRoboto(
                            color: AppColors.white, fontSize: sp(26)),
                      ),
                      SizedBox(height: h(15)),
                      Text(
                        movie.year?.toString() ?? "",
                        textAlign: TextAlign.center,
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
