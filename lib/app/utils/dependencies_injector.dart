import 'package:get/get.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';

class DependenciesInjector {
  static Future<void> initDependencies() async {
    Get.put<AuthRepository>(AuthRepositoryImpl(), permanent: true);
    Get.put<UserRepository>(UserRepositoryImpl(), permanent: true);
  }
}
