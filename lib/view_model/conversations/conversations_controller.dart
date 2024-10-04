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

  // getter
  UserModel? get currentUser => authController.getCurrentUser;
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

  Future<void> onClickConversationItem(
      int conversationId, UserSummaryModel? user) async {
    await Get.toNamed(Routes.chat, arguments: {
      Strings.conversationId: conversationId,
      Strings.userSummary: user,
    });
    updateUnreadStatus(conversationId);
  }

  void updateUnreadStatus(int conversationId) {
    final conversationIndex = conversationData.value.conversations.indexWhere(
      (c) => c.id == conversationId,
    );

    if (conversationIndex != -1) {
      var conversation =
          conversationData.value.conversations[conversationIndex];

      if (conversation.unreadCount > 0) {
        // Don't read the entire message yet
        conversationData.update((val) {
          if (val != null) {
            val.unreadCount -= 1;

            // Download update count to 0
            conversation = conversation.copyWith(unreadCount: 0);

            // Create a new book with a conversation
            var updatedConversations =
                List<Conversation>.from(val.conversations);
            updatedConversations[conversationIndex] = conversation;

            // Update conversationData with new list
            conversationData.value =
                val.copyWith(conversations: updatedConversations);
          }
        });
      }
    }
  }

  void addNewConversation(Conversation conversation) {
    var updatedConversations =
        List<Conversation>.from(conversationData.value.conversations);
    updatedConversations.insert(0, conversation);

    conversationData.value =
        conversationData.value.copyWith(conversations: updatedConversations);
  }

  void updateNewMsgOfConversation(int conversationId, Message message) {
    final conversationIndex = conversationData.value.conversations
        .indexWhere((conversation) => conversation.id == conversationId);

    if (conversationIndex != -1) {
      var conversation =
          conversationData.value.conversations[conversationIndex];

      //Update lastMsg with new message value
      conversation = conversation.copyWith(
          lastMessage: message, unreadCount: conversation.unreadCount + 1);

      var updatedConversations =
          List<Conversation>.from(conversationData.value.conversations);

      // Move conversation to top
      updatedConversations.removeAt(conversationIndex);
      updatedConversations.insert(0, conversation);

      conversationData.value =
          conversationData.value.copyWith(conversations: updatedConversations);
    }
  }
}
