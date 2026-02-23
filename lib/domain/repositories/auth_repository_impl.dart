import 'package:injectable/injectable.dart';
import '../../api/api_manager.dart';
import '../entities/user_entity.dart';import 'auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final ApiManager apiManager;

  AuthRepositoryImpl(this.apiManager);

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    final response = await apiManager.register(
      name,
      email,
      password,
      confirmPassword,
      phone,
      avaterId,
    );

    print("MESSAGE: ${response.message}");
    print("DATA: ${response.data}");
    print("FULL JSON: ${response.toJson()}");

    final data = response.data;
    if (data == null) {
      throw Exception(response.message ?? "Registration failed");
    }

    return data.toEntity();
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final response = await apiManager.login(email, password);

    print("LOGIN MESSAGE: ${response.message}");
    print("LOGIN DATA: ${response.data}");

    final data = response.data;
    if (data == null) {
      throw Exception(response.message ?? "Login failed");
    }

    return data.toEntity();
  }

  @override
  Future<UserEntity> updateProfile({
    required String name,
    required String phone,
    required int avaterId,
  }) async {
    final response = await apiManager.updateProfile(
      name: name,
      phone: phone,
      avaterId: avaterId,
    );

    print("UPDATE PROFILE MESSAGE: ${response.message}");
    print("UPDATE PROFILE DATA: ${response.data}");

    final data = response.data;
    if (data == null) {
      throw Exception(response.message ?? "Update profile failed");
    }

    return data.toEntity();
  }

  @override
  Future<void> deleteAccount() async {
    await apiManager.deleteAccount();
  }
}