import 'package:movie_app/model/movie_response/movie_response.dart';

abstract class MoviesLocalDataSource {
  Future<void> cacheAllMovies(MovieResponse response);
  Future<MovieResponse?> getCachedAllMovies();

  Future<void> cacheMoviesByGenre(String genre, MovieResponse response);
  Future<MovieResponse?> getCachedMoviesByGenre(String genre);

  Future<void> addToHistory(Movies movie);
  Future<List<Movies>> getWatchHistory();
}
