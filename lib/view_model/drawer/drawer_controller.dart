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
  Future<void> logout() async {
    await authController.logout();
  }
}
