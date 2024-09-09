import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pic_share/data/models/paging.dart';
import 'package:pic_share/data/models/post/post.dart';
import 'package:pic_share/data/models/post/post_detail.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';

class ProfileController extends GetxController {
  AuthController authController;
  PostRepository postRepository;
  ProfileController(
      {required this.authController, required this.postRepository});

  UserModel? get currentUser => authController.getCurrentUser;

  RxList<Post> latestPosts = <Post>[].obs;
  RxBool isLoading = false.obs;
  RxInt postCount = 0.obs;
  Rx<PostDetail?> postDetail = Rx<PostDetail?>(null);

  @override
  void onInit() async {
    await fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Paging<Post> paging = await postRepository.getPostHistory(1);
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

  void onCopyUserCode() {
    Clipboard.setData(ClipboardData(text: currentUser?.userCode ?? ""));
  }

  Future<void> onTapDetail(int id) async {
    try {
      postDetail.value = await postRepository.getPostDetail(id);
      debugPrint("Data is: ${postDetail.value?.id}");
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {}
  }
}
