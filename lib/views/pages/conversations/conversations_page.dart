import 'package:flutter/material.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/view_model/conversations/conversations_controller.dart';
import 'package:pic_share/views/pages/conversations/widgets/conversation_item_card.dart';
import 'package:get/get.dart';

class ConversationPage extends GetView<ConversationsController> {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: t.messages, isLeadingShow: false).show(),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => controller.conversationData.value.conversations.isEmpty
                ? Center(
                    child: Text(t.noConversation),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      final conversation = controller
                          .conversationData.value.conversations[index];
                      return ConversationItemCard(
                        conversation: conversation,
                        onTap: controller.onClickConversationItem,
                        isMe: conversation.currentUser?.id ==
                            controller.currentUser?.id,
                        isLastChatByMyself:
                            conversation.lastMessage?.sender?.id ==
                                controller.currentUser?.id,
                      );
                    },
                    itemCount:
                        controller.conversationData.value.conversations.length,
                  ),
          ),
        ),
      ),
    );
  }
}
