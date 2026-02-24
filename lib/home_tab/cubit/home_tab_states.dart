import '../../model/movie_response/movie_response.dart';

abstract class HomeTabStates {}

class HomeTabStatesInitial extends HomeTabStates {}

class HomeTabAllMoviesLoading extends HomeTabStates {}

class HomeTabAllMoviesSuccess extends HomeTabStates {
  final MovieResponse allMovies;
  HomeTabAllMoviesSuccess({required this.allMovies});
}

class HomeTabAllMoviesError extends HomeTabStates {
  final String errorMessage;
  HomeTabAllMoviesError({required this.errorMessage});
}

class HomeTabGenreMoviesLoading extends HomeTabStates {}

class HomeTabGenreMoviesSuccess extends HomeTabStates {
  final MovieResponse moviesByGenre;
  final String genre;
  HomeTabGenreMoviesSuccess({required this.moviesByGenre, required this.genre});
}

class HomeTabGenreMoviesError extends HomeTabStates {
  final String errorMessage;
  HomeTabGenreMoviesError({required this.errorMessage});
}
