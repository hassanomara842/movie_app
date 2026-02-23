import 'package:injectable/injectable.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class UpdateProfileUseCase {
  final AuthRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String phone,
    required int avaterId,
  }) {
    return repository.updateProfile(
      name: name,
      phone: phone,
      avaterId: avaterId,
    );
  }
}