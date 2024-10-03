import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/models/conversation/conversation.dart';
import 'package:pic_share/data/models/conversation/conversation_data.dart';
import 'package:pic_share/data/models/conversation/message.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/repositories/conversations/conversation_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';

class ConversationsController extends GetxController {
  ConversationRepository conversationRepository;
  AuthController authController;
  ConversationsController(
      {required this.conversationRepository, required this.authController});

  List<Conversation> get listConversation =>
      conversationData.value.conversations;
  Rx<ConversationData> conversationData = ConversationData().obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    ever(authController.currentUser, (UserModel? user) async {
      if (user != null) {
        await fetchConversation();
      }
    });
    await fetchConversation();
    super.onInit();
  }

  Future<void> fetchConversation() async {
    isLoading.value = true;
    try {
      conversationData.value =
          await conversationRepository.getConversationData();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void onClickConversationItem(int conversationId, UserSummaryModel? user) {
    Get.toNamed(Routes.chat, arguments: {
      Strings.conversationId: conversationId,
      Strings.userSummary: user,
    });
  }

  void temporaryAddNewConversation() {
    var updatedConversations =
        List<Conversation>.from(conversationData.value.conversations);
    updatedConversations.add(Conversation(id: 100));

    conversationData.value =
        conversationData.value.copyWith(conversations: updatedConversations);
  }

  void addNewConversation(Conversation conversation) {
    var updatedConversations =
        List<Conversation>.from(conversationData.value.conversations);
    updatedConversations.insert(0, conversation);

    conversationData.value =
        conversationData.value.copyWith(conversations: updatedConversations);
  }

  void updateNewMsgOfConversation(int conversationId, Message message) {
    // Tìm cuộc trò chuyện theo ID
    final conversationIndex = conversationData.value.conversations
        .indexWhere((conversation) => conversation.id == conversationId);

    if (conversationIndex != -1) {
      // Nếu tìm thấy cuộc trò chuyện
      var conversation =
          conversationData.value.conversations[conversationIndex];

      // Cập nhật lastMsg với giá trị message mới
      conversation = conversation.copyWith(
          lastMessage: message); // Sử dụng copyWith để tạo ra một bản sao mới

      // Tạo danh sách mới và di chuyển cuộc trò chuyện lên đầu
      var updatedConversations =
          List<Conversation>.from(conversationData.value.conversations);

      // Di chuyển cuộc trò chuyện lên đầu
      updatedConversations.removeAt(conversationIndex);
      updatedConversations.insert(0, conversation);

      // Cập nhật dữ liệu cuộc trò chuyện
      conversationData.value =
          conversationData.value.copyWith(conversations: updatedConversations);
    }
  }
}
