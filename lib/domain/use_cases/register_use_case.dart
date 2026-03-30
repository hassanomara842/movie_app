import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int avaterId,
  }) async {
    return await repository.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
      avaterId: avaterId,
    );
  }
}