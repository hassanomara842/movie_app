import 'package:injectable/injectable.dart';
import 'package:movie_app/api/api_manager.dart';
import 'package:movie_app/core/network/connectivity_service.dart';
import 'package:movie_app/data/local/movies_local_data_source.dart';
import 'package:movie_app/model/movie_response/movie_response.dart';

import 'movies_repository.dart';

@LazySingleton(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  final ConnectivityService _connectivityService;
  final MoviesLocalDataSource _localDataSource;

  MoviesRepositoryImpl(this._connectivityService, this._localDataSource);

  @override
  Future<MovieResponse> getAllMovies() async {
    final online = await _connectivityService.isOnline;
    if (online) {
      final remote = await ApiManager.getAllMovies();
      await _localDataSource.cacheAllMovies(remote);
      return remote;
    }

    final cached = await _localDataSource.getCachedAllMovies();
    if (cached != null) return cached;

    // No internet + no cache: keep error explicit.
    throw Exception('No internet connection and no cached movies found.');
  }

  @override
  Future<MovieResponse> getAllMoviesByGenre(String genre) async {
    final online = await _connectivityService.isOnline;
    if (online) {
      final remote = await ApiManager.getAllMoviesByGenre(genre);
      await _localDataSource.cacheMoviesByGenre(genre, remote);
      return remote;
    }

    final cached = await _localDataSource.getCachedMoviesByGenre(genre);
    if (cached != null) return cached;

    throw Exception('No internet connection and no cached movies for $genre.');
  }
}

