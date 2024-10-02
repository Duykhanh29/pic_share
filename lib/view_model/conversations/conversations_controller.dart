import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/models/conversation/conversation_data.dart';
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
}
