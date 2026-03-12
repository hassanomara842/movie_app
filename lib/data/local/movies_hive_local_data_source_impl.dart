import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/data/local/hive/movie_hive_model.dart';
import 'package:movie_app/data/local/hive/movies_cache_entry_hive_model.dart';
import 'package:movie_app/model/movie_response/movie_response.dart';

import 'movies_local_data_source.dart';

const _moviesCacheBoxName = 'movies_cache_box';
const _historyBoxName = 'history_box';

@LazySingleton(as: MoviesLocalDataSource)
class MoviesHiveLocalDataSourceImpl implements MoviesLocalDataSource {
  Future<Box<MoviesCacheEntryHiveModel>>? _boxFuture;
  Future<Box<MovieHiveModel>>? _historyBoxFuture;

  Future<Box<MoviesCacheEntryHiveModel>> _box() {
    return _boxFuture ??=
        Hive.openBox<MoviesCacheEntryHiveModel>(_moviesCacheBoxName);
  }

  Future<Box<MovieHiveModel>> _historyBox() {
    return _historyBoxFuture ??= Hive.openBox<MovieHiveModel>(_historyBoxName);
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

  @override
  Future<void> addToHistory(Movies movie) async {
    final box = await _historyBox();

    // Find the existing entry's key to delete it.
    // We must search by values because we want to delete by the auto-incrementing key.
    dynamic existingKey;
    for (var key in box.keys) {
      final m = box.get(key);
      if (m?.id == movie.id) {
        existingKey = key;
        break;
      }
    }

    if (existingKey != null) {
      await box.delete(existingKey);
    }

    final hiveMovie = MovieHiveModel(
      id: movie.id ?? 0,
      title: movie.title ?? '',
      year: movie.year,
      rating: movie.rating,
      mediumCoverImage: movie.mediumCoverImage,
    );
    
    // add() uses an auto-incrementing key which preserves insertion order.
    await box.add(hiveMovie);
  }

  @override
  Future<List<Movies>> getWatchHistory() async {
    final box = await _historyBox();
    // box.values follows the order of the keys. Since we use auto-incrementing keys,
    // the last added items are at the end. We reverse to show most recent first.
    return box.values
        .map(
          (m) => Movies(
            id: m.id,
            title: m.title,
            year: m.year,
            rating: m.rating,
            mediumCoverImage: m.mediumCoverImage,
          ),
        )
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<void> clearHistory() async {
    final box = await _historyBox();
    await box.clear();
  }

  Future<void> _cache(
      {required String key, required MovieResponse response}) async {
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
