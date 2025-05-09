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
import 'package:pic_share/data/repositories/conversations/conversation_repository.dart';
import 'package:pic_share/data/repositories/notification/notification_repository.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/conversations/conversations_controller.dart';
import 'package:pic_share/view_model/drawer/drawer_controller.dart';

class HomeController extends GetxController {
  PostRepository postRepository;
  AuthController authController;
  AppDrawerController appDrawerController;
  NotificationRepository notificationRepository;
  HomeController({
    required this.postRepository,
    required this.authController,
    required this.appDrawerController,
    required this.notificationRepository,
  });

  late TextEditingController reasonController;

  RxList<PostData> posts = <PostData>[].obs;
  RxList<PostData> actualDisplayPosts = <PostData>[].obs;

  RxList<UserSummaryModel> listViews = <UserSummaryModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isUserViewsLoading = false.obs;
  Rx<int> currentIndex = 0.obs;
  RxBool isActionLoading = false.obs;

  UserModel? get currentUser => authController.getCurrentUser;
  Rx<int> unseenNotiCount = 0.obs;
  @override
  void onInit() async {
    ever(
      appDrawerController.selectedUserId,
      (userID) async {
        filterPostByUserId(userID);
      },
    );
    ever(authController.currentUser, (UserModel? user) async {
      if (user != null) {
        posts.clear();
        await fetchPosts();
        await getUnseenNotificationCount();
      }
    });
    await fetchPosts();
    await getUnseenNotificationCount();
    super.onInit();
  }

  Future<void> getUnseenNotificationCount() async {
    unseenNotiCount.value =
        await notificationRepository.getUnseenNotificationCount();
  }

  void onOpenReportSHeet() {
    reasonController = TextEditingController();
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  Future<void> onRefresh() async {
    isLoading.value = true;
    posts.clear();
    actualDisplayPosts.clear();
    await getUnseenNotificationCount();
    await fetchPosts(userId: appDrawerController.selectedUserId.value);
  }

  Future<void> fetchPosts({int? userId}) async {
    isLoading.value = true;
    try {
      posts.clear();
      actualDisplayPosts.clear();
      final response = await postRepository.getPostsForUser(userId: userId);
      if (response.isSuccess) {
        List<PostDetail> listPost = response.data ?? <PostDetail>[];
        for (var post in listPost) {
          PostData postData = PostData(post: post);
          if (post.userLikes.any((element) => element.id == currentUser?.id)) {
            postData.isLike = true;
          }
          posts.add(postData);
        }
        actualDisplayPosts.value = posts;
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void filterPostByUserId(int? userId) {
    if (userId == null) {
      actualDisplayPosts.value = posts;
    } else {
      final list =
          posts.where((element) => element.post.user?.id == userId).toList();
      actualDisplayPosts.value = list;
    }
  }

  Future<void> fetchUserViews(int id) async {
    isUserViewsLoading.value = true;
    try {
      final response = await postRepository.getUserViews(id);
      if (response.isSuccess) {
        listViews.value = response.data ?? <UserSummaryModel>[];
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isUserViewsLoading.value = false;
    }
  }

  Future<void> deletePost(int id) async {
    isActionLoading.value = true;
    try {
      final response = await postRepository.deletePost(id);
      if (response.isSuccess) {
        posts.removeWhere((element) => element.post.id == id);
        SnackbarHelper.successSnackbar(response.message ?? '');
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    } finally {
      isActionLoading.value = false;
    }
  }

  Future<void> reportPost(int id, String reason) async {
    isActionLoading.value = true;
    try {
      final response = await postRepository.reportPost(id: id, reason: reason);
      if (response.isSuccess) {
        SnackbarHelper.successSnackbar(response.message ?? '');
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    } finally {
      isActionLoading.value = false;
    }
  }

  Future<void> addLike(int id) async {
    try {
      final response = await postRepository.addNewUserLike(id);
      if (response.isSuccess) {
        updatePostsData(id, true);
      } else {
        debugPrint(response.message ?? '');
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
        updatePostsData(id, false);
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> addView(int id) async {
    try {
      await postRepository.addNewUserView(id);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  void updatePostsData(int id, bool isLike) {
    int index =
        actualDisplayPosts.indexWhere((element) => element.post.id == id);
    if (index != -1) {
      actualDisplayPosts[index] = actualDisplayPosts[index].copyWith(
        post: actualDisplayPosts[index].post.copyWith(
              likeCount: isLike
                  ? actualDisplayPosts[index].post.likeCount + 1
                  : actualDisplayPosts[index].post.likeCount - 1,
            ),
        isLike: isLike,
      );
    }
  }

  void listenToNewEvent(PostData postData) {
    posts.insert(0, postData); //
  }

  // navigation

  void onNavToNotification() {
    Get.toNamed(Routes.notification);
  }

  void onNavToGridPostView() {
    Get.toNamed(Routes.gridPostView);
  }

  void onNavigateToHomeWithIndex(int index) {
    currentIndex.value = index;
    Get.back();
  }

  void onNavigateToHomeWithPostId(int? id) {
    int index =
        actualDisplayPosts.indexWhere((element) => element.post.id == id);
    currentIndex.value = index == -1 ? 0 : index;
  }

  // download image
  Future<void> onDownloadImageToGallery(
      String urlPath, String successText, String errorText) async {
    try {
      String url = AppConfig.baseUrl + urlPath;
      bool? result = await FileUtils().saveImageFromUrlToGallery(url);
      if (result == true) {
        SnackbarHelper.successSnackbar(successText);
      } else {
        SnackbarHelper.errorSnackbar(errorText);
      }
    } catch (e) {
      debugPrint('Error occurred while downloading picture: $e');
    }
  }

  // send message

  Future<void> sendMessage(int postId) async {
    try {
      final index =
          actualDisplayPosts.indexWhere((post) => post.post.id == postId);
      if (index != -1) {
        final post = actualDisplayPosts[index];
        if (post.post.user != null) {
          final user = post.post.user!;
          if (!Get.isRegistered<ConversationsController>()) {
            Get.put(
              ConversationsController(
                conversationRepository: Get.find<ConversationRepository>(),
                authController: Get.find<AuthController>(),
              ),
            );
          }
          final conversationController = Get.find<ConversationsController>();
          await conversationController.onClickStartChat(
            user,
            urlImage: post.post.urlImage,
          );
        }
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    }
  }

  PostDetail? getPostDetail(int postId) {
    int index =
        actualDisplayPosts.indexWhere((element) => element.post.id == postId);
    if (index != -1) {
      return actualDisplayPosts[index].post;
    }
    return null;
  }

  void onNavToLocationView(int? id) {
    if (id == null) return;
    PostDetail? post = getPostDetail(id);
    if (post == null) return;
    Get.toNamed(Routes.postsLocation, arguments: {
      Strings.postDetail: post,
    });
  }

  void onUserClick(UserSummaryModel? user) {
    if (user == null) return;
    if (user.id == currentUser?.id) {
      Get.toNamed(Routes.profile);
    } else {
      Get.toNamed(Routes.friendProfile, arguments: {
        Strings.userSummary: user,
      });
    }
  }

  void resetIndexes() {
    currentIndex.value = 0;
    posts.value = [];
    actualDisplayPosts.value = [];
  }
}
