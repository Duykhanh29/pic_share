import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/constants/global_data.dart';
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
import 'package:pic_share/views/widgets/avatar_widget.dart';

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
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    final size = isPortrait ? widthSize : heightSize;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size * 0.01),
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
                  height:
                      (isPortrait ? heightSize : heightSize * singlePostSize) *
                          singlePostSize),
              Align(
                alignment: Alignment.centerRight,
                child: _buildActionsWidget(context),
              ),
              _buildCaption(context),
            ],
          ),
          postData.post.userViews != null && postData.post.userViews!.isNotEmpty
              ? _buildUsersView(context, postData.post.userViews!)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildTopInfo(BuildContext context, AppLocalizations t) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    final size = isPortrait ? widthSize : heightSize;
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                controller.onUserClick(postData.post.user);
              },
              child: AvatarWidget(
                urlAvatar: postData.post.user?.urlAvatar,
                width: size * 0.1,
                height: size * 0.1,
                radius: size * 0.05,
              )),
          SizedBox(width: size * 0.02),
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
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          SizedBox(width: size * 0.02),
          Container(
            constraints: BoxConstraints(maxWidth: size * 0.26),
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
              overflow: TextOverflow.ellipsis,
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

  Widget _buildCaption(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    return postData.post.caption != null
        ? Positioned(
            bottom: heightSize * 0.01,
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
        : Positioned(
            bottom: heightSize * 0.01,
            child: const SizedBox.shrink(),
          );
  }

  Widget _buildActionsWidget(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final widthSize = MediaQuery.of(context).size.width;
    return Container(
      margin: isPortrait ? null : EdgeInsets.only(right: widthSize * 0.03),
      padding: EdgeInsets.all(heightSize * 0.01),
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
          SizedBox(
            height: heightSize * 0.01,
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
          SizedBox(
            height: heightSize * 0.01,
          ),
          isMe
              ? const SizedBox.shrink()
              : _buildButton(Icons.email, () async {
                  await controller.sendMessage(postData.post.id ?? 0);
                }),
          if (postData.post.latitude != null &&
              postData.post.longitude != null) ...[
            SizedBox(
              height: heightSize * 0.02,
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
                SizedBox(width: size * 0.02),
              ],
            );
          }
        }),
      ),
    );
  }

  void showUserViewSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthSize = size.width;
    final heightSize = size.height;
    return BottomSheetHelper.showBottomSheet(
      height: heightSize * 0.7,
      context: context,
      child: Obx(
        () => controller.listViews.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final user = controller.listViews[index];
                  return ListTile(
                    onTap: () {},
                    leading: AvatarWidget(
                      urlAvatar: user.urlAvatar,
                      height: widthSize * 0.05,
                      width: widthSize * 0.05,
                      radius: widthSize * 0.025,
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
    final t = AppLocalizations.of(context)!;
    return Get.bottomSheet(
      Obx(
        () => ActionSheetWidget(
          isPostOwner: controller.currentUser?.id == postOwnerID,
          onDeletePost: () async {
            Get.back();
            await controller.deletePost(postData.post.id ?? 0);
          },
          onDownloadImage: () async {
            await controller.onDownloadImageToGallery(
              postData.post.urlImage ?? "",
              t.downloadSuccessfully,
              t.downloadFailed,
            );
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
            Get.back();
            await controller.reportPost(
                postId, controller.reasonController.text);
          },
          reasonController: controller.reasonController),
      useRootNavigator: true,
    );
  }
}
