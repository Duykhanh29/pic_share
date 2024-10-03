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
    } else {}
  }
  UserSummaryModel? user;
  Rx<int> conversationId = 0.obs;

  late TextEditingController messageTextController;
  RxBool isLoading = false.obs;

  RxList<Message> messages = <Message>[].obs;

  // getter
  UserModel? get currentUser => authController.getCurrentUser;

  @override
  void onInit() async {
    messageTextController = TextEditingController();
    await fetchMessages();
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
      messages.value =
          await conversationRepository.getMessages(conversationId.value);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage({
    MessageType messageType = MessageType.text,
    required String text,
    required int userId,
    String? urlImage,
  }) async {
    isLoading.value = true;
    try {
      await conversationRepository.sendMessage(
          messageType: messageType,
          text: text,
          userId: userId,
          urlImage: urlImage);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void listenNewMessage(Message message) {
    messages.insert(0, message);
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
