import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/helpers/cache_helper.dart';
import 'package:movie_app/cubit/login_states.dart';
import '../domain/usecases/login_usecase.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(LoginInitial());
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    try {
      final user = await loginUseCase(
        email: email,
        password: password,
      );
      await CacheHelper.saveUserData(
        name: user.name,
        email: user.email,
        avatarId: user.avaterId,
      );

      emit(LoginSuccessState(user));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}