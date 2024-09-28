import 'package:flutter/foundation.dart';
import 'package:pic_share/data/providers/network/apis/notifications/get_notification_api.dart';
import 'package:pic_share/data/providers/network/apis/notifications/multiple_notification_api.dart';
import 'package:pic_share/data/providers/network/apis/notifications/notification_api.dart';
import 'package:pic_share/data/models/paging.dart';
import 'package:pic_share/data/models/notification/notification.dart';

abstract class NotificationRepository {
  Future<void> sendNotification(String token);
  Future<void> sendNotiToMultipleDevice(List<String> tokens);

  Future<Paging<Notification>> getNotifications(int? page);

  Future<bool> updateNotification(int id);
  Future<void> updateUnseenNotification();
  Future<int> getUnseenNotificationCount();
}

class NotificationRepositoryImpl extends NotificationRepository {
  @override
  Future<void> sendNotiToMultipleDevice(List<String> tokens) async {
    try {
      await MultipleNotificationAPI(tokens: tokens).request();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  @override
  Future<void> sendNotification(String token) async {
    try {
      debugPrint("Token is: $token");
      await NotificationAPI(token: token).request();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  @override
  Future<Paging<Notification>> getNotifications(int? page) async {
    try {
      final response = await GetNotificationAPI(page: page).request();
      final data = response['data'] as Map<String, dynamic>;
      int totalItems = data['totalItems'] as int;
      final notificationData = data['notifications'] as List<dynamic>;
      final posts =
          notificationData.map((e) => Notification.fromJson(e)).toList();
      final currentPage = (data['currentPage'] as num).toInt();
      final rowsPerPage = (data['perPage'] as num).toInt();
      final lastPage = (data['lastPage'] as num).toInt();
      Paging<Notification> paging = Paging(
        totalResults: totalItems,
        data: posts,
        pageNumber: currentPage,
        rowsPerPage: rowsPerPage,
        lastPage: lastPage,
      );
      return paging;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return Paging(
      totalResults: 0,
      data: [],
      pageNumber: 0,
      rowsPerPage: 0,
      lastPage: 0,
    );
  }

  @override
  Future<bool> updateNotification(int id) async {
    try {
      final response = await UpdateUnreadNotificationAPI(id: id).request();
      debugPrint("Message: ${response['message']}");
      return true;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return false;
  }

  @override
  Future<void> updateUnseenNotification() async {
    try {
      final response = await UpdateUnseenNotificationAPI().request();
      debugPrint("Message: ${response['message']}");
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  @override
  Future<int> getUnseenNotificationCount() async {
    try {
      final response = await GetUnseenNotificationAPI().request();
      final data = response['data'] as Map<String, dynamic>;
      final total = data['unseen_count'] as int;
      return total;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return 0;
  }
}
