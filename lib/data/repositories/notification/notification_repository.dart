import 'package:flutter/foundation.dart';
import 'package:pic_share/data/providers/network/apis/notifications/multiple_notification_api.dart';
import 'package:pic_share/data/providers/network/apis/notifications/notification_api.dart';

class NotificationRepository {
  Future<void> sendNotification(String token) async {
    try {
      debugPrint("Token is: $token");
      await NotificationAPI(token: token).request();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> sendNotiToMultipleDevice(List<String> tokens) async {
    try {
      await MultipleNotificationAPI(tokens: tokens).request();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }
}
