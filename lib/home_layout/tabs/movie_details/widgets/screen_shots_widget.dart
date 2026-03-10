import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_details_response/movie_details_response.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';

class ScreenShotsListWidget extends StatelessWidget {
  final Movie movie;
  const ScreenShotsListWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final List<String> screenShots = [
      movie.mediumScreenshotImage1 ?? '',
      movie.mediumScreenshotImage2 ?? '',
      movie.mediumScreenshotImage3 ?? '',
    ].where((url) => url.isNotEmpty).toList();

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: screenShots.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: h(8),
          ),
          height: h(167),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: screenShots[index],
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }
}
