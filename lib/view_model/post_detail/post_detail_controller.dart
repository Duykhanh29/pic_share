import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/config/app_config.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/app/utils/file_utils.dart';
import 'package:pic_share/data/models/post/post_data.dart';
import 'package:pic_share/data/models/post/post_detail.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';

class PostDetailController extends GetxController {
  PostRepository postRepository;
  AuthController authController;

  PostDetailController(
      {required this.postRepository, required this.authController}) {
    if (Get.arguments != null) {
      postId.value = Get.arguments[Strings.postId] as int;
    }
  }

  UserModel? get currentUser => authController.getCurrentUser;

  RxList<UserSummaryModel> listViews = <UserSummaryModel>[].obs;
  Rx<int> postId = 0.obs;
  Rx<PostData?> postData = Rx<PostData?>(null);
  RxBool isLoading = true.obs;
  RxBool isUserViewsLoading = false.obs;
  @override
  void onInit() async {
    await fetchPostDetail();
    super.onInit();
  }

  Future<void> fetchPostDetail() async {
    isLoading.value = true;
    try {
      final response = await postRepository.getPostDetail(postId.value);
      if (response.isSuccess) {
        PostDetail? postDetail = response.data;
        if (postDetail != null) {
          bool isLike = false;
          if (postDetail.userLikes
              .any((element) => element.id == currentUser?.id)) {
            isLike = true;
          }
          postData.value = PostData(post: postDetail, isLike: isLike);
        }
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addLike(int id) async {
    try {
      final response = await postRepository.addNewUserLike(id);
      if (response.isSuccess) {
        updatePostsData(true);
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> dislikePost({required int id, required int userId}) async {
    try {
      final response = await postRepository.dislikePost(id: id, userId: userId);
      if (response.isSuccess) {
        updatePostsData(false);
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  void updatePostsData(bool isLike) {
    postData.value = postData.value?.copyWith(isLike: isLike);
  }

  Future<void> fetchUserViews(int id) async {
    isUserViewsLoading.value = true;
    try {
      final response = await postRepository.getUserViews(id);
      if (response.isSuccess) {
        listViews.value = response.data ?? <UserSummaryModel>[];
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isUserViewsLoading.value = false;
    }
  }

  Future<void> onDownloadImageToGallery(String urlPath) async {
    try {
      String url = AppConfig.baseUrl + urlPath;
      bool? result = await FileUtils().saveImageFromUrlToGallery(url);
      if (result == true) {
        SnackbarHelper.successSnackbar("Downloaded successfully");
      } else {
        SnackbarHelper.errorSnackbar("Download failed");
      }
    } catch (e) {
      debugPrint('Error occured while downloading picture: $e');
    }
  }

  Future<void> deletePost(int id) async {
    try {
      final response = await postRepository.deletePost(id);
      if (response.isSuccess) {
        Get.back();
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    }
  }

  void onNavToLocationView() {
    if (postData.value == null) return;
    Get.toNamed(Routes.postsLocation, arguments: {
      Strings.postDetail: postData.value,
    });
  }
}
