import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/enums/friend_noti_type.dart';
import 'package:pic_share/data/enums/link_to_type.dart';
import 'package:pic_share/data/models/notification/link_to_model.dart';
import 'package:pic_share/data/models/notification/notification.dart';
import 'package:pic_share/data/models/paging.dart';
import 'package:pic_share/data/models/post/deleted_post.dart';
import 'package:pic_share/data/repositories/notification/notification_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/view_model/home/home_controller.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_controller.dart';

class NotificationController extends GetxController {
  NotificationRepository notificationRepository;
  FriendController friendController;
  NavBottomController navBottomController;
  HomeController homeController;

  NotificationController({
    required this.notificationRepository,
    required this.friendController,
    required this.navBottomController,
    required this.homeController,
  });

  RxBool isLoading = true.obs;

  final PagingController<int, Notification> pagingController =
      PagingController<int, Notification>(
    firstPageKey: 1,
  );
  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) async {
      await fetchNotifications(page: pageKey);
    });
    fetchNotifications();
    super.onInit();
  }

  @override
  void onReady() {
    notificationRepository.updateUnseenNotification();
    super.onReady();
  }

  Future<void> onRefresh() async {
    await fetchNotifications();
  }

  Future<void> refreshUnseenCount() async {
    await homeController.getUnseenNotificationCount();
  }

  Future<void> fetchNotifications({int page = 1}) async {
    try {
      if (page == 1) {
        pagingController.itemList?.clear();
        isLoading.value = true;
      }
      Paging<Notification> paging =
          await notificationRepository.getNotifications(page);
      final posts = paging.data;
      if (paging.hasMore) {
        pagingController.appendPage(
          posts,
          paging.pageNumber! + 1,
        );
      } else {
        pagingController.appendLastPage(posts);
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      if (page == 1) {
        isLoading.value = false;
      }
    }
  }

  Future<void> updateNotification(int id) async {
    try {
      final isSuccess = await notificationRepository.updateNotification(id);
      if (isSuccess) {
        final updatedList = pagingController.itemList?.map((noti) {
          if (noti.id == id) {
            noti.isSeen = true;
          }
          return noti;
        }).toList();

        pagingController.itemList = updatedList;
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> onClick(int id) async {
    final notification =
        pagingController.itemList?.firstWhere((element) => element.id == id);
    if (notification != null) {
      await onNavigate(notification.linkTo);
      await updateNotification(id);
    }
  }

  Future<void> onNavigate(LinkToModel? linkTo) async {
    if (linkTo != null) {
      if (Get.currentRoute != Routes.navBar) {
        Get.toNamed(Routes.navBar);
      }
      if (linkTo.type == LinkToType.friend) {
        navBottomController.onChangeToFriend();
        if (linkTo.friendNotiType == FriendNotiType.requested) {
          await friendController.onViewInFriendRequests();
        } else {
          await friendController.onViewInFriend();
        }
      } else if (linkTo.type == LinkToType.comment) {
        navBottomController.onChangeToHome();
        if (linkTo.postId != null) {
          homeController.onNavigateToHomeWithPostId(linkTo.postId);
          if (linkTo.postId != null) {
            Get.toNamed(Routes.comments, arguments: {
              Strings.postId: linkTo.postId,
            });
          }
        }
      } else if (linkTo.type == LinkToType.deletion) {
        DeletedPost deletedPost = DeletedPost(
            caption: linkTo.postCaption,
            createdAt: linkTo.postCreatedAt,
            likeCount: linkTo.likePostCount,
            cmtCount: linkTo.likeCommentCount,
            id: linkTo.postId,
            image: linkTo.postUrl);
        Get.toNamed(Routes.deletedPost, arguments: {
          Strings.deletedPost: deletedPost,
        });
      }
    }
  }
}
