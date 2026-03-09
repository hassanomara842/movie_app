import 'package:injectable/injectable.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class GoogleSignInUseCase {
  final AuthRepository repository;

  GoogleSignInUseCase(this.repository);

  Future<UserEntity> call() {
    return repository.signInWithGoogle();
  }
}