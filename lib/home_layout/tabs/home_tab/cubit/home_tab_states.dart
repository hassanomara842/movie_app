import '../../../../model/movie_response/movie_response.dart';

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

class HomeTabGenreMoviesLoading extends HomeTabStates {
  final int index;
  HomeTabGenreMoviesLoading(this.index);
}

class HomeTabGenreMoviesSuccess extends HomeTabStates {
  final MovieResponse moviesByGenre;
  final String genre;
  final int index;
  HomeTabGenreMoviesSuccess({required this.moviesByGenre, required this.genre, required this.index});
}

class HomeTabGenreMoviesError extends HomeTabStates {
  final String errorMessage;
  final int index;
  HomeTabGenreMoviesError({required this.errorMessage, required this.index});
}
