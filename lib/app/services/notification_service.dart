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
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/view_model/home/home_controller.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_controller.dart';

const channel = AndroidNotificationChannel(
    'high_importance_channel', 'Hign Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true);

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
      onDidReceiveBackgroundNotificationResponse: (details) {},
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
      'mychannelid',
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

  Future<void> requestPermission() async {
    final messaging = FirebaseMessaging.instance;

    NotificationSettings currentSettings =
        await messaging.getNotificationSettings();
    if (currentSettings.authorizationStatus == AuthorizationStatus.authorized) {
      return;
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
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
      localStorageService
          .setNotificationPermission(false); // temporary set false
    } else {
      debugPrint('User declined or has not accepted permission');
      localStorageService.setNotificationPermission(false);
    }
  }

  Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  Future<void> _setupFirebaseMessaging() async {
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
    final isRegisterd = Get.isRegistered<NavBottomController>();
    final localStorageService = Get.find<LocalStorageService>();
    final isLoggedin = !localStorageService.isUserNull.value;
    if (isRegisterd) {
      await onHandleNavWithDependencies(notificationData);
    } else {
      if (isLoggedin) {
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
  if (Get.currentRoute != Routes.navBar) {
    Get.toNamed(Routes.navBar);
  }
  if (notificationData.type == LinkToType.friend) {
    navBottomController.onChangeToFriend();
    if (notificationData.friendType == FriendNotiType.requested) {
      await friendController.onViewInFriendReuquests();
    } else {
      await friendController.onViewInFriend();
    }
  } else {
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
  }
}
