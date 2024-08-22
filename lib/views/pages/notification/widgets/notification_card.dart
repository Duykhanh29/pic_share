import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/app/utils/date_utils.dart' as date;

class NotificationItemCard extends StatelessWidget {
  const NotificationItemCard({super.key, required this.isSeen});
  final bool isSeen;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      decoration: BoxDecoration(
          color: isSeen ? Colors.white54 : Colors.blueAccent,
          borderRadius: BorderRadius.circular(10)),
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
        trailing: Row(
          children: [
            Text(
              date.DateUtils.customTime(
                DateTime.now().subtract(
                  const Duration(hours: 4),
                ),
              ),
              style: AppTextStyles.smallTextStyle(),
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
          ],
        ),
      ),
    );
  }
}
