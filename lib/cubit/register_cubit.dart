import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/cubit/register_states.dart';
import '../domain/usecases/register_usecase.dart';

@injectable
class RegisterCubit extends Cubit<RegisterStates> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    emit(RegisterLoadingState());

    try {
      final user = await registerUseCase(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phone: phone,
        avaterId: avaterId,
      );

      emit(RegisterSuccessState(user));
    } catch (e) {
      print(e.toString());
      emit(RegisterErrorState(e.toString()));
    }
  }
}