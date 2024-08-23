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
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        padding: const EdgeInsets.all(5),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        decoration: BoxDecoration(
          color: isSeen
              ? const Color.fromARGB(137, 193, 193, 193)
              : Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: ImageCacheHelper.avatarImage(
                  url:
                      "https://img.freepik.com/premium-photo/portrait-smiling-ginger-womansitting-home-take-selfie-by-camera-happy-people-business-woman_129180-7341.jpg",
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15),
            ),
            Text(
              "Notification Title",
              maxLines: 3,
              overflow: TextOverflow.clip,
              style: AppTextStyles.headingTextStyle(),
            ),
            const Spacer(),
            Text(
              date.DateUtils.customTime(
                DateTime.now().subtract(
                  const Duration(hours: 2),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ));
  }
}
