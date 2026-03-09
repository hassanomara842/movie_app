import '../domain/entities/user_entity.dart';

abstract class UpdateProfileStates {}
class UpdateProfileInitial extends UpdateProfileStates {}
class UpdateProfileLoadingState extends UpdateProfileStates {}
class UpdateProfileSuccessState extends UpdateProfileStates {
  final UserEntity user;  UpdateProfileSuccessState(this.user);
}
class UpdateProfileErrorState extends UpdateProfileStates {
  final String error;
  UpdateProfileErrorState(this.error);
}
class DeleteAccountLoadingState extends UpdateProfileStates {}
class DeleteAccountSuccessState extends UpdateProfileStates {}
class DeleteAccountErrorState extends UpdateProfileStates {
  final String error;
  DeleteAccountErrorState(this.error);
}