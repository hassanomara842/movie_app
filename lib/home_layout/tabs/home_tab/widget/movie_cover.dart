import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/main_loading_widget.dart';

class MovieCover extends StatelessWidget {
  const MovieCover({super.key, required this.coverImageUrl});
  final String coverImageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: coverImageUrl,
        placeholder: (context, url) => const MainLoadingWidget(),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.white),
      ),
    );
  }
}
