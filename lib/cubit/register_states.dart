class RegisterStates {}
class RegisterInitial extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final user;
  RegisterSuccessState(this.user);
}
class RegisterErrorState extends RegisterStates{
  final error;
  RegisterErrorState(this.error);
}
