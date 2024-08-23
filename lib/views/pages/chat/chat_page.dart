import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/app/custom/custom_back_button.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/app/utils/date_utils.dart' as date;
import 'package:pic_share/data/models/conversation/message.dart';
import 'package:pic_share/dump_data/dump_data.dart';
import 'package:pic_share/view_model/chat/chat_controller.dart';
import 'package:pic_share/views/pages/chat/widgets/message_tile.dart';
import 'package:pic_share/views/widgets/keyboard_dismiss.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return KeyboardDismiss(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
          elevation: 5,
          leading: const CustomBackButton(onBack: null),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageCacheHelper.avatarImage(
                  url:
                      "https://img.beautiful-people-feels.com/bp/images/img_bloc/bloc85/08100438_66b670257652e.jpg?v=20240810043910"),
              const SizedBox(width: 10),
              Text(
                "Username",
                style: AppTextStyles.headingTextStyle(),
              )
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Expanded(
                child: GroupedListView<Message, DateTime>(
                  elements: messages,
                  groupBy: (message) {
                    DateTime dateTime =
                        date.DateUtils.intToDateTime(message.time!);
                    return DateTime(
                      dateTime.year,
                      dateTime.month,
                      dateTime.day,
                      dateTime.hour,
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  floatingHeader: true,
                  shrinkWrap: true,
                  useStickyGroupSeparators: true,
                  itemComparator: (message1, message2) {
                    DateTime dateTime1 =
                        date.DateUtils.intToDateTime(message1.time!);
                    DateTime dateTime2 =
                        date.DateUtils.intToDateTime(message2.time!);
                    return dateTime1.compareTo(dateTime2);
                  },
                  groupHeaderBuilder: (message) {
                    DateTime dateTime =
                        date.DateUtils.intToDateTime(message.time!);
                    return SizedBox(
                      height: 35,
                      child: Center(
                        child: Card(
                          color: Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              date.DateUtils.customTime(dateTime),
                              style: AppTextStyles.smallTextStyle(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemBuilder: (context, message) {
                    int ranInt = Random().nextInt(2);
                    return MessageTile(
                      isMe: ranInt % 2 == 0,
                      message: message,
                      key: ValueKey(message.id),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                child: TextField(
                  onSubmitted: controller.onSubmitted,
                  controller: controller.messageController,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: t.sendMessage,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        if (controller.messageController.text.isNotEmpty) {
                          controller
                              .onSubmitted(controller.messageController.text);
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
