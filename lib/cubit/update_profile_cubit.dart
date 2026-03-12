import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/helpers/cache_helper.dart';
import 'package:movie_app/cubit/update_profile_states.dart';
import '../domain/use_cases/update_profile_use_case.dart';
import '../domain/use_cases/delete_account_use_case.dart';

@injectable
class UpdateProfileCubit extends Cubit<UpdateProfileStates> {
  final UpdateProfileUseCase updateProfileUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;

  UpdateProfileCubit(this.updateProfileUseCase, this.deleteAccountUseCase)
      : super(UpdateProfileInitial());

  Future<void> updateProfile({
    required String name,
    required String phone,
    required int avaterId,
  }) async {
    emit(UpdateProfileLoadingState());
    try {
      final user = await updateProfileUseCase(
        name: name,
        phone: phone,
        avaterId: avaterId,
      );
      await CacheHelper.saveUserData(
        name: user.name,
        email: user.email,
        avatarId: user.avaterId,
      );

      emit(UpdateProfileSuccessState(user));
    } catch (e) {
      emit(UpdateProfileErrorState(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoadingState());
    try {
      await deleteAccountUseCase();
      await CacheHelper.clearAll();
      emit(DeleteAccountSuccessState());
    } catch (e) {
      emit(DeleteAccountErrorState(e.toString()));
    }
  }
}