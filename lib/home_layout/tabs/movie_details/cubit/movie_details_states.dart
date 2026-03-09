class MovieDetailsStates {}

class MovieDetailsInitState extends MovieDetailsStates {}

class MovieDetailsLoadingState extends MovieDetailsStates {}

class MovieDetailsErrorState extends MovieDetailsStates {
  final String errorMessage;
  MovieDetailsErrorState(this.errorMessage);
}

class MovieDetailsSuccessState extends MovieDetailsStates {}

class MovieSuggestionsLoadingState extends MovieDetailsStates {}

class MovieSuggestionsErrorState extends MovieDetailsStates {
  final String errorMessage;
  MovieSuggestionsErrorState(this.errorMessage);
}

class MovieSuggestionsSuccessState extends MovieDetailsStates {}

class FavoriteStatusChangedState extends MovieDetailsStates {
  final bool isFavorite;
  FavoriteStatusChangedState(this.isFavorite);
}

class WishlistActionSuccessState extends MovieDetailsStates {
  final bool added;

  WishlistActionSuccessState({required this.added});
}
