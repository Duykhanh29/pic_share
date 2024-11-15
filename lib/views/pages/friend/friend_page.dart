import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/custom/custom_back_button.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/views/pages/friend/widgets/friend_request_view.dart';
import 'package:pic_share/views/pages/friend/widgets/list_friend_view.dart';
import 'package:pic_share/views/widgets/loading_widget.dart';

class FriendPage extends GetView<FriendController> {
  const FriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: _buildAppBar(t),
            body: RefreshIndicator(
              onRefresh: controller.onRefresh,
              child: controller.isFriendShipView.value
                  ? const ListFriendView()
                  : const FriendRequestView(),
            ),
          ),
          if (controller.isActionLoading.value) const LoadingWidget(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(AppLocalizations t) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      leading: Obx(() =>
          controller.isViewInTabbar.value && controller.isFriendShipView.value
              ? const SizedBox.shrink()
              : controller.isFriendShipView.value
                  ? CustomBackButton(
                      onBack: controller.onResetViewInTabBar,
                    )
                  : SizedBox(
                      height: 45,
                      width: 45,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            controller.onChangeView();
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    )),
      title: Obx(
        () => Text(
          controller.isFriendShipView.value ? t.friends : t.friendRequests,
          style: AppTextStyles.appBarTexStyle(),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: IconButton(
            onPressed: controller.onNavToSearch,
            icon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
