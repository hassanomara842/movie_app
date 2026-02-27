import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';import 'package:injectable/injectable.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import '../domain/usecases/google_signin_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/register_usecase.dart';
import '../domain/usecases/reset_password_usecase.dart';
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
      Fluttertoast.showToast(
        msg: "reset_email_sent".tr(),
        backgroundColor: AppColors.primaryYellow,
        textColor: AppColors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: getReadableError(e as Exception),
        backgroundColor: AppColors.primaryYellow,
        textColor: AppColors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );
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
      Fluttertoast.showToast(
        msg: "registration_successful".tr(),
        backgroundColor: AppColors.primaryYellow,
        textColor: AppColors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: getReadableError(e as Exception),
        backgroundColor: AppColors.primaryYellow,
        textColor: AppColors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(email, password);
      emit(AuthSuccess(user));
      Fluttertoast.showToast(
        msg: "login_successful".tr(),
        backgroundColor: AppColors.primaryYellow,
        textColor: AppColors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: getReadableError(e as Exception),
        backgroundColor: AppColors.primaryYellow,
        textColor: AppColors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );
    }
  }

  Future<void> signInWithGoogle() async {
    Fluttertoast.showToast(
      msg: "loading..".tr(),
      backgroundColor: AppColors.primaryYellow,
      textColor: AppColors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
    );
    emit(AuthLoading());
    try {
      final user = await googleSignInUseCase();

      if (user == null) {
        Fluttertoast.showToast(
          msg: "google_sign_in_cancelled".tr(),
          backgroundColor: AppColors.primaryYellow,
          textColor: AppColors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
        );
        emit(AuthInitial());
        return;
      }

      Fluttertoast.showToast(
        msg: "loading..".tr(),
        backgroundColor: AppColors.primaryYellow,
        textColor: AppColors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );

      emit(AuthSuccess(user));
      Fluttertoast.showToast(
        msg: "login_successful".tr(),
        backgroundColor: AppColors.primaryYellow,
        textColor: AppColors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: getReadableError(e),
        backgroundColor: AppColors.primaryYellow,
        textColor: AppColors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );
      emit(AuthError(getReadableError(e)));
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: AppColors.primaryYellow,
        textColor: AppColors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );
      emit(AuthError(e.toString()));
    }
  }
}