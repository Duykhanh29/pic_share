import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/app/helper/bottom_sheet_helper.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/data/models/post/post_data.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/view_model/post_detail/post_detail_controller.dart';
import 'package:pic_share/app/utils/date_utils.dart' as helper;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/pages/post_detail/widgets/action_column_widget.dart';
import 'package:pic_share/views/pages/post_detail/widgets/action_sheet_widget.dart';
import 'package:pic_share/views/pages/post_detail/widgets/user_views_sheet_widget.dart';
import 'package:pic_share/views/widgets/avatar_widget.dart';

class PostDetailPage extends GetView<PostDetailController> {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: CustomAppBar(title: t.postDetail).show(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return ShimmerHelper().buildBasicShimmer();
          } else {
            final postData = controller.postData.value;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTopPostDetail(context, postData),
                  _buildPostImageView(context, postData),
                  postData?.post.userViews != null &&
                          postData!.post.userViews!.isNotEmpty
                      ? _buildUsersView(
                          context, postData, postData.post.userViews!)
                      : const SizedBox.shrink(),
                ],
              ),
            );
          }
        }));
  }

  Widget _buildPostImageView(BuildContext context, PostData? postData) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ImageCacheHelper.showImage(
            url: postData?.post.urlImage ??
                "https://picsum.photos/seed/picsum/200/300",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55),
        Align(
          alignment: Alignment.centerRight,
          child: postData != null
              ? _buildActionsWidget(postData)
              : const SizedBox.shrink(),
        ),
        postData?.post.caption != null
            ? Positioned(
                bottom: 20,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(0.6)),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      postData?.post.caption ?? "",
                      style: AppTextStyles.headingLightTextStyle(),
                    )),
                  ),
                ),
              )
            : const Positioned(
                bottom: 20,
                child: SizedBox.shrink(),
              )
      ],
    );
  }

  Widget _buildTopPostDetail(BuildContext context, PostData? postData) {
    final size = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AvatarWidget(
            urlAvatar: postData?.post.user?.urlAvatar,
            width: size * 0.1,
            height: size * 0.1,
            radius: size * 0.05,
          ),
          SizedBox(width: size * 0.015),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 223, 219, 219),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                postData?.post.user?.name ?? "",
                style: AppTextStyles.headingTextStyle(),
              ),
            ),
          ),
          SizedBox(width: size * 0.015),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 223, 219, 219),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                postData?.post.createdAt != null
                    ? helper.DateUtils.formatDateTimeToString(
                        postData!.post.createdAt!)
                    : "",
                style: AppTextStyles.smallTextStyle(),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () async {
                await showActionSheet(context, postData);
              },
              padding: const EdgeInsets.symmetric(horizontal: 2),
              icon: const Icon(Icons.more_vert_outlined))
        ],
      ),
    );
  }

  Widget _buildActionsWidget(PostData postData) {
    return ActionColumnWidget(
      addLike: (id) async {
        await controller.addLike(id);
      },
      dislikePost: ({required int id, required int userId}) {
        controller.dislikePost(id: id, userId: userId);
      },
      postData: postData,
      onNavToLocationView: () {
        controller.onNavToLocationView();
      },
    );
  }

  Widget _buildUsersView(
      BuildContext context, PostData postData, List<UserSummaryModel> users) {
    final size = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: List.generate(users.length > 3 ? 4 : users.length, (index) {
          if (users.length > 3 && index == 3) {
            return GestureDetector(
              onTap: () async {
                await controller.fetchUserViews(postData.post.id ?? 0);
                if (!context.mounted) return;
                showUserViewSheet(context);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 218, 217, 217)),
                child: Center(
                  child: Text(
                    "${users.length - 3}",
                    style: AppTextStyles.smallLightTextStyle(),
                  ),
                ),
              ),
            );
          } else {
            return Column(
              children: [
                AvatarWidget(
                  urlAvatar: users[index].urlAvatar,
                  height: size * 0.05,
                  width: size * 0.05,
                  radius: size * 0.025,
                ),
                SizedBox(width: size * 0.01),
              ],
            );
          }
        }),
      ),
    );
  }

  void showUserViewSheet(BuildContext context) {
    return BottomSheetHelper.showBottomSheet(
      height: MediaQuery.of(context).size.height * 0.7,
      context: context,
      child: Obx(
        () => controller.listViews.isNotEmpty
            ? UserViewsSheetWidget(
                listViews: controller.listViews,
              )
            : ShimmerHelper().buildListViewShimmer(),
      ),
    );
  }

  Future<void> showActionSheet(BuildContext context, PostData? postData) async {
    return Get.bottomSheet(
      ActionSheetWidgetDetail(onDeletePost: () async {
        await controller.deletePost(postData?.post.id ?? 0);
      }, onDownloadImage: () async {
        await controller
            .onDownloadImageToGallery(postData?.post.urlImage ?? "");
      }),
      useRootNavigator: true,
    );
  }
}
