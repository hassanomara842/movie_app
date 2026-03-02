import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/data/local/hive/movie_hive_model.dart';
import 'package:movie_app/data/local/hive/movies_cache_entry_hive_model.dart';
import 'package:movie_app/model/movie_response/movie_response.dart';

import 'movies_local_data_source.dart';

const _moviesCacheBoxName = 'movies_cache_box';

@LazySingleton(as: MoviesLocalDataSource)
class MoviesHiveLocalDataSourceImpl implements MoviesLocalDataSource {
  Future<Box<MoviesCacheEntryHiveModel>>? _boxFuture;

  Future<Box<MoviesCacheEntryHiveModel>> _box() {
    return _boxFuture ??= Hive.openBox<MoviesCacheEntryHiveModel>(_moviesCacheBoxName);
  }

  @override
  Future<void> cacheAllMovies(MovieResponse response) async {
    await _cache(key: 'all', response: response);
  }

  @override
  Future<MovieResponse?> getCachedAllMovies() async {
    return _get(key: 'all');
  }

  @override
  Future<void> cacheMoviesByGenre(String genre, MovieResponse response) async {
    await _cache(key: 'genre:$genre', response: response);
  }

  @override
  Future<MovieResponse?> getCachedMoviesByGenre(String genre) async {
    return _get(key: 'genre:$genre');
  }

  Future<void> _cache({required String key, required MovieResponse response}) async {
    final movies = response.data?.movies ?? const [];
    final hiveMovies = movies
        .where((m) => m.id != null && m.title != null)
        .map(
          (m) => MovieHiveModel(
            id: m.id!,
            title: m.title!,
            year: m.year,
            rating: m.rating,
            mediumCoverImage: m.mediumCoverImage,
          ),
        )
        .toList(growable: false);

    final entry = MoviesCacheEntryHiveModel(
      key: key,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      movies: hiveMovies,
    );

    final box = await _box();
    await box.put(key, entry);
  }

  Future<MovieResponse?> _get({required String key}) async {
    final box = await _box();
    final entry = box.get(key);
    if (entry == null) return null;

    // Map back to MovieResponse shape used by current UI.
    final movies = entry.movies
        .map(
          (m) => Movies(
            id: m.id,
            title: m.title,
            year: m.year,
            rating: m.rating,
            mediumCoverImage: m.mediumCoverImage,
          ),
        )
        .toList(growable: false);

    return MovieResponse(
      data: Data(movies: movies, movieCount: movies.length),
      status: 'ok',
      statusMessage: 'cached',
    );
  }
}

