import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';

@injectable
class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<void> call() {
    return repository.deleteAccount();
  }
}