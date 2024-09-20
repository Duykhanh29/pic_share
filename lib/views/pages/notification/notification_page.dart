import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/view_model/notifications/notification_controller.dart';
import 'package:pic_share/views/pages/notification/widgets/notification_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/data/models/notification/notification.dart' as model;

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: t.notification, isLeadingShow: false).show(),
      body: Obx(
        () => controller.isLoading.value
            ? ShimmerHelper().buildNotificationListViewShimmer()
            : PagedListView(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<model.Notification>(
                  itemBuilder: (context, notification, index) {
                    return NotificationItemCard(
                      notification: notification,
                      onMarkAsRead: controller.updateNotification,
                    );
                  },
                  firstPageProgressIndicatorBuilder: (context) =>
                      ShimmerHelper().buildNotificationListViewShimmer(),
                  noItemsFoundIndicatorBuilder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Text(
                        t.noNotifications,
                        style: AppTextStyles.commonTextStyle(),
                      ),
                    ),
                  ),
                ),
                shrinkWrap: true,
              ),
      ),
    );
  }
}
