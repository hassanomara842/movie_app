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
  List<MovieResponse?> genreMoviesList = [null, null, null];
  List<String?> genreNames = [null, null, null];

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

  Future<void> getMoviesByGenre(int index, [String? genre]) async {
    genreMoviesList[index] = null;
    emit(HomeTabGenreMoviesLoading(index));
    
    String selectedGenre = genre ?? genres[Random().nextInt(genres.length)];
    // Ensure unique genres for each section if picking randomly
    while (genreNames.contains(selectedGenre) && genre == null) {
      selectedGenre = genres[Random().nextInt(genres.length)];
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
}
