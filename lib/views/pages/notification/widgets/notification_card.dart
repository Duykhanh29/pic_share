import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/utils/date_utils.dart' as date;
import 'package:pic_share/data/models/notification/notification.dart' as model;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/widgets/avatar_widget.dart';

// ignore: must_be_immutable
class NotificationItemCard extends StatelessWidget {
  NotificationItemCard(
      {super.key,
      required this.notification,
      required this.onMarkAsRead,
      required this.onCLick});
  model.Notification notification;
  final Function(int)? onMarkAsRead;
  final Function(int)? onCLick;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthSize = size.width;
    final heightSize = size.height;
    final avatarSize = widthSize * 0.12;
    final dotSize = heightSize * 0.01;
    return GestureDetector(
      onTap: () {
        onCLick?.call(notification.id ?? 0);
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          padding: const EdgeInsets.all(5),
          constraints: BoxConstraints(
            minHeight: heightSize * 0.1,
          ),
          decoration: BoxDecoration(
            color: notification.isSeen
                ? AppColors.readColor
                : AppColors.unReadColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: AvatarWidget(
                  urlAvatar: notification.sender?.urlAvatar,
                  width: avatarSize,
                  height: avatarSize,
                  radius: avatarSize / 2,
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
              isReadPoint(notification.isRead, dotSize),
              SizedBox(
                width: widthSize * 0.005,
              ),
            ],
          )),
    );
  }

  Widget isReadPoint(bool isRead, double size) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isRead ? Colors.transparent : AppColors.selectedColor,
          shape: BoxShape.circle,
        ),
      );
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
