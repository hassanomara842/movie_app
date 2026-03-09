import 'package:hive/hive.dart';

import 'movie_hive_model.dart';

part 'movies_cache_entry_hive_model.g.dart';

@HiveType(typeId: 2)
class MoviesCacheEntryHiveModel extends HiveObject {
  @HiveField(0)
  final String key;

  /// epoch millis
  @HiveField(1)
  final int updatedAt;

  @HiveField(2)
  final List<MovieHiveModel> movies;

  MoviesCacheEntryHiveModel({
    required this.key,
    required this.updatedAt,
    required this.movies,
  });
}

