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
  Future<void> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception("Failed to send reset email: ${e.toString()}");
    }
  }

  @override
  Future<UserEntity> getUserProfile() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw Exception("User is not logged in");
      }
      final doc = await firestore.collection('Users').doc(user.uid).get();
      if (!doc.exists) {
        throw Exception("User data not found in Firestore");
      }
      final data = doc.data()!;
      return UserEntity(
        id: user.uid,
        name: data['name'] ?? '',
        email: data['email'] ?? user.email ?? '',
        phone: data['phone'] ?? '',
        avaterId: data['avaterId'] ?? 0,
      );
    } catch (e) {
      throw Exception("Failed to get profile: ${e.toString()}");
    }
  }

  @override
  Future<UserEntity> updateProfile({
    required String name,
    required String phone,
    required int avaterId,
  }) async {
    try {
      final userId = firebaseAuth.currentUser?.uid;
      if (userId == null) {
        throw Exception("User is not logged in");
      }
      await firestore.collection('Users').doc(userId).update({
        'name': name,
        'phone': phone,
        'avaterId': avaterId,
      });
      return UserEntity(
        id: userId,
        name: name,
        email: firebaseAuth.currentUser?.email ?? '',
        phone: phone,
        avaterId: avaterId,
      );
    } catch (e) {
      throw Exception("Failed to update profile: ${e.toString()}");
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw Exception("User is not logged in");
      }
      final userId = user.uid;
      await firestore.collection('Users').doc(userId).delete();
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception(
            'This operation is sensitive and requires recent authentication. Log in again before retrying this request.');
      }
      rethrow;
    } catch (e) {
      throw Exception("Failed to delete account: ${e.toString()}");
    }
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