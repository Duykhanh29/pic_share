import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/data/enums/message_type.dart';
import 'package:pic_share/data/models/conversation/message.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({super.key, required this.isMe, required this.message});
  final bool isMe;
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          message.messageType == MessageType.image
              ? ImageCacheHelper.showImage(
                  url: message.urlImage ?? "",
                  height: message.height ??
                      MediaQuery.of(context).size.height * 0.2,
                  width:
                      message.width ?? MediaQuery.of(context).size.height * 0.2)
              : ClipRRect(
                  borderRadius: isMe
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))
                      : const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? const Color.fromARGB(255, 176, 194, 243)
                          : const Color.fromARGB(255, 222, 222, 226),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: SelectableText(
                      message.text ?? "",
                      style: AppTextStyles.commonTextStyle(),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
