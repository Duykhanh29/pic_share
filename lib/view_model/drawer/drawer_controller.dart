import 'package:get/get.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';

class AppDrawerController extends GetxController {
  AuthController authController;
  AppDrawerController({required this.authController});

  UserModel? get currentUser => authController.getCurrentUser;
  Future<void> logout() async {
    await authController.logout();
  }
}
