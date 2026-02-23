import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/helpers/cache_helper.dart';
import 'package:movie_app/cubit/profile_states.dart';
import '../domain/entities/user_entity.dart';

@injectable
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());
  void getUserProfile() {
    emit(ProfileLoadingState());
    try {
      final String? name = CacheHelper.getUserName();
      final String? email = CacheHelper.getUserEmail();
      final int? avatarId = CacheHelper.getAvatarId();
      if (name != null) {
        final user = UserEntity(
          id: '',
          name: name,
          email: email ?? '',
          phone: '',
          avaterId: avatarId ?? 0,
        );
        emit(ProfileSuccessState(user: user));
      } else {
        emit(ProfileErrorState("User data not found in cache"));
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
  Future<void> logout() async {
    try {
      await CacheHelper.clearAll();
      emit(LogoutSuccessState());
    } catch (e) {
      emit(ProfileErrorState("Logout failed: ${e.toString()}"));
    }
  }
}