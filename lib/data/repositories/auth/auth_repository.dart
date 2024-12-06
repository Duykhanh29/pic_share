import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pic_share/data/models/auth/qrcode_response.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/providers/network/api_response.dart';
import 'package:pic_share/data/providers/network/apis/auth/auth_api.dart';

abstract class AuthRepository {
  Future<ApiResponse<UserModel?>> registerUserByEmailAndPass({
    required String email,
    required String password,
    required String name,
    required String confirmPassword,
    String? deviceId,
    String? deviceName,
  });
  Future<ApiResponse<UserModel?>> signInWithEmailPass({
    required String email,
    required String password,
    String? deviceId,
    String? deviceName,
  });
  Future<ApiResponse<UserModel?>> signInWithGoogle();
  Future<ApiResponse> logout({String? deviceId});
  Future<ApiResponse<String?>> refreshToken({required String refreshToken});

  Future<ApiResponse<String?>> verify2FA({required String code});
  Future<ApiResponse<QRCodeResponse?>> updateState2FA(
      {required String password});
  Future<ApiResponse> confirmEnable2FA({required String code});
  Future<ApiResponse<int>> forgotPassword({required String email});
  Future<ApiResponse> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
  });

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
  Future<ApiResponse<UserModel?>> registerUserByEmailAndPass({
    required String email,
    required String password,
    required String name,
    required String confirmPassword,
    String? deviceId,
    String? deviceName,
  }) async {
    final response = await RegisterAPI(
      email: email,
      name: name,
      password: password,
      passwordConfirmation: confirmPassword,
      deviceId: deviceId,
      deviceName: deviceName,
    ).request();
    return response;
  }

  @override
  Future<ApiResponse<UserModel?>> signInWithEmailPass({
    required String email,
    required String password,
    String? deviceId,
    String? deviceName,
  }) async {
    final response = await LoginAPI(
      email: email,
      password: password,
      deviceId: deviceId,
      deviceName: deviceName,
    ).request();
    return response;
  }

  @override
  Future<ApiResponse<UserModel?>> signInWithGoogle() async {
    // try {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return ApiResponse(
        status: ApiStatus.failure,
      );
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    debugPrint("TOken iss: ${googleAuth.idToken}");
    debugPrint("Access Token: ${googleAuth.accessToken}");
    if (googleAuth.accessToken != null) {
      final response =
          await LoginWithGoogleAPI(accessToken: googleAuth.accessToken!)
              .request();
      return response;
    }
    return ApiResponse(
      status: ApiStatus.failure,
    );
  }

  @override
  Future<ApiResponse> logout({String? deviceId}) async {
    final response = await LogoutAPI(deviceId: deviceId).request();
    return response;
  }

  @override
  Future<ApiResponse<String?>> refreshToken(
      {required String refreshToken}) async {
    final response =
        await RefreshTokenApi(refreshToken: refreshToken).request();
    return response;
  }

  @override
  Future<ApiResponse> confirmEnable2FA({required String code}) async {
    final response = await ConfirmEnable2FAApi(code: code).request();
    return response;
  }

  @override
  Future<ApiResponse<QRCodeResponse?>> updateState2FA(
      {required String password}) async {
    final response = await UpdateState2FAApi(password: password).request();
    return response;
  }

  @override
  Future<ApiResponse<String?>> verify2FA({required String code}) async {
    final response = Check2FAApi(code: code).request();
    return response;
  }

  @override
  Future<ApiResponse<int>> forgotPassword({required String email}) async {
    final response = await ForgotPasswordApi(email: email).request();
    return response;
  }

  @override
  Future<ApiResponse> resetPassword(
      {required String email,
      required String password,
      required String passwordConfirmation,
      required String otp}) async {
    final response = await ResetPasswordApi(
      confirmPassword: passwordConfirmation,
      email: email,
      otp: otp,
      password: password,
    ).request();
    return response;
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
