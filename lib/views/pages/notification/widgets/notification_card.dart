import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/app/utils/date_utils.dart' as date;
import 'package:pic_share/data/models/notification/notification.dart' as model;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class NotificationItemCard extends StatelessWidget {
  NotificationItemCard(
      {super.key, required this.notification, required this.onMarkAsRead});
  model.Notification notification;
  final Function(int)? onMarkAsRead;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        padding: const EdgeInsets.all(5),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        decoration: BoxDecoration(
          color: notification.isSeen
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
              child: notification.sender?.urlAvatar != null
                  ? ImageCacheHelper.avatarImage(
                      url: notification.sender!.urlAvatar!,
                      height: MediaQuery.of(context).size.width * 0.12,
                      width: MediaQuery.of(context).size.width * 0.12)
                  : CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.06,
                      backgroundImage:
                          const AssetImage(AppImage.userEmptyAvatar),
                    ),
            ),
            Flexible(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.clip,
                    style: AppTextStyles.commonTextStyle()
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    notification.content ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.clip,
                    style: AppTextStyles.smallTextStyle().copyWith(),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              notification.createdAt != null
                  ? date.DateUtils.formatDateTimeToDateString(
                      notification.createdAt!)
                  : "",
              style: AppTextStyles.smallTextStyle(),
            ),
            IconButton(
              onPressed: () async {
                await showActionSheet(
                    context, onMarkAsRead, notification.id ?? 0);
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ));
  }
}

Future<void> showActionSheet(
    BuildContext context, Function(int)? onMarkAsRead, int id) async {
  final t = AppLocalizations.of(context)!;
  showModalBottomSheet(
    context: context,
    builder: (ctx) => IntrinsicHeight(
      child: Container(
        height: 120,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 187, 196, 201),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Divider(
              height: 1,
              color: Colors.blueGrey,
            ),
            InkWell(
              onTap: () async {
                if (onMarkAsRead != null) {
                  onMarkAsRead(id);
                }
                Get.back();
              },
              child: Center(
                child: Text(t.markAsRead),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.blueGrey,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Center(
                child: Text(
                  t.cancel,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
