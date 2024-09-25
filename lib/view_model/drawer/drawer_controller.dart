import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/data/models/user/friend.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';

class AppDrawerController extends GetxController {
  AuthController authController;
  FriendController friendController;
  AppDrawerController(
      {required this.authController, required this.friendController});

  UserModel? get currentUser => authController.getCurrentUser;
  List<Friend> get friendList => friendController.friends;
  Rx<int?> selectedUserId = Rx<int?>(null);

  @override
  void onInit() {
    ever(authController.currentUser, (user) {
      if (user != null) {
        selectedUserId.value = null;
      }
    });
    super.onInit();
  }

  Future<void> logout() async {
    await authController.logout();
  }

  void onChangeSelectedUserId(int? id) {
    selectedUserId.value = id;
  }

  void closeDrawer(BuildContext context) {
    Scaffold.of(context).closeDrawer();
  }
}
