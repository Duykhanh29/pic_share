import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/view_model/edit_profile/edit_profile_controller.dart';
import 'package:pic_share/views/widgets/loading_widget.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBar(title: t.editProfile).show(),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSpacing(
                    context,
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  _buildAvatarSection(context),
                  _buildSpacing(context),
                  _buildNameTextField(t),
                  _buildSpacing(context),
                ],
              ),
            ),
          ),
          bottomNavigationBar: _buildEditButton(t),
        ),
        if (controller.isLoading.value) const LoadingWidget(),
      ],
    );
  }

  Widget _buildAvatarSection(BuildContext context) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      child: Stack(
        children: [
          _buildAvatar(context),
          _buildEditAvatarButton(context),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Obx(
      () => controller.isNewAvatar.value && controller.avatarFile.value != null
          ? CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.05,
              backgroundImage: FileImage(
                File(controller.avatarFile.value!.path),
              ),
            )
          : controller.currentUser?.urlAvatar != null
              ? ImageCacheHelper.avatarImage(
                  url: controller.currentUser!.urlAvatar!,
                  width: MediaQuery.of(context).size.height * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                )
              : CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.05,
                  backgroundImage: const AssetImage(AppImage.userEmptyAvatar),
                ),
    );
  }

  Widget _buildEditAvatarButton(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onTap: controller.pickAvatar,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.edit,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildNameTextField(AppLocalizations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            t.name,
            style: AppTextStyles.commonTextStyle(),
          ),
        ),
        TextFormField(
          controller: controller.nameController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: t.name),
        ),
      ],
    );
  }

  Widget _buildEditButton(AppLocalizations t) {
    return GestureDetector(
      onTap: controller.updateUserInfo,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.lightTabBarColor),
            ),
            alignment: Alignment.center,
            child: Text(
              t.save,
              style: AppTextStyles.headingTextStyle(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpacing(BuildContext context, {double? height}) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.08,
    );
  }
}
