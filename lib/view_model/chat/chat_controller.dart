import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/enums/message_type.dart';
import 'package:pic_share/data/models/conversation/message.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/repositories/conversations/conversation_repository.dart';
import 'package:pic_share/app/utils/date_utils.dart' as helper;
import 'package:pic_share/view_model/auth/auth_controller.dart';

class ChatController extends GetxController {
  ConversationRepository conversationRepository;
  AuthController authController;
  ChatController({
    required this.conversationRepository,
    required this.authController,
  }) {
    if (Get.arguments != null) {
      final arguments = Get.arguments as Map<String, dynamic>;
      conversationId.value = arguments[Strings.conversationId] as int;
      user = arguments[Strings.userSummary] as UserSummaryModel?;
      isTempChat.value = arguments[Strings.isTempChat] ?? false;
    } else {}
  }
  UserSummaryModel? user;
  Rx<int> conversationId = 0.obs;
  RxBool isTempChat = false.obs;

  late TextEditingController messageTextController;

  RxBool isLoading = false.obs;

  RxList<Message> messages = <Message>[].obs;

  // getter
  UserModel? get currentUser => authController.getCurrentUser;
  late UserSummaryModel userSummary;

  @override
  void onInit() async {
    messageTextController = TextEditingController();
    userSummary = UserSummaryModel(
      id: currentUser?.id ?? 0,
      name: currentUser?.name ?? "",
      urlAvatar: currentUser?.urlAvatar ?? "",
      userCode: currentUser?.userCode ?? "",
    );
    if (!isTempChat.value) {
      await fetchMessages();
    }
    super.onInit();
  }

  @override
  void onClose() {
    messageTextController.dispose();
    super.onClose();
  }

  void onSubmitted(String value) {
    debugPrint(messageTextController.text);
  }

  Future<void> fetchMessages() async {
    isLoading.value = true;
    try {
      final listMsg =
          await conversationRepository.getMessages(conversationId.value);
      messages.value = listMsg;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUnreadMsg() async {
    try {
      if (!isTempChat.value) {
        await conversationRepository.updateUnreadMsg(conversationId.value);
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> sendMessage({
    MessageType messageType = MessageType.text,
    String? text,
    int? userId,
    String? urlImage,
  }) async {
    isLoading.value = true;
    try {
      String msgText = messageTextController.text.trim().toString();
      messageTextController.clear();
      await conversationRepository.sendMessage(
        messageType: messageType,
        text: msgText,
        userId: userId ?? (user?.id ?? 0),
        urlImage: urlImage,
        conversationId: conversationId.value != 0 ? conversationId.value : null,
      );
      if (isTempChat.value) {
        String now = DateTime.now().toUtc().toIso8601String();
        Message message = Message(
          createdAt: now,
          updatedAt: now,
          messageType: messageType,
          text: msgText,
          urlImage: urlImage,
          sender: userSummary,
        );
        messages.add(message);
        isTempChat.value = false;
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void listenNewMessage(Message message) {
    messages.add(message);
  }

  DateTime getgroupByDateTime(String? createdAt) {
    DateTime dateTime = helper.DateUtils.convertStringToDateTime(createdAt);
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
    );
  }

  int getComparator(String? createdAt1, String? createdAt2) {
    DateTime dateTime1 = helper.DateUtils.convertStringToDateTime(createdAt1);
    DateTime dateTime2 = helper.DateUtils.convertStringToDateTime(createdAt2);
    return dateTime1.compareTo(dateTime2);
  }

  bool isMe(int id) => currentUser?.id == id;
}
