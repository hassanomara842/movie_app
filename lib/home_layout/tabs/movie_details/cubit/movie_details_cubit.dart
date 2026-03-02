import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/api/api_manager.dart';
import 'package:movie_app/model/movie_response/movie_response.dart';

import '../../../../model/movie_details_response/movie_details_response.dart';
import 'movie_details_states.dart';

@injectable
class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  MovieDetailsCubit() : super(MovieDetailsInitState());
  MovieDetailsResponse? movieDetails;
  MovieResponse? movieSuggestions;


  Future<void> getMovieDetails({required int movieId}) async {
    emit(MovieDetailsLoadingState());
    try {
      movieDetails = await ApiManager.getMovieDetails(movieId);
      emit(MovieDetailsSuccessState());
    } catch (e) {
      emit(MovieDetailsErrorState(e.toString()));
    }
  }

  Future<void> getMovieSuggestions({required int movieId}) async {
    emit(MovieDetailsLoadingState());
    try {
      movieSuggestions = await ApiManager.getMovieSuggestions(movieId);
      emit(MovieDetailsSuccessState());
    } catch (e) {
      emit(MovieDetailsErrorState(e.toString()));
    }
  }
}
