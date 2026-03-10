import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import 'package:movie_app/di/di.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';
import 'package:movie_app/model/movie_response/movie_response.dart';
import '../../../../core/image/app_assets.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import 'icon_text_widget.dart';

class SimilerWidget extends StatelessWidget {
  final List<Movies>? movies;
  const SimilerWidget({super.key, this.movies});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    if (movies == null || movies!.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movies!.length > 4 ? 4 : movies!.length,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: w(10),
        mainAxisSpacing: h(10),
        childAspectRatio: 191 / 279,
      ),
      itemBuilder: (context, index) {
        final movie = movies![index];
        return InkWell(
          onTap: () {
            getIt<MoviesRepository>().addToHistory(movie);
            Navigator.pushNamed(
              context,
              AppRoutes.movieDetailsScreen,
              arguments: movie.id,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(w(10)),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    movie.mediumCoverImage ?? '',
                  ),
                ),
              ),
              child: IconTextWidget(
                text: movie.rating?.toStringAsFixed(1) ?? "0.0",
                image: AppAssets.star,
              ),
            ),
          ),
        );
      },
    );
  }
}
