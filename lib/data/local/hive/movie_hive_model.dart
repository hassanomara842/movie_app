import 'package:hive/hive.dart';

part 'movie_hive_model.g.dart';

/// A minimal Hive model for offline caching.
/// Only fields the UI needs.
@HiveType(typeId: 1)
class MovieHiveModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int? year;

  @HiveField(3)
  final double? rating;

  @HiveField(4)
  final String? mediumCoverImage;

  MovieHiveModel({
    required this.id,
    required this.title,
    this.year,
    this.rating,
    this.mediumCoverImage,
  });
}

