import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/constants/global_data.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/view_model/new_post/new_post_controller.dart';
import 'package:pic_share/views/pages/new_post/widgets/shared_user_widget.dart';
import 'package:pic_share/views/widgets/keyboard_dismiss.dart';
import 'package:pic_share/views/widgets/loading_widget.dart';

class NewPostPage extends GetView<NewPostController> {
  const NewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismiss(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return CustomAppBar(
      textStyle: AppTextStyles.appBarLightTexStyle(),
      title: t.newPost,
      centerTitle: true,
      isLeadingShow: false,
      background: AppColors.postViewColor,
      actions: [
        IconButton(
          onPressed: controller.onDownloadImageToGallery,
          icon: const Icon(
            Icons.download_for_offline_outlined,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: controller.checkIn,
          icon: const Icon(
            Icons.location_on_outlined,
            color: Colors.white,
          ),
        ),
      ],
    ).show();
  }

  Widget _buildBody(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return isPortrait ? _buildView(context) : _buildLandscapeView(context);
  }

  Widget _buildLandscapeView(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size.height;
    return Container(
      height: size * singlePostSize,
      decoration: BoxDecoration(
        color: AppColors.postViewColor,
        border: Border.all(color: AppColors.backgroundColor),
      ),
      child: Center(
        child: Text(
          t.switchToPortraitToTakePicture,
          style: AppTextStyles.headingLightTextStyle(),
        ),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Obx(
      () => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.postViewColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCameraView(context),
                const SizedBox(
                  height: 10,
                ),
                _buildRowActions(),
                Obx(
                  () => controller.pictureFile.value != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(
                            color: AppColors.lightBorderColor,
                            thickness: 0.2,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(() => controller.pictureFile.value != null
                    ? _buildFriendShareOption(t)
                    : const SizedBox.shrink()),
              ],
            ),
          ),
          if (controller.isLoading.value) const LoadingWidget(),
        ],
      ),
    );
  }

  Widget _buildCameraView(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final postRadius = size.height * radioNewPostView;
    final t = AppLocalizations.of(context)!;
    return Obx(() {
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(postRadius),
              border: Border.all(color: AppColors.backgroundColor)),
          child: controller.isCameraInitialized.value
              ? controller.pictureFile.value != null
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(postRadius),
                          child: Image.file(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              File(
                                controller.pictureFile.value!.path,
                              ),
                              fit: BoxFit.fill),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black.withOpacity(0.6)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Obx(
                              () => TextField(
                                style: AppTextStyles.commonLightTextStyle(),
                                onTapOutside: (event) {
                                  controller.onClearFocus();
                                },
                                onEditingComplete: controller.onClearFocus,
                                onSubmitted: (value) {
                                  controller.onClearFocus();
                                },
                                focusNode: controller.focusNode.value,
                                textAlign: TextAlign.center,
                                controller: controller.captionController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 5),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.darkBorderColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: t.addCaption,
                                  hintStyle:
                                      AppTextStyles.commonLightTextStyle(),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(postRadius),
                      child: AspectRatio(
                        aspectRatio: 1.25,
                        child: CameraPreview(
                          controller.cameraController,
                        ),
                      ),
                    )
              : const SizedBox(),
        ),
      );
    });
  }

  Widget _buildRowActions() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Obx(
        () {
          return controller.pictureFile.value != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.onSetToDefault();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                        weight: 15,
                        size: 30,
                      ),
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: controller.isReadyToUpload
                            ? controller.createPost
                            : null,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.onFocusOnCaptionTextField,
                      child: const Icon(
                        Icons.abc_outlined,
                        color: Colors.white,
                        weight: 15,
                        size: 30,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: controller.onSwitchFlashMode,
                      child: Obx(
                        () => controller.isEnableFlash.value
                            ? const Icon(
                                Icons.flash_on_outlined,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.flash_off_outlined,
                                color: Colors.white,
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await controller.takePicture();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.yellow, width: 5)),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.switchCamera();
                      },
                      child: const Icon(
                        Icons.switch_camera_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildFriendShareOption(AppLocalizations t) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return index == 0
              ? Obx(
                  () => Tooltip(
                    message: t.warningToShareWithFriend,
                    child: GestureDetector(
                      onTap: controller.onChangeSelectAllUser,
                      child: SharedUserWidget(
                        name: t.all,
                        url: null,
                        isSelected: controller.isSelectAllUser.value,
                        isAll: true,
                      ),
                    ),
                  ),
                )
              : Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.onChangeSelectedUser(index: index - 1);
                    },
                    child: SharedUserWidget(
                      isSelected: controller.listSelectedUser[index - 1],
                      name: controller.friends[index - 1].name ?? "",
                      url: controller.friends[index - 1].avatar,
                    ),
                  ),
                );
        },
        itemCount: controller.friends.length + 1,
      ),
    );
  }
}
