import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/pusher_service.dart';
import 'package:pic_share/data/repositories/conversations/conversation_repository.dart';
import 'package:pic_share/data/repositories/notification/notification_repository.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/conversations/conversations_controller.dart';
import 'package:pic_share/view_model/drawer/drawer_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/view_model/home/home_controller.dart';
import 'package:pic_share/view_model/new_post/new_post_controller.dart';
import 'package:pic_share/view_model/settings/settings_controller.dart';

class NavBottomController extends GetxController {
  final PersistentTabController pageController = PersistentTabController();
  RxInt pageIndex = 0.obs;
  RxInt chatUnreadCount = 0.obs;
  @override
  void onInit() {
    if (pageIndex.value != 0) {
      pageIndex.value = 0;
    }

    // Get.put(
    //     FriendController(
    //       friendRepository: Get.find<FriendRepository>(),
    //       authController: Get.find<AuthController>(),
    //     ),
    //     permanent: true);
    // Get.put(
    //   AppDrawerController(
    //     authController: Get.find<AuthController>(),
    //     friendController: Get.find<FriendController>(),
    //   ),
    // );
    Get.put(
        HomeController(
          postRepository: Get.find<PostRepository>(),
          authController: Get.find<AuthController>(),
          appDrawerController: Get.find<AppDrawerController>(),
          notificationRepository: Get.find<NotificationRepository>(),
        ),
        permanent: true);
    Get.put(
        NewPostController(
          postRepository: Get.find<PostRepository>(),
          friendController: Get.find<FriendController>(),
          authController: Get.find<AuthController>(),
        ),
        permanent: true);
    Get.put(
        ConversationsController(
          conversationRepository: Get.find<ConversationRepository>(),
          authController: Get.find<AuthController>(),
        ),
        permanent: true);
    Get.put(
        SettingsController(
          authController: Get.find<AuthController>(),
          friendController: Get.find<FriendController>(),
          localStorageService: Get.find<LocalStorageService>(),
        ),
        permanent: true);

    Get.put(
      PusherService(
        authController: Get.find<AuthController>(),
        conversationsController: Get.find<ConversationsController>(),
      ),
    );
    final conversationController = Get.find<ConversationsController>();
    ever(conversationController.conversationData, (data) {
      if (data.unreadCount != chatUnreadCount.value) {
        chatUnreadCount.value = data.unreadCount;
      }
    });

    super.onInit();
  }

  void changeNavigationPage(int index) {
    if (pageIndex.value == 2) {
      Get.find<NewPostController>().onSetToDefault();
    }
    pageIndex.value = index;
    pageController.index = index;
    // if (index == 1) {
    //   Get.find<FriendController>().onRefresh();
    // }
  }

  void onChangeToHome() {
    pageIndex.value = 0;
    pageController.index = 0;
  }

  void onChangeToFriend() {
    pageIndex.value = 1;
    pageController.index = 1;
  }

  void onChangeToNewPost() {
    pageIndex.value = 2;
    pageController.index = 2;
  }
}
