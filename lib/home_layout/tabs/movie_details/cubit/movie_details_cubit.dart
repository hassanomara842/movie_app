import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool isFavorite = false;

  Future<void> getMovieDetails({required int movieId}) async {
    emit(MovieDetailsLoadingState());
    try {
      movieDetails = await ApiManager.getMovieDetails(movieId);
      await checkIsFavorite(movieId);
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

  Future<void> toggleFavorite(Movie movie) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final favRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .collection("favorites")
        .doc(movie.id.toString());

    try {
      bool added;
      if (isFavorite) {
        await favRef.delete();
        isFavorite = false;
        added = false;
      } else {
        await favRef.set({
          "id": movie.id,
          "title": movie.title,
          "rating": movie.rating,
          "image": movie.mediumCoverImage,
          "year": movie.year,
        });
        isFavorite = true;
        added = true;
      }
      emit(FavoriteStatusChangedState(isFavorite));
      emit(WishlistActionSuccessState(added: added));
    } catch (e) {
      emit(MovieDetailsErrorState(e.toString()));
    }
  }

  Future<void> checkIsFavorite(int movieId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .collection("favorites")
          .doc(movieId.toString())
          .get();

      isFavorite = doc.exists;
      emit(FavoriteStatusChangedState(isFavorite));
    } catch (e) {
      emit(MovieDetailsErrorState(e.toString()));
    }
  }
}
