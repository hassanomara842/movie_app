import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/di/injection.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';
import 'package:movie_app/model/movie_response/movie_response.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../di/injection.dart';
import '../../../../widgets/main_loading_widget.dart';

class MovieCover extends StatelessWidget {
  const MovieCover({super.key, required this.movie});
  final Movies movie;

  @override
  Widget build(BuildContext context) {
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
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: movie.mediumCoverImage ?? '',
          placeholder: (context, url) => const MainLoadingWidget(),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error, color: Colors.white),
        ),
      ),
    );
  }
}
