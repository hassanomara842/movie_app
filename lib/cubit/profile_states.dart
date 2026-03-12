import 'package:movie_app/model/movie_response/movie_response.dart';
import '../domain/entities/user_entity.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}
class ProfileLoadingState extends ProfileStates {}
class ProfileSuccessState extends ProfileStates {
  final UserEntity? user;
  ProfileSuccessState({this.user});
}
class ProfileErrorState extends ProfileStates {
  final String error;
  ProfileErrorState(this.error);
}
class LogoutSuccessState extends ProfileStates {}
class GetWatchHistoryLoadingState extends ProfileStates {}

class GetWatchHistorySuccessState extends ProfileStates {
  final List<Movies> movies;
  GetWatchHistorySuccessState(this.movies);
}
class GetWatchHistoryErrorState extends ProfileStates {
  final String error;
  GetWatchHistoryErrorState(this.error);
}