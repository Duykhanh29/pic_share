import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';

class NotificationItemCard extends StatelessWidget {
  const NotificationItemCard({super.key, required this.isSeen});
  final bool isSeen;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      decoration: BoxDecoration(
        color: isSeen ? Colors.white54 : Colors.blueAccent,
      ),
      child: ListTile(
        leading: ImageCacheHelper.avatarImage(
            url:
                "https://img.freepik.com/premium-photo/portrait-smiling-ginger-womansitting-home-take-selfie-by-camera-happy-people-business-woman_129180-7341.jpg",
            height: MediaQuery.of(context).size.width * 0.2,
            width: MediaQuery.of(context).size.width * 0.2),
        title: Text(
          "Notification Title",
          maxLines: 3,
          overflow: TextOverflow.clip,
          style: AppTextStyles.headingTextStyle(),
        ),
        trailing: IconButton(
            onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined)),
      ),
    );
  }
}
