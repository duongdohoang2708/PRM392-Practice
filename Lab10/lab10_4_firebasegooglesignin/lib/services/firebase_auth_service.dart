import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../models/firebase_user.dart';

/// Handles Firebase Google authentication.
///
/// Responsibilities:
///
/// - Open Google login
/// - Authenticate with Firebase
/// - Logout user
class FirebaseAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUserModel?> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return null;
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,

      idToken: googleAuth.idToken,
    );

    final result = await firebaseAuth.signInWithCredential(credential);

    final user = result.user;

    if (user == null) {
      return null;
    }

    return FirebaseUserModel(
      uid: user.uid,

      name: user.displayName ?? "",

      email: user.email ?? "",

      photoUrl: user.photoURL ?? "",
    );
  }

  Future<void> logout() async {
    await googleSignIn.signOut();

    await firebaseAuth.signOut();
  }
}
