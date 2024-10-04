import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/data/models/conversation/conversation.dart';
import 'package:pic_share/data/models/conversation/message.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/chat/chat_controller.dart';
import 'package:pic_share/view_model/conversations/conversations_controller.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService extends GetxService {
  late PusherChannelsFlutter _pusher;

  AuthController authController;
  ConversationsController conversationsController;

  PusherService(
      {required this.authController, required this.conversationsController});
  RxList<Conversation> conversations = RxList<Conversation>([]);
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  RxList<int> subscribedRooms = RxList<int>([]);
  @override
  void onInit() async {
    ever(conversationsController.conversationData, (data) async {
      conversations.value = conversationsController.listConversation;
      await subscribeToRooms();
    });
    ever(authController.currentUser, (UserModel? user) async {
      if (user != null) {
        currentUser.value = user;
        await initPusher(currentUser.value?.id ?? 0, (p0) {});
      }
    });
    currentUser.value = authController.getCurrentUser;
    conversations.value = conversationsController.listConversation;
    await initPusher(currentUser.value?.id ?? 0, (event) async {
      await onEvent(event);
    });
    await subscribeToRooms();
    super.onInit();
  }

  String appID = "1853507";
  String apiKey = "168e2c4a9d8522f88031";
  String secret = "85b446bf332f96565c8c";
  String apiCluster = "ap1";

  Future<void> initPusher(int userId, Function(PusherEvent) onEvent) async {
    _pusher = PusherChannelsFlutter.getInstance();

    try {
      await _pusher.init(
        apiKey: apiKey,
        cluster: apiCluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
      );

      // Subscribe to user-specific channel
      await _pusher.subscribe(
        channelName: "chat.user.$userId",
      );
      debugPrint("Subscribed to user channel: chat.user.$userId");

      await _pusher.connect();
    } catch (e) {
      debugPrint("Error in initialization: $e");
    }
  }

  Future<void> subscribeToRooms() async {
    for (var conversation in conversations) {
      final roomId = conversation.id ?? 0;
      if (!subscribedRooms.contains(conversation.id)) {
        try {
          await _pusher.subscribe(
            channelName: "chat.room.$roomId",
          );
          subscribedRooms.add(roomId);
          debugPrint("Subscribed to room: chat.room.$roomId");
        } catch (e) {
          debugPrint("Error subscribing to room $roomId: $e");
        }
      }
    }
  }

  // Unsubscribe from rooms you no longer need to listen to
  Future<void> unsubscribeFromRoom(int roomId) async {
    if (subscribedRooms.contains(roomId)) {
      try {
        await _pusher.unsubscribe(channelName: "chat.room.$roomId");
        subscribedRooms.remove(roomId);
        debugPrint("Unsubscribed from room: chat.room.$roomId");
      } catch (e) {
        debugPrint("Error unsubscribing from room $roomId: $e");
      }
    }
  }

  Future<void> unsubscribeAllRooms() async {
    for (var conversation in conversations) {
      if (conversation.id != null) {
        await unsubscribeFromRoom(conversation.id!);
      }
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    debugPrint("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    debugPrint("onError: $message code: $code exception: $e");
  }

  Future<void> onEvent(PusherEvent event) async {
    debugPrint("onEvent: $event");
    debugPrint(event.eventName.toString());
    if (event.eventName.contains("conversation.created")) {
      onNewConversationEvent(event);
    } else if (event.eventName.contains("chat.message.sent")) {
      onChatEvent(event);
    } else {
      debugPrint("Aontoher event: $event");
    }
  }

  void onNewConversationEvent(PusherEvent event) {
    try {
      final data = event.data;
      final decodedData = jsonDecode(data);
      final Conversation conversation = Conversation.fromJson(decodedData);
      conversationsController.addNewConversation(conversation);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  void onChatEvent(PusherEvent event) {
    try {
      final data = event.data;
      final decodedData = jsonDecode(data);
      final conversationID = extractConversationId(event.channelName);
      if (conversationID == null) return;
      final Message message = Message.fromJson(decodedData);
      conversationsController.updateNewMsgOfConversation(
          conversationID, message);

      // current page is chat page
      if (Get.isRegistered<ChatController>()) {
        final chatController = Get.find<ChatController>();
        if (chatController.conversationId.value == conversationID) {
          chatController.listenNewMessage(message);
        }
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    debugPrint("onSubscriptionSucceeded: $channelName data: $data");
    final me = _pusher.getChannel(channelName)?.me;
    debugPrint("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    debugPrint("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    debugPrint("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    debugPrint("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    debugPrint("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    debugPrint(
        "onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  Future<void> onSend({channelName = "chat.room", roomId}) async {
    _pusher.trigger(PusherEvent(
        channelName: "$channelName.$roomId",
        eventName: r"App\Events\PushChatMessageEvent"));
  }

  int? extractConversationId(String eventName) {
    List<String> parts = eventName.split('.');
    if (parts.isNotEmpty) {
      return int.tryParse(parts.last);
    }
    return null;
  }
}
