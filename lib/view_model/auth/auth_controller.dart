import 'package:get/get.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/token_manager.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/routes/app_pages.dart';

class AuthController extends GetxController {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final LocalStorageService localStorageService;
  final _tokenManager = TokenManager();
  AuthController({
    required this.authRepository,
    required this.userRepository,
    required this.localStorageService,
  });
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  UserModel? get getCurrentUser => currentUser.value;

  @override
  void onInit() async {
    currentUser.value = localStorageService.userModel;

    super.onInit();
  }

  @override
  onReady() async {
    if (currentUser.value == null) {
      Get.offAllNamed(Routes.login);
    } else {
      Get.offAllNamed(Routes.navBar);
    }
    ever(localStorageService.isUserNull, (callback) {
      if (callback) {
        logout();
      } else {
        Get.offAllNamed(Routes.navBar);
      }
      currentUser.value = localStorageService.userModel;
    });
  }

  // void obseverUserState() {
  //   _firebaseAuth.authStateChanges().listen((user) {
  //     currentUser.value = user;
  //     if (user == null) {
  //       Get.offAllNamed(Routes.login);
  //     } else {
  //       Get.offAllNamed(Routes.navBar);
  //     }
  //   });
  // }

  // Future<void> getUserModelChanged() async {
  //   ever(currentUser, (callback) async {
  //     if (currentUser.value != null) {
  //       await userRepository.createUser(currentUser.value!);

  //       await getCurrentUserModelData();
  //     }
  //   });
  // }

  // Future<void> getCurrentUserModelData() async {
  //   try {
  //     currentUserModel.value = await userRepository.getCurrentUserModel();
  //   } catch (e) {
  //     debugPrint("Something went wrong: ${e.toString()}");
  //   }
  // }

  Future<void> logout() async {
    await authRepository.logout();
    currentUser.value = null;
    Get.offAllNamed(Routes.login);
    _tokenManager.deleteAll();
  }

  // Future<void> updateUserInfo(Map<String, dynamic> jsonData) async {
  //   try {
  //     await userRepository.updateUser(
  //         uid: currentUser.value!.uid, userData: jsonData);
  //     await getCurrentUserModelData();
  //   } catch (e) {
  //     debugPrint("Something went wrong: ${e.toString()}");
  //   }
  // }
}
