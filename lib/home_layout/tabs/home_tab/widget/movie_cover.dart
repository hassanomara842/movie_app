import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../widgets/main_loading_widget.dart';

class MovieCover extends StatelessWidget {
  const MovieCover({super.key, required this.coverImageUrl, required this.movieId});
  final String coverImageUrl;
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.movieDetailsScreen,
          arguments: movieId,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: coverImageUrl,
          placeholder: (context, url) => const MainLoadingWidget(),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error, color: Colors.white),
        ),
      ),
    );
  }
}
