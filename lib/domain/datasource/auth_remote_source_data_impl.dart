import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import '../../model/my_user.dart';
import 'auth_remote_data_source.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  static const String usersCollection = "Users";

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.googleSignIn,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser = credential.user!;

    final doc =
        await firestore.collection(usersCollection).doc(firebaseUser.uid).get();

    if (!doc.exists) {
      throw Exception("User not found in Firestore");
    }

    return UserModel.fromFirestore(doc.data()!, doc.id);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return Future.error("Google sign in cancelled");
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);

    final firebaseUser = userCredential.user!;

    final doc =
        await firestore.collection(usersCollection).doc(firebaseUser.uid).get();

    if (!doc.exists) {
      final newUser = UserModel(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? "",
        email: firebaseUser.email ?? "",
        phone: firebaseUser.phoneNumber ?? "",
        avaterId: 1,
      );

      await firestore
          .collection(usersCollection)
          .doc(firebaseUser.uid)
          .set(newUser.toFirestore());

      return newUser;
    }
    return UserModel.fromFirestore(doc.data()!, doc.id);
  }
}
