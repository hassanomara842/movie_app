import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/helpers/cache_helper.dart';
import 'package:movie_app/cubit/profile_states.dart';
import '../domain/entities/user_entity.dart';
import '../domain/usecases/get_user_profile_usecase.dart';

@injectable
class ProfileCubit extends Cubit<ProfileStates> {
  final GetUserProfileUseCase getUserProfileUseCase;

  ProfileCubit(this.getUserProfileUseCase) : super(ProfileInitial());

  Future<void> getUserProfile() async {
    emit(ProfileLoadingState());
    try {
      final user = await getUserProfileUseCase();
      await CacheHelper.saveUserData(
        name: user.name,
        email: user.email,
        avatarId: user.avaterId,
      );
      emit(ProfileSuccessState(user: user));
    } catch (e) {
      final String? name = CacheHelper.getUserName();
      if (name != null) {
        final cachedUser = UserEntity(
          id: '',
          name: name,
          email: CacheHelper.getUserEmail() ?? '',
          phone: '',
          avaterId: CacheHelper.getAvatarId() ?? 0,
        );
        emit(ProfileSuccessState(user: cachedUser));
      } else {
        emit(ProfileErrorState("Failed to load profile: ${e.toString()}"));
      }
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await CacheHelper.sharedPreferences.remove('userName');
      await CacheHelper.sharedPreferences.remove('userEmail');
      await CacheHelper.sharedPreferences.remove('avatarId');

      emit(LogoutSuccessState());
    } catch (e) {
      emit(ProfileErrorState("Logout failed: ${e.toString()}"));
    }
  }
}