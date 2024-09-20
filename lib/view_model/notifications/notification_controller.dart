import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pic_share/data/models/notification/notification.dart';
import 'package:pic_share/data/models/paging.dart';
import 'package:pic_share/data/repositories/notification/notification_repository.dart';

class NotificationController extends GetxController {
  NotificationRepository notificationRepository;

  NotificationController({required this.notificationRepository});

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
}
