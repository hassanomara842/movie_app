import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../api/api_manager.dart';
import '../../model/my_user.dart';
import '../datasource/auth_remote_data_source.dart';
import '../entities/user_entity.dart';
import 'auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final ApiManager apiManager;
  final AuthRemoteDataSource remoteDataSource;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRepositoryImpl(this.apiManager, this.remoteDataSource, this.firebaseAuth,
      this.firestore);

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

  @override
  Future<UserEntity> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<UserEntity> signInWithGoogle() {
    return remoteDataSource.signInWithGoogle();
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int avaterId,
  }) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser = credential.user!;
    final newUser = UserModel(
      id: firebaseUser.uid,
      name: name,
      email: email,
      phone: phone,
      avaterId: avaterId,
    );

    await firestore
        .collection('Users')
        .doc(firebaseUser.uid)
        .set(newUser.toFirestore());

    return newUser;
  }
}
