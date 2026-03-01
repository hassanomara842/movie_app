import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/home_layout/tabs/search_tab/cubit/search_tab_states.dart';

import '../../../../api/api_manager.dart';
import '../../../../model/movie_response/movie_response.dart';

@injectable
class SearchTabCubit extends Cubit<SearchTabStates> {
  SearchTabCubit() : super(SearchTabInitState());
  String searchText = '';
  MovieResponse? searchedMovies;
  void changeSearchText(String text) {
    if (text.isEmpty) {
    searchText = text;
    emit(SearchTabInitState());}
    else{
      getMovieBySearch(text);
    }
  }

  Future<void> getMovieBySearch(String searchText) async {
    this.searchText = searchText;
    if (searchText.isEmpty) {
      emit(SearchTabInitState());
      return;
    }
    emit(SearchTabLoadingState());
    try {
      searchedMovies = await ApiManager.getMoviesBySearch(searchText);
      emit(SearchTabSuccessState());
    } catch (e) {
      emit(SearchTabErrorState(e.toString()));
    }
  }
}
