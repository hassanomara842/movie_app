import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';
import '../../../../model/movie_response/movie_response.dart';
import 'home_tab_states.dart';

@injectable
class HomeTabCubit extends Cubit<HomeTabStates> {
  final MoviesRepository _moviesRepository;

  HomeTabCubit(this._moviesRepository) : super(HomeTabStatesInitial());

  MovieResponse? allMovies;
  MovieResponse? allMoviesByGenre;
  String? currentGenre;

  final List<String> genres = [
    'Action', 'Adventure', 'Animation', 'Biography', 'Comedy', 'Crime',
    'Documentary', 'Drama', 'Family', 'Fantasy', 'Film-Noir', 'Game-Show',
    'History', 'Horror', 'Music', 'Musical', 'Mystery', 'News',
    'Reality-TV', 'Romance', 'Sci-Fi', 'Short', 'Sport', 'Talk-Show',
    'Thriller', 'War', 'Western',
  ];

  Future<void> getMovies() async {
    emit(HomeTabAllMoviesLoading());
    try {
      allMovies = await _moviesRepository.getAllMovies();
      emit(HomeTabAllMoviesSuccess(allMovies: allMovies!));
    } catch (e) {
      emit(HomeTabAllMoviesError(errorMessage: e.toString()));
    }
  }

  Future<void> getMoviesByGenre([String? genre]) async {
    allMoviesByGenre = null;
    emit(HomeTabGenreMoviesLoading());
    currentGenre = genre ?? genres[Random().nextInt(genres.length)];
    try {
      allMoviesByGenre = await _moviesRepository.getAllMoviesByGenre(currentGenre!);
      emit(HomeTabGenreMoviesSuccess(moviesByGenre: allMoviesByGenre!, genre: currentGenre!));
    } catch (e) {
      emit(HomeTabGenreMoviesError(errorMessage: e.toString()));
    }
  }
}
