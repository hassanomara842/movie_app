import 'package:injectable/injectable.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      avaterId: avaterId,
    );
  }
}
