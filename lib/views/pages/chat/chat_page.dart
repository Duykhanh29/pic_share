import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/custom_back_button.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/data/models/conversation/message.dart';
import 'package:pic_share/view_model/chat/chat_controller.dart';
import 'package:pic_share/views/pages/chat/widgets/message_tile.dart';
import 'package:pic_share/views/widgets/keyboard_dismiss.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/utils/date_utils.dart' as helper;
import 'package:pic_share/views/widgets/loading_widget.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismiss(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Obx(
          () => Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    _buildListMsg(),
                    Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: _buildInputWidget(context)),
                  ],
                ),
              ),
              if (controller.isLoading.value) const LoadingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      elevation: 5,
      leading: CustomBackButton(
        onBack: () {
          controller.updateUnreadMsg();
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          controller.user?.urlAvatar != null
              ? ImageCacheHelper.avatarImage(url: controller.user!.urlAvatar!)
              : CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.02,
                  backgroundImage: const AssetImage(AppImage.userEmptyAvatar),
                ),
          const SizedBox(width: 10),
          Text(
            controller.user?.name ?? "",
            style: AppTextStyles.headingTextStyle(),
          )
        ],
      ),
    );
  }

  Widget _buildListMsg() {
    return Obx(
      () => Expanded(
        child: GroupedListView<Message, DateTime>(
          elements: controller.messages.toList(),
          groupBy: (msg) => controller.getgroupByDateTime(msg.createdAt),
          physics: const BouncingScrollPhysics(),
          // reverse: true,
          floatingHeader: true,
          shrinkWrap: true,
          useStickyGroupSeparators: true,
          itemComparator: (message1, message2) {
            return controller.getComparator(
                message1.createdAt, message2.createdAt);
          },
          groupHeaderBuilder: (message) {
            DateTime dateTime =
                helper.DateUtils.convertStringToDateTime(message.createdAt);
            return _buildGroupHeader(dateTime);
          },
          itemBuilder: (context, message) {
            bool isMe = controller.isMe(message.sender?.id ?? 0);
            return _buildMsgCard(message, isMe);
          },
        ),
      ),
    );
  }

  Widget _buildMsgCard(Message message, bool isMe) {
    return MessageTile(
      isMe: isMe,
      message: message,
      key: ValueKey(message.id),
    );
  }

  Widget _buildInputWidget(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return TextField(
      onSubmitted: controller.onSubmitted,
      controller: controller.messageTextController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: t.sendMessage,
        suffixIcon: GestureDetector(
          onTap: () async {
            if (controller.messageTextController.text.isNotEmpty) {
              await controller.sendMessage();
              controller.onSubmitted(controller.messageTextController.text);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 227, 232, 235)),
            child: Icon(
              Icons.send,
              color: AppColors.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupHeader(DateTime dateTime) {
    return SizedBox(
      height: 35,
      child: Center(
        child: Card(
          color: Colors.blueGrey,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              helper.DateUtils.customTime(dateTime),
              style: AppTextStyles.smallTextStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
