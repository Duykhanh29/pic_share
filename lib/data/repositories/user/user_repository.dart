import 'package:flutter/material.dart';
import 'package:pic_share/data/enums/role_type.dart';
import 'package:pic_share/data/models/user/user_model.dart';

abstract class UserRepository {
  /* OLD VERSION ( USING FIREBASE TO GET USER DATA)
  Future<UserModel?> getCurrentUserModel();
  Future<void> createUser(User user);
  Future<void> updateUser(
      {required String uid, required Map<String, dynamic> userData});
  Future<void> deleteUser(String id);
  Future<void> checkUserExists({String? uid, String? email, String? phone});
  */
}

class UserRepositoryImpl implements UserRepository {
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
