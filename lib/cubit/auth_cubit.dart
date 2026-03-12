import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../domain/use_cases/google_sign_in_use_case.dart';
import '../domain/use_cases/login_use_case.dart';
import '../domain/use_cases/register_use_case.dart';
import '../domain/use_cases/reset_password_use_case.dart';
import 'auth_states.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final GoogleSignInUseCase googleSignInUseCase;
  final RegisterUseCase registerUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.googleSignInUseCase,
    required this.registerUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthInitial());

  String getReadableError(Exception e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          return "email_already_in_use".tr();
        case 'invalid-email':
          return "invalid_email".tr();
        case 'weak-password':
          return "weak_password".tr();
        case 'user-not-found':
          return "user_not_found".tr();
        case 'wrong-password':
          return "wrong_password".tr();
        case 'network-request-failed':
          return "network_error".tr();
        case "invalid-credential":
          return "invalid_email_or_password".tr();
        default:
          return "unexpected_error".tr();
      }
    } else {
      return e.toString();
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await resetPasswordUseCase(email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(AuthError(getReadableError(e as Exception)));
    }
  }

  void register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int avaterId,
  }) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase.call(
        name: name,
        email: email,
        password: password,
        phone: phone,
        avaterId: avaterId,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(getReadableError(e as Exception)));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final user = await googleSignInUseCase();
      emit(AuthSuccess(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(getReadableError(e)));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
