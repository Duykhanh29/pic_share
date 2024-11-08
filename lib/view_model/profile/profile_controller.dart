import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/data/models/paging.dart';
import 'package:pic_share/data/models/post/post.dart';
import 'package:pic_share/data/models/post/post_detail.dart';
import 'package:pic_share/data/models/user/user_log.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';

class ProfileController extends GetxController {
  AuthController authController;
  PostRepository postRepository;
  UserRepository userRepository;
  ProfileController({
    required this.authController,
    required this.postRepository,
    required this.userRepository,
  });

  UserModel? get currentUser => authController.getCurrentUser;

  RxList<Post> latestPosts = <Post>[].obs;
  RxBool isLoading = true.obs;
  RxBool isUserLogLoading = true.obs;
  RxInt postCount = 0.obs;
  Rx<PostDetail?> postDetail = Rx<PostDetail?>(null);
  Rx<UserLog?> userLog = Rx<UserLog?>(null);

  @override
  void onInit() async {
    await fecthUserLog();
    await fetchData();
    super.onInit();
  }

  Future<void> fecthUserLog() async {
    isUserLogLoading.value = true;
    try {
      final response = await userRepository.getUserLog();
      if (response.isSuccess) {
        userLog.value = response.data;
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? "");
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isUserLogLoading.value = false;
    }
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Paging<Post> paging = await postRepository.getPostHistory(page: 1);
      latestPosts.value = paging.data;
      postCount.value = paging.totalResults;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void onNavToEditProfile() {
    Get.toNamed(Routes.editProfile);
  }

  void onNavToPostHistory() {
    Get.toNamed(Routes.postHistory);
  }

  void onCopyUserCode() {
    Clipboard.setData(ClipboardData(text: currentUser?.userCode ?? ""));
  }

  void onTapDetail(int id) async {
    final result = await Get.toNamed(Routes.postDetail, arguments: {
      Strings.postId: id,
    });
    if (result == true) {
      latestPosts.removeWhere((post) => post.id == id);
    }
  }
}
