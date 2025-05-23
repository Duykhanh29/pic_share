import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/custom_back_button.dart';
import 'package:pic_share/app/helper/divider_helper.dart';
import 'package:pic_share/data/models/user/user_friendship_model.dart';
import 'package:pic_share/view_model/search/search_controller.dart';
import 'package:pic_share/views/pages/search/widgets/user_search_result_widget.dart';
import 'package:pic_share/views/widgets/asset_image_widget.dart';
import 'package:pic_share/views/widgets/keyboard_dismiss.dart';
import 'package:pic_share/views/widgets/loading_widget.dart';

class SearchPage extends GetView<SearchUserController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return KeyboardDismiss(
      child: Scaffold(
        body: Obx(() => Stack(
              children: [
                CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    Obx(() => _buildSliverAppBar(t, context)),
                    Obx(
                      () => controller.isSearchWithCode.value
                          ? _buildCodeSearchResult(context)
                          : _buildNameSearchResult(context),
                    ),
                  ],
                ),
                if (controller.isLoading.value) const LoadingWidget(),
              ],
            )),
      ),
    );
  }

  Widget _buildSliverAppBar(AppLocalizations t, BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return SliverAppBar(
      // shape: const ContinuousRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(50),
      //   ),
      // ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25))),
      pinned: true,
      expandedHeight: isPortrait
          ? (controller.isSearchWithCode.value
              ? MediaQuery.of(Get.context!).size.height * 0.3
              : MediaQuery.of(Get.context!).size.height * 0.2)
          : (controller.isSearchWithCode.value
              ? MediaQuery.of(Get.context!).size.height * 0.48
              : MediaQuery.of(Get.context!).size.height * 0.38),
      backgroundColor: AppColors.secondaryColor,
      title: Text(
        controller.isSearchWithCode.value ? t.searchWithCode : t.search,
        style: AppTextStyles.appBarTexStyle(),
      ),
      centerTitle: true,
      leading: const CustomBackButton(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(
          isPortrait
              ? (controller.isSearchWithCode.value
                  ? MediaQuery.of(Get.context!).size.height * 0.18
                  : MediaQuery.of(Get.context!).size.height * 0.08)
              : (controller.isSearchWithCode.value
                  ? MediaQuery.of(Get.context!).size.height * 0.3
                  : MediaQuery.of(Get.context!).size.height * 0.2),
        ),
        child: controller.isSearchWithCode.value
            ? _buildCodeSearchField(t)
            : _buildSearchField(t),
      ),
    );
  }

  Widget _buildCodeSearchField(AppLocalizations t) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: controller.onSearchByCode,
                      controller: controller.codeController,
                      onChanged: controller.onChangeCode,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fillColor: AppColors.white,
                        filled: true,
                        hintText: t.userCode,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: controller.isReadyToSearchWithCode.value
                        ? () async {
                            await controller
                                .onSearchByCode(controller.codeController.text);
                          }
                        : null,
                    child: Text(
                      t.search,
                      style: AppTextStyles.commonTextStyle(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.done,
                    color: AppColors.secondaryBorder,
                    size: 14,
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                      child: Text(
                        t.userCodeDesc,
                        style: AppTextStyles.smallTextStyle()
                            .copyWith(fontSize: 12),
                        overflow: TextOverflow.visible,
                        maxLines: null,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(AppLocalizations t) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      padding: const EdgeInsets.all(10),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: controller.onSearchByName,
        controller: controller.nameController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
          fillColor: AppColors.white,
          filled: true,
          hintText: t.searchForFriends,
        ),
      ),
    );
  }

  Widget _buildCodeSearchResult(BuildContext context) {
    return Obx(
      () => SliverToBoxAdapter(
        child: !controller.isSearch.value || controller.isLoading.value
            ? Container()
            : controller.userSearchResult.value == null
                ? _buildNoFoundUser(context)
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 15),
                    child: UserSearchResultWidget(
                      userSummaryModel: controller.userSearchResult.value!,
                      onTap: controller.onItemCLick,
                      key: UniqueKey(),
                      onAcceptFriend: controller.onAcceptFriendRequest,
                      onChatTap: controller.onChatClick,
                      onRejectFriend: controller.onRejectFriendRequest,
                      onTapAddFriend: controller.onMakeFriendRequest,
                    ),
                  ),
      ),
    );
  }

  Widget _buildNameSearchResult(BuildContext context) {
    if (!controller.isSearch.value) {
      return SliverFillRemaining(child: Container());
    }
    if (controller.listSearchUser.isEmpty && !controller.isLoading.value) {
      return SliverFillRemaining(child: _buildNoFoundUser(context));
    }
    // if (controller.isLoading.value) {
    //   return const SliverFillRemaining(
    //     child: Center(
    //       child: SizedBox(
    //         height: 50,
    //         width: 50,
    //         child: CircularProgressIndicator(),
    //       ),
    //     ),
    //   );
    // }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      sliver: Obx(
        () => SliverList.separated(
          itemBuilder: (context, index) {
            UserFriendShipModel user = controller.listSearchUser[index];
            return UserSearchResultWidget(
              userSummaryModel: user,
              onTap: controller.onItemCLick,
              key: UniqueKey(),
              onAcceptFriend: controller.onAcceptFriendRequest,
              onChatTap: controller.onChatClick,
              onRejectFriend: controller.onRejectFriendRequest,
              onTapAddFriend: controller.onMakeFriendRequest,
            );
          },
          separatorBuilder: (context, index) => DividerHelper.sizedBoxDivider(),
          itemCount: controller.listSearchUser.length,
        ),
      ),
    );
  }

  Widget _buildNoFoundUser(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size.height;
    return SizedBox(
      height: size * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AssetImageWidget(asset: AppImage.notFound),
          SizedBox(
            height: size * 0.04,
          ),
          Text(
            t.noUserFound,
            style: AppTextStyles.commonTextStyle().copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
