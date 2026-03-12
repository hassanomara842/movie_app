import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> getUserProfile();

  Future<UserEntity> updateProfile({
    required String name,
    required String phone,
    required int avaterId,
  });

  Future<void> deleteAccount();

  Future<UserEntity> login(String email, String password);

  Future<UserEntity> signInWithGoogle();

  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int avaterId,
  });
  Future<void> resetPassword(String email);
}