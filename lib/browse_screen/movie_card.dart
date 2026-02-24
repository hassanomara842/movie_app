import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import '../core/responsive/size_config.dart';

class MovieCard extends StatelessWidget {
  final String imagePath;
  final double rating;
  final VoidCallback? onTap;

  const MovieCard({
    super.key,
    required this.imagePath,
    required this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius =
    BorderRadius.circular(SizeConfig.screenWidth * 0.04);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.screenHeight * 0.30,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: SizeConfig.screenHeight * 0.015,
              left: SizeConfig.screenWidth * 0.03,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.black1.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}