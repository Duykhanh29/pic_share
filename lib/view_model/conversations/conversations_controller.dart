import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/enums/message_type.dart';
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
  RxBool isOpenChatPage = false.obs;
  RxBool isOpenChatFromSearch = false.obs;
  Rx<int> selectedConversationId = 0.obs;
  // getter
  UserModel? get currentUser => authController.getCurrentUser;

  late UserSummaryModel currentUserSummary;

  @override
  void onInit() async {
    setCurrentUserSummary();
    ever(authController.currentUser, (UserModel? user) async {
      if (user != null) {
        await fetchConversation();
        setCurrentUserSummary();
      } else {
        conversationData.value = ConversationData();
      }
    });
    await fetchConversation();
    super.onInit();
  }

  void setCurrentUserSummary() {
    currentUserSummary = UserSummaryModel(
      id: currentUser?.id ?? 0,
      name: currentUser?.name ?? "",
      urlAvatar: currentUser?.urlAvatar ?? "",
      userCode: currentUser?.userCode ?? "",
    );
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

  Future<void> refreshConversation() async {
    conversationData.value = ConversationData();
    await fetchConversation();
  }

  Future<void> onClickConversationItem(
      int conversationId, UserSummaryModel? user,
      {bool isTempChat = false}) async {
    await Get.toNamed(Routes.chat, arguments: {
      Strings.conversationId: conversationId,
      Strings.userSummary: user,
      Strings.isTempChat: isTempChat,
    });
    changeIsOpenChatPageToDefaul();
    changeIsOpenChatFromSearcgToDefaul(conversationId);
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
            if (val.unreadCount > 0) {
              val.unreadCount -= 1;
            }

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
    // if user create temp conversation, but they actually send msg, it will be replace last conversation
    if (isOpenChatFromSearch.value) {
      isOpenChatFromSearch.value = false;
      replaceLastConversation(conversation);
    } else {
      updatedConversations.insert(0, conversation);
      conversationData.value =
          conversationData.value.copyWith(conversations: updatedConversations);
    }
  }

  void updateNewMsgOfConversation(int conversationId, Message message) {
    final conversationIndex = conversationData.value.conversations
        .indexWhere((conversation) => conversation.id == conversationId);

    if (conversationIndex != -1) {
      var conversation =
          conversationData.value.conversations[conversationIndex];

      //Update lastMsg with new message value
      conversation = conversation.copyWith(
        lastMessage: message,
        unreadCount: message.sender?.id == currentUser?.id
            ? conversation.unreadCount
            : conversation.unreadCount + 1,
      );

      var updatedConversations =
          List<Conversation>.from(conversationData.value.conversations);

      // Move conversation to top
      updatedConversations.removeAt(conversationIndex);
      updatedConversations.insert(0, conversation);

      conversationData.value =
          conversationData.value.copyWith(conversations: updatedConversations);

      // open chat page if user click to send msg in post item
      if (isOpenChatPage.value) {
        onClickConversationItem(
          conversationId,
          currentUser?.id == conversation.currentUser?.id
              ? conversation.friend
              : conversation.currentUser,
        );
      }
    }
  }

  void changeIsOpenChatPageToDefaul() {
    if (isOpenChatPage.value) {
      isOpenChatPage.value = false;
    }
  }

  void changeIsOpenChatFromSearcgToDefaul(int conversationId) {
    if (isOpenChatFromSearch.value) {
      isOpenChatFromSearch.value = false;
      deleteConversation(conversationId);
    }
  }

  int? findConversationIdWithUser(int userId) {
    for (var conversation in conversationData.value.conversations) {
      if (conversation.friend?.id == userId ||
          conversation.currentUser?.id == userId) {
        return conversation.id;
      }
    }
    return null;
  }

  Conversation createNewConversation(UserSummaryModel? friend) {
    String now = DateTime.now().toIso8601String();
    Conversation conversation = Conversation(
      createdAt: now,
      updatedAt: now,
      currentUser: currentUserSummary,
      friend: friend,
      id: 0,
    );
    return conversation;
  }

  Future<void> onClickStartChat(
    UserSummaryModel user, {
    String? urlImage,
  }) async {
    if (user.id != null) {
      isOpenChatPage.value = true;
      await conversationRepository.sendMessage(
        text: "",
        userId: user.id!,
        messageType: MessageType.image,
        urlImage: urlImage,
      );
    }
  }

  void onOpenChatFromSearch(UserSummaryModel friend) {
    if (!isConversationExist(friend)) {
      Conversation conversation = createNewConversation(friend);
      addNewConversation(conversation);
      onClickConversationItem(
        conversation.id ?? 0,
        friend,
        isTempChat: true,
      );
      if (!isOpenChatFromSearch.value) {
        isOpenChatFromSearch.value = true;
      }
    } else {
      final conversationId = getConversationId(friend);
      if (conversationId != null) {
        onClickConversationItem(
          conversationId,
          friend,
        );
      }
    }
  }

  void deleteConversation(int conversationId) {
    conversationData.update((val) {
      if (val != null) {
        val.conversations.removeWhere((c) => c.id == conversationId);
      }
    });
  }

  void replaceLastConversation(Conversation newConversation) {
    var currentData = conversationData.value;

    if (currentData.conversations.isNotEmpty) {
      // Make a copy of the conversation list
      var updatedConversations =
          List<Conversation>.from(currentData.conversations);

      //Replace the last conversation with the new conversation
      updatedConversations[0] = newConversation;

      // Update the entire conversationData with the changed list
      conversationData.value =
          currentData.copyWith(conversations: updatedConversations);
    }
  }

  bool isConversationExist(UserSummaryModel user) {
    final result = conversationData.value.conversations.any((conversation) =>
        conversation.currentUser?.id == user.id ||
        conversation.friend?.id == user.id);
    return result;
  }

  int? getConversationId(UserSummaryModel user) {
    final conversation = conversationData.value.conversations.firstWhereOrNull(
      (conversation) =>
          conversation.currentUser?.id == user.id ||
          conversation.friend?.id == user.id,
    );

    return conversation?.id;
  }
}
