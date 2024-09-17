import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/services/local_storage_service.dart';

const channel = AndroidNotificationChannel(
    'high_importance_channel', 'Hign Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true);

class NotificationsService extends GetxService {
  final LocalStorageService localStorageService =
      Get.find<LocalStorageService>();
  // final GlobalKey<NavigatorState>? navigatorKey;

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
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) {
      debugPrint(response.payload.toString());
    });
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
    await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
        message.notification!.body, notificationDetails,
        payload: message.data['body']);
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
    FirebaseMessaging.instance.getInitialMessage().then((value) async {
      if (value?.notification != null) {
        debugPrint("Data received: ${value?.data}");
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint("Data received: ${message.data}");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _showLocalNotification(message);
      debugPrint("Data received: ${message.notification}");

      debugPrint("Data is: ${message.data}");
      debugPrint("category is ${message.category}");
      debugPrint("from is: ${message.from}");
      debugPrint("body is ${message.notification?.body}");
      debugPrint("titlte is: ${message.notification?.title}");
      debugPrint("sound is ${message..notification?.android?.sound}");
      debugPrint("messageType is ${message..messageType}");
      debugPrint("HEY MAN");
    });
    onTokenRefresh();
  }
}
