import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';
import '../../../../model/movie_response/movie_response.dart';
import 'home_tab_states.dart';

@lazySingleton
class HomeTabCubit extends Cubit<HomeTabStates> {
  final MoviesRepository _moviesRepository;

  HomeTabCubit(this._moviesRepository) : super(HomeTabStatesInitial());

  MovieResponse? allMovies;
  List<MovieResponse?> genreMoviesList = [null, null, null, null];
  List<String?> genreNames = [null, null, null, null];

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

  void refreshHomeCategories() {
    getMoviesByGenre(1);
    getMoviesByGenre(2);
    getMoviesByGenre(3);
  }

  Future<void> getMoviesByGenre(int index, [String? genre]) async {
    genreMoviesList[index] = null;
    emit(HomeTabGenreMoviesLoading(index));
    
    String selectedGenre = genre ?? genres[Random().nextInt(genres.length)];

    if (genre == null && index > 0) {
      while (genreNames.sublist(1).contains(selectedGenre)) {
        selectedGenre = genres[Random().nextInt(genres.length)];
      }
    }
    genreNames[index] = selectedGenre;

    try {
      final movies = await _moviesRepository.getAllMoviesByGenre(selectedGenre);
      genreMoviesList[index] = movies;
      emit(HomeTabGenreMoviesSuccess(
        moviesByGenre: movies, 
        genre: selectedGenre, 
        index: index
      ));
    } catch (e) {
      emit(HomeTabGenreMoviesError(errorMessage: e.toString(), index: index));
    }
  }

  Future<void> addToHistory(Movies movie) async {
    await _moviesRepository.addToHistory(movie);
  }
}
