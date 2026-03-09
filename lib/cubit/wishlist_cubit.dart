import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/model/movie_details_response/movie_details_response.dart';

import 'wishlist_state.dart';

/// Single source of truth for the user's wishlist (favorites).
///
/// Uses Firestore path: Users/{uid}/favorites
/// and keeps the latest list + count in memory so any UI (Profile, etc.)
/// rebuilds instantly.
@lazySingleton
class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial()) {
    _authSub = FirebaseAuth.instance.authStateChanges().listen(
      (_) {
        // When user logs out/in, restart listener so every user gets their own wishlist.
        start();
      },
    );
  }

  StreamSubscription<User?>? _authSub;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _sub;

  void start() {
    _sub?.cancel();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(WishlistLoaded(movies: const []));
      return;
    }

    emit(WishlistLoading());

    final query = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('favorites')
        .orderBy('title');

    _sub = query.snapshots().listen(
      (snapshot) {
        final movies = snapshot.docs
            .map((d) => _mapFavoriteDocToMovie(d))
            .whereType<Movie>()
            .toList(growable: false);
        emit(WishlistLoaded(movies: movies));
      },
      onError: (e, _) {
        emit(WishlistError(e.toString()));
      },
    );
  }

  /// If you need a manual refresh (rare because we listen to snapshots).
  Future<void> refreshOnce() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(WishlistLoaded(movies: const []));
      return;
    }

    emit(WishlistLoading());
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('favorites')
          .get();

      final movies = snapshot.docs
          .map((d) => _mapFavoriteDocToMovie(d))
          .whereType<Movie>()
          .toList(growable: false);
      emit(WishlistLoaded(movies: movies));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Movie? _mapFavoriteDocToMovie(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) return null;

    final idDynamic = data['id'];
    final int? id = idDynamic is int
        ? idDynamic
        : (idDynamic is num ? idDynamic.toInt() : int.tryParse('$idDynamic'));
    if (id == null) return null;

    return Movie(
      id: id,
      title: data['title']?.toString(),
      rating: (data['rating'] is num) ? (data['rating'] as num).toDouble() : null,
      mediumCoverImage: data['image']?.toString(),
      year: (data['year'] is num) ? (data['year'] as num).toInt() : null,
    );
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    await _authSub?.cancel();
    return super.close();
  }
}
