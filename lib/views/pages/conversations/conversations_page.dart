import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/view_model/conversations/conversations_controller.dart';
import 'package:pic_share/views/pages/conversations/widgets/conversation_item_card.dart';
import 'package:get/get.dart';
import 'package:pic_share/views/widgets/asset_image_widget.dart';

class ConversationPage extends GetView<ConversationsController> {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(title: t.messages, isLeadingShow: false).show(),
      body: RefreshIndicator(
        onRefresh: controller.refreshConversation,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => controller.conversationData.value.conversations.isEmpty
                ? Center(
                    child: SizedBox(
                      height: size * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AssetImageWidget(asset: AppImage.communication),
                          SizedBox(
                            height: size * 0.04,
                          ),
                          Text(
                            t.noConversation,
                            style: AppTextStyles.commonTextStyle()
                                .copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
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
