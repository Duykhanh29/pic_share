import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:pic_share/routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserRepository userRepository;
  final AuthRepository authRepository;
  AuthController({
    required this.authRepository,
    required this.userRepository,
  });
  Rx<UserModel?> currentUserModel = Rx<UserModel?>(null);

  final Rxn<User> currentUser = Rxn<User>();

  UserModel? get getCurrentUserModel => currentUserModel.value;
  User? get getCurrentUser => currentUser.value;
  bool get isAuthenticated => currentUser.value != null;
  @override
  void onInit() async {
    obseverUserState();
    await getUserModelChanged();
    super.onInit();
  }

  void obseverUserState() {
    _firebaseAuth.authStateChanges().listen((user) {
      currentUser.value = user;
      if (user == null) {
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.navBar);
      }
    });
  }

  Future<void> getUserModelChanged() async {
    ever(currentUser, (callback) async {
      if (currentUser.value != null) {
        await userRepository.createUser(currentUser.value!);

        await getCurrentUserModelData();
      }
    });
  }

  Future<void> getCurrentUserModelData() async {
    try {
      currentUserModel.value = await userRepository.getCurrentUserModel();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    currentUser.value = null;
    currentUserModel.value = null;
  }

  Future<void> updateUserInfo(Map<String, dynamic> jsonData) async {
    try {
      await userRepository.updateUser(
          uid: currentUser.value!.uid, userData: jsonData);
      await getCurrentUserModelData();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }
}
