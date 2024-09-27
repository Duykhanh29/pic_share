import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/enums/friend_noti_type.dart';
import 'package:pic_share/data/enums/link_to_type.dart';
import 'package:pic_share/data/models/notification/link_to_model.dart';
import 'package:pic_share/data/models/notification/notification.dart';
import 'package:pic_share/data/models/paging.dart';
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
      await fetchPosts(page: pageKey);
    });
    fetchPosts();
    super.onInit();
  }

  Future<void> fetchPosts({int page = 1}) async {
    try {
      if (page == 1) {
        isLoading.value = true;
      }
      Paging<Notification> paging =
          await notificationRepository.getNotifications(page);
      final posts = paging.data;
      if (paging.hasMore) {
        pagingController.appendPage(
          posts.reversed.toList(),
          paging.pageNumber! + 1,
        );
      } else {
        pagingController.appendLastPage(posts.reversed.toList());
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
      final isSucess = await notificationRepository.updateNotification(id);
      if (isSucess) {
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
          await friendController.onViewInFriendReuquests();
        } else {
          await friendController.onViewInFriend();
        }
      } else {
        navBottomController.onChangeToHome();
        if (linkTo.postId != null) {
          homeController.onNavigateToHomeWithPostId(linkTo.postId);
          if (linkTo.postId != null) {
            Get.toNamed(Routes.comments, arguments: {
              Strings.postId: linkTo.postId,
            });
          }
        }
      }
    }
  }
}
