import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/bottom_sheet_helper.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/app/utils/date_utils.dart' as helper;
import 'package:pic_share/data/models/post/post_data.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/home/home_controller.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/views/pages/home/widgets/action_sheet_widget.dart';
import 'package:pic_share/views/pages/home/widgets/report_action_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SinglePostContainer extends GetView<HomeController> {
  const SinglePostContainer({
    super.key,
    required this.postData,
    required this.isMe,
  });
  final PostData postData;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTopInfo(context, t),
            Stack(
              alignment: Alignment.center,
              children: [
                ImageCacheHelper.showImage(
                    url: postData.post.urlImage ??
                        "https://picsum.photos/seed/picsum/200/300",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.55),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildActionsWidget(),
                ),
                _buildCaption(),
              ],
            ),
            postData.post.userViews != null &&
                    postData.post.userViews!.isNotEmpty
                ? _buildUsersView(context, postData.post.userViews!)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopInfo(BuildContext context, AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              controller.onUserClick(postData.post.user);
            },
            child: postData.post.user?.urlAvatar != null
                ? ImageCacheHelper.avatarImage(
                    url: postData.post.user!.urlAvatar!)
                : const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(
                      AppImage.userEmptyAvatar,
                    ),
                  ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              controller.onUserClick(postData.post.user);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 223, 219, 219),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  isMe ? t.you : postData.post.user?.name ?? "",
                  style: AppTextStyles.headingTextStyle(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.25),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 223, 219, 219),
                borderRadius: BorderRadius.circular(5)),
            alignment: Alignment.center,
            child: Text(
              postData.post.createdAt != null
                  ? helper.DateUtils.formatDateTimeToString(
                      postData.post.createdAt!)
                  : "",
              maxLines: 3,
              textAlign: TextAlign.center,
              style: AppTextStyles.smallTextStyle(),
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () async {
                await showActionSheet(context, postData.post.userID ?? 0);
              },
              padding: const EdgeInsets.symmetric(horizontal: 2),
              icon: const Icon(Icons.more_vert_outlined))
        ],
      ),
    );
  }

  Widget _buildCaption() {
    return postData.post.caption != null
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
                  postData.post.caption ?? "",
                  style: AppTextStyles.headingLightTextStyle(),
                )),
              ),
            ),
          )
        : const Positioned(
            bottom: 20,
            child: SizedBox.shrink(),
          );
  }

  Widget _buildActionsWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildButton(
              postData.isLike ? Icons.favorite : Icons.favorite_outline,
              () async {
            if (postData.isLike) {
              await controller.dislikePost(
                  id: postData.post.id ?? 0, userId: postData.post.userID ?? 0);
            } else {
              await controller.addLike(postData.post.id ?? 0);
            }
          }, iconColor: Colors.red.withOpacity(0.9)),
          Text(
            postData.post.likeCount.toString(),
            style: AppTextStyles.commonTextStyle(),
          ),
          const SizedBox(
            height: 8,
          ),
          _buildButton(Icons.comment, () {
            Get.toNamed(Routes.comments, arguments: {
              Strings.postId: postData.post.id,
            });
          }),
          Text(
            postData.post.cmtCount.toString(),
            style: AppTextStyles.commonTextStyle(),
          ),
          const SizedBox(
            height: 8,
          ),
          isMe
              ? const SizedBox.shrink()
              : _buildButton(Icons.email, () async {
                  await controller.sendMessage(postData.post.id ?? 0);
                }),
          if (postData.post.latitude != null &&
              postData.post.longitude != null) ...[
            const SizedBox(
              height: 16,
            ),
            _buildButton(Icons.location_on, () {
              controller.onNavToLocationView(postData.post.id);
            }),
          ]
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, Function() onTap, {Color? iconColor}) {
    return GestureDetector(
      onTap: () async {
        await onTap.call();
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
          icon,
          size: 25,
          color: iconColor ?? Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }

  Widget _buildUsersView(BuildContext context, List<UserSummaryModel> users) {
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

  Future<void> showActionSheet(BuildContext context, int postOwnerID) async {
    return Get.bottomSheet(
      Obx(
        () => ActionSheetWidget(
          isPostOwner: controller.currentUser?.id == postOwnerID,
          onDeletePost: () async {
            await controller.deletePost(postData.post.id ?? 0);
          },
          onDownloadImage: () async {
            await controller
                .onDownloadImageToGallery(postData.post.urlImage ?? "");
          },
          onOpenReportSheetAction: () async {
            controller.onOpenReportSHeet();
            await showReportActionSheet(context, postData.post.id ?? 0);
          },
        ),
      ),
      useRootNavigator: true,
    );
  }

  Future<void> showReportActionSheet(BuildContext context, int postId) async {
    return Get.bottomSheet(
      ReportActionWidget(
          onReportPost: () async {
            await controller.reportPost(
                postId, controller.reasonController.text);
            Get.back();
          },
          reasonController: controller.reasonController),
      useRootNavigator: true,
    );
  }
}
