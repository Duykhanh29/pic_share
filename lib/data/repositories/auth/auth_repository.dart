import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/providers/network/apis/auth/auth_api.dart';

abstract class AuthRepository {
  Future<UserModel?> registerUserByEmailAndPass(
      {required String email,
      required String password,
      required String name,
      required String confirmPassword});
  Future<UserModel?> signInWithEmailPass(
      {required String email, required String password});
  Future<UserModel?> signInWithGoogle();
  Future<void> logout();

  /*
   OLD VERSION ( USING FIREBASE TO IMPLEMENT AUTHEN)
  Future<User?> registerUserByEmailAndPass(
      {required String email, required String password});
  Future<User?> signInWithEmailPass(
      {required String email, required String password});
  Future<User?> signInWithGoogle();
  Future<User?> signInWithFacebook();
  Future<void> signOut();
  Future<User?> getCurrentUser();
  */
}

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<UserModel?> registerUserByEmailAndPass(
      {required String email,
      required String password,
      required String name,
      required String confirmPassword}) async {
    try {
      final response = await RegisterAPI(
              email: email,
              name: name,
              password: password,
              passwordConfirmation: confirmPassword)
          .request();
      final userData = response['user'];
      UserModel user = UserModel.fromJson(userData);
      return user;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<UserModel?> signInWithEmailPass(
      {required String email, required String password}) async {
    try {
      final response = await LoginAPI(
        email: email,
        password: password,
      ).request();
      final userData = response['user'];
      UserModel user = UserModel.fromJson(userData);
      return user;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      debugPrint("TOken iss: ${googleAuth.idToken}");
      debugPrint("Access Token: ${googleAuth.accessToken}");
      if (googleAuth.accessToken != null) {
        final response =
            await LoginWithGoogleAPI(accessToken: googleAuth.accessToken!)
                .request();
        final userData = response['data'];
        UserModel user = UserModel.fromJson(userData);
        return user;
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<void> logout() async {
    try {
      final response = await LogoutAPI().request();
      debugPrint("Message: ${response['message']}");
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  /* OLD VERSION ( USING FIREBASE TO IMPLEMENT AUTHEN)
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<User?> registerUserByEmailAndPass(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<User?> signInWithEmailPass(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<User?> signInWithFacebook() {
    throw UnimplementedError();
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint("Error signing out: $e");
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      return _firebaseAuth.currentUser;
    } catch (e) {
      debugPrint("Error getting current user: $e");
      return null;
    }
  }
  */
}
