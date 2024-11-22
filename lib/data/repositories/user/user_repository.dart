import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pic_share/data/models/user/user_log.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/providers/network/api_response.dart';
import 'package:pic_share/data/providers/network/apis/user/update_user_info_api.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:pic_share/data/providers/network/apis/user/user_log_api.dart';

abstract class UserRepository {
  /* OLD VERSION ( USING FIREBASE TO GET USER DATA)
  Future<UserModel?> getCurrentUserModel();
  Future<void> createUser(User user);
  Future<void> updateUser(
      {required String uid, required Map<String, dynamic> userData});
  Future<void> deleteUser(String id);
  Future<void> checkUserExists({String? uid, String? email, String? phone});
  */

  Future<ApiResponse> updateUserInfo({
    String? name,
    File? urlAvatar,
    String? language,
    bool? isEnableLoginEmail,
  });
  Future<ApiResponse> changePassword(
      {required String currentPassword,
      required String newPassword,
      required String passwordConfirmation});
  Future<ApiResponse> updateFcmToken({required String? fcmToken});
  Future<ApiResponse> deleteUser();
  Future<ApiResponse<UserModel?>> getCurrentUser();
  Future<ApiResponse<UserLog?>> getUserLog({int? userId});
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<ApiResponse> changePassword(
      {required String currentPassword,
      required String newPassword,
      required String passwordConfirmation}) async {
    final response = await ChangePasswordAPI(
            currentPassword: currentPassword,
            newPassword: newPassword,
            passwordConfirmation: passwordConfirmation)
        .request();
    return response;
  }

  @override
  Future<ApiResponse> deleteUser() async {
    final response = await DeleteUserAccAPI().request();
    return response;
  }

  @override
  Future<ApiResponse> updateUserInfo({
    String? name,
    File? urlAvatar,
    String? language,
    bool? isEnableLoginEmail,
  }) async {
    FormData formData = FormData.fromMap({
      if (name != null) "name": name,
      if (urlAvatar != null)
        "url_avatar": await MultipartFile.fromFile(
          urlAvatar.path,
          filename: basename(urlAvatar.path),
        ),
      if (language != null) "language": language,
      if (isEnableLoginEmail != null)
        "is_login_email_enabled": isEnableLoginEmail,
    });
    debugPrint(formData.fields.toString());
    debugPrint(formData.files.toString());
    final response = await UpdateUserInfo(formData: formData).request();
    return response;
  }

  @override
  Future<ApiResponse<UserModel?>> getCurrentUser() async {
    final response = await GetUserInfoAPI().request();

    return response;
  }

  @override
  Future<ApiResponse> updateFcmToken({required String? fcmToken}) async {
    final response = await SetFcmTokenAPI(fcmToken: fcmToken).request();
    return response;
  }

  @override
  Future<ApiResponse<UserLog?>> getUserLog({int? userId}) async {
    final response = await UserLogAPI(userId: userId).request();
    return response;
  }

  /* OLD VERSION ( USING FIREBASE TO GET USER DATA)
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({FirebaseFirestore? firestore, FirebaseAuth? firebaseAuth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<bool> checkUserExists(
      {String? uid, String? email, String? phone}) async {
    try {
      if (uid != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(uid).get();
        if (userDoc.exists) {
          return true;
        }
      }
      // check Email
      if (email != null) {
        QuerySnapshot emailQuery = await _firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();
        if (emailQuery.docs.isNotEmpty) {
          return true;
        }
      }

      // check Phone
      if (phone != null) {
        QuerySnapshot phoneQuery = await _firestore
            .collection('users')
            .where('phone', isEqualTo: phone)
            .limit(1)
            .get();
        if (phoneQuery.docs.isNotEmpty) {
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint("Error checking user existence: $e");
      return false;
    }
  }

  @override
  Future<void> createUser(User user) async {
    try {
      bool userExists = await checkUserExists(
          uid: user.uid, email: user.email, phone: user.phoneNumber);
      if (!userExists) {
        String userCode = user.uid.substring(0, 8);
        UserModel userModel = UserModel(
          id: user.uid,
          config: Config(
            language: 'en',
          ),
          email: user.email,
          name: user.displayName,
          roleType: RoleType.user,
          urlAvatar: user.photoURL,
          userCode: userCode,
          geoInfo: GeoInfo(latitude: 0.0, longitude: 0.0),
        );
        await _firestore.collection('users').doc(user.uid).set(
              userModel.toJson(),
            );
      } else {
        debugPrint("User already exists");
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      await _firestore.collection('users').doc(id).delete();
    } catch (e) {
      debugPrint("Error deleting user in Firestore: $e");
    }
  }

  @override
  Future<UserModel?> getCurrentUserModel() async {
    try {
      /* way 1: 

          final snapshot = await _firestore
          .collection('users')
          .where('id', isEqualTo: _firebaseAuth.currentUser!.uid)
          .get();
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs[0].data();
        return UserModel.fromJson(data);
      }

      More flexible
      Performance may be lower: where will scan the entire collection to find documents that match the condition

      */
      // way 2
      // Directly access documents with UID, Better performance
      DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      if (userDoc.exists) {
        final data = userDoc.data();
        if (data != null) {
          return UserModel.fromJson(data);
        }
      }
    } catch (e) {
      debugPrint("Error deleting user in Firestore: $e");
    }
    return null;
  }

  @override
  Future<void> updateUser(
      {required String uid, required Map<String, dynamic> userData}) {
    throw UnimplementedError();
  }
  */
}
