import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/app/helper/bottom_sheet_helper.dart';
import 'package:pic_share/app/helper/dialog_helper.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/data/models/post/post_data.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/post_detail/post_detail_controller.dart';
import 'package:pic_share/app/utils/date_utils.dart' as helper;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        postData?.post.user?.urlAvatar != null
                            ? ImageCacheHelper.avatarImage(
                                url: postData!.post.user!.urlAvatar!)
                            : const CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                  AppImage.userEmptyAvatar,
                                ),
                              ),
                        const SizedBox(width: 20),
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
                        const SizedBox(width: 20),
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
                  ),
                  Stack(
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
                                    style:
                                        AppTextStyles.headingLightTextStyle(),
                                  )),
                                ),
                              ),
                            )
                          : const Positioned(
                              bottom: 20,
                              child: SizedBox.shrink(),
                            )
                    ],
                  ),
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

  Widget _buildActionsWidget(PostData postData) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              if (postData.isLike) {
                await controller.dislikePost(
                    id: postData.post.id ?? 0,
                    userId: postData.post.userID ?? 0);
              } else {
                await controller.addLike(postData.post.id ?? 0);
              }
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                postData.isLike ? Icons.favorite : Icons.favorite_outline,
                size: 25,
                color: Colors.red.withOpacity(0.9),
              ),
            ),
          ),
          Text(
            postData.post.likeCount.toString(),
            style: AppTextStyles.commonTextStyle(),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.comments, arguments: {
                Strings.postId: postData.post.id,
              });
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.comment,
                size: 25,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          Text(
            postData.post.cmtCount.toString(),
            style: AppTextStyles.commonTextStyle(),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.email,
                size: 25,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersView(
      BuildContext context, PostData postData, List<UserSummaryModel> users) {
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
                users[index].urlAvatar != null
                    ? ImageCacheHelper.avatarImage(url: users[index].urlAvatar!)
                    : const CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(AppImage.userEmptyAvatar),
                      ),
                const SizedBox(width: 10),
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
            ? ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final user = controller.listViews[index];
                  return ListTile(
                    onTap: () {},
                    leading: user.urlAvatar != null
                        ? ImageCacheHelper.avatarImage(url: user.urlAvatar!)
                        : const CircleAvatar(
                            radius: 15,
                            backgroundImage:
                                AssetImage(AppImage.userEmptyAvatar),
                          ),
                    title: Text(
                      user.name ?? "",
                      style: AppTextStyles.commonTextStyle(),
                    ),
                  );
                },
                itemCount: controller.listViews.length,
              )
            : ShimmerHelper().buildListViewShimmer(),
      ),
    );
  }

  Future<void> showActionSheet(BuildContext context, PostData? postData) async {
    final t = AppLocalizations.of(context)!;

    return Get.bottomSheet(
      Container(
        height: 200,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 187, 196, 201),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {},
              child: Center(
                child: Text(t.share),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.blueGrey,
            ),
            InkWell(
              onTap: () async {
                Get.back();
                await controller
                    .onDownloadImageToGallery(postData?.post.urlImage ?? "");
              },
              child: Center(
                child: Text(t.download),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.blueGrey,
            ),
            InkWell(
              onTap: () async {
                DialogHelper.showConfirmDialog(
                  title: t.warning,
                  message: t.areYouSureToDeleteThisPost,
                  onConfirm: () async {
                    await controller.deletePost(postData?.post.id ?? 0);
                    Get.back(result: true);
                  },
                  onCancel: () {
                    Get.back();
                  },
                  context: context,
                );
              },
              child: Center(
                child: Text(
                  t.delete,
                  style: const TextStyle(color: AppColors.warningColor),
                ),
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
      useRootNavigator: true,
    );
  }
}
