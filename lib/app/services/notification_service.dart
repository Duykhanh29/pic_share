import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/data/enums/friend_noti_type.dart';
import 'package:pic_share/data/enums/link_to_type.dart';
import 'package:pic_share/data/models/notification/notification_data.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/friend/friend_repository.dart';
import 'package:pic_share/data/repositories/notification/notification_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/view_model/home/home_controller.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_controller.dart';
import 'package:pic_share/view_model/notifications/notification_controller.dart';

const channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true);
Future<void> _backgroundMessageHandler(RemoteMessage message) async {}

class NotificationsService extends GetxService {
  final LocalStorageService localStorageService =
      Get.find<LocalStorageService>();

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void Function(String)?
      onTokenRefreshCallback; // callback for onTokenRefresh to update fcm token in db

  Future<NotificationsService> init() async {
    await requestPermission();
    _initLocalNotification();
    _setupFirebaseMessaging();
    return this;
  }

  static Future<void> backgroundNotificationHandler(
      NotificationResponse details) async {}

  @pragma('vm:entry-point')
  onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) {
    // some code
  }

  void _initLocalNotification() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) async {
        debugPrint("Payload ${response.payload.toString()}");
        await handleNotificationClick(response.payload.toString());
      },
      onDidReceiveBackgroundNotificationResponse: backgroundNotificationHandler,
    );
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final styleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatTitle: true,
    );
    final androidDetails = AndroidNotificationDetails(
      'com.example.pic_share',
      'myChannelId',
      importance: Importance.max,
      styleInformation: styleInformation,
      priority: Priority.max,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      message.notification?.hashCode ?? 0,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  void onTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      if (localStorageService.notificationPermission) {
        if (onTokenRefreshCallback != null) {
          onTokenRefreshCallback!(newToken);
        }
      }
    });
  }

  Future<bool> requestPermission() async {
    final messaging = FirebaseMessaging.instance;

    NotificationSettings currentSettings =
        await messaging.getNotificationSettings();
    if (currentSettings.authorizationStatus == AuthorizationStatus.authorized) {
      return true;
    }
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
      localStorageService.setNotificationPermission(true);
      return true;
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
      localStorageService
          .setNotificationPermission(false); // temporary set false
    } else {
      debugPrint('User declined or has not accepted permission');
      localStorageService.setNotificationPermission(false);
    }
    return false;
  }

  Future<bool> getNotificationSettings() async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  Future<void> deleteCurrentToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  Future<void> _setupFirebaseMessaging() async {
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    _initLocalNotification();

    // it not work as expected
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message?.notification != null) {
        debugPrint("Data received: ${message?.data}");
      }
      if (message != null) {
        await handleClick(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint("Data received: ${message.data}");
      await handleClick(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _showLocalNotification(message);
      // handleClick(message);
    });
    onTokenRefresh();
  }

  Future<void> handleClick(RemoteMessage message) async {
    final notificationData = NotificationData.fromJson(message.data);
    await handleNavigation(notificationData);
  }

  Future<void> handleNotificationClick(String payload) async {
    final Map<String, dynamic> jsonData = jsonDecode(payload); // error

    final notificationData = NotificationData.fromJson(jsonData);

    await handleNavigation(notificationData);
  }

  Future<void> handleNavigation(NotificationData notificationData) async {
    final isRegistered = Get.isRegistered<NavBottomController>();
    final localStorageService = Get.find<LocalStorageService>();
    final isLoggedIn = !localStorageService.isUserNull.value;
    if (isRegistered) {
      await onHandleNavWithDependencies(notificationData);
    } else {
      if (isLoggedIn) {
        Get.put<AuthController>(
          AuthController(
            localStorageService: Get.find<LocalStorageService>(),
            authRepository: Get.find<AuthRepository>(),
            userRepository: Get.find<UserRepository>(),
            notificationsService: Get.find<NotificationsService>(),
          ),
        );
        Get.put(
            FriendController(
                friendRepository: Get.find<FriendRepository>(),
                authController: Get.find<AuthController>()),
            permanent: true);
        Get.put<NavBottomController>(
          NavBottomController(),
          permanent: true,
        );
        await onHandleNavWithDependencies(notificationData);
      }
    }
  }
}

Future<void> onHandleNavWithDependencies(
    NotificationData notificationData) async {
  final navBottomController = Get.find<NavBottomController>();
  final homeController = Get.find<HomeController>();
  final friendController = Get.find<FriendController>();
  final notificationController = Get.put(NotificationController(
      notificationRepository: Get.find<NotificationRepository>(),
      friendController: friendController,
      navBottomController: navBottomController,
      homeController: homeController));
  if (notificationData.notificationId != null) {
    final notificationId = int.tryParse(notificationData.notificationId!);
    if (notificationId != null) {
      notificationController.updateNotification(notificationId);
    }
  }
  if (Get.currentRoute != Routes.navBar) {
    Get.toNamed(Routes.navBar);
  }
  if (notificationData.type == LinkToType.friend) {
    navBottomController.onChangeToFriend();
    if (notificationData.friendType == FriendNotiType.requested) {
      await friendController.onViewInFriendRequests();
    } else {
      await friendController.onViewInFriend();
    }
  } else if (notificationData.type == LinkToType.comment) {
    navBottomController.onChangeToHome();
    if (notificationData.postId != null) {
      final postId = int.tryParse(notificationData.postId!);
      homeController.onNavigateToHomeWithPostId(postId);
      if (postId != null) {
        Get.toNamed(Routes.comments, arguments: {
          Strings.postId: postId,
        });
      }
    }
  } else if (notificationData.type == LinkToType.chat) {
    final conversationStringId = notificationData.conversationId;
    final conversationId = int.tryParse(notificationData.conversationId ?? '');
    final sender = notificationData.sender;
    if (conversationStringId == null ||
        conversationId == null ||
        sender == null) {
      navBottomController.onChangeToChat();
    } else {
      Get.toNamed(Routes.chat, arguments: {
        Strings.conversationId: conversationId,
        Strings.userSummary: sender,
      });
    }
  } else if (notificationData.type == LinkToType.deletion) {}
}
