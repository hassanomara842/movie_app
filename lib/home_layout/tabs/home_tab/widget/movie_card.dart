import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/model/movie_response/movie_response.dart';
import 'package:movie_app/widgets/main_loading_widget.dart';

import '../../../../core/image/app_assets.dart';
import '../../../../core/responsive/responsive.dart';

class MovieCard extends StatelessWidget {
  final Movies movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      height: h(220),
      width: w(146),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: movie.mediumCoverImage ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => const MainLoadingWidget(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
            top: h(13),
            left: w(13),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: w(7), vertical: h(5)),
              decoration: BoxDecoration(
                color: AppColors.primaryBlack.withAlpha(150),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie.rating?.toString() ?? "N/A",
                    style: AppText.regularTextRoboto(
                        color: AppColors.white, fontSize: 16.sp),
                  ),
                  SizedBox(width: w(5)),
                  Image.asset(
                    AppAssets.star,
                    fit: BoxFit.contain,
                    height: h(15),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
