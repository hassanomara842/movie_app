class SearchTabStates {}

class SearchTabInitState extends SearchTabStates {}

class SearchTabLoadingState extends SearchTabStates {}

class SearchTabErrorState extends SearchTabStates {
  final String error;
  SearchTabErrorState(this.error);
}

class SearchTabSuccessState extends SearchTabStates {}
