import '../domain/entities/user_entity.dart';

abstract class LoginStates {}

class LoginInitial extends LoginStates {}
class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final UserEntity user;
  LoginSuccessState(this.user);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}