import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/view_model/change_password/change_pass_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/widgets/loading_widget.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final heightSize = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBar(title: t.changePass).show(),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: heightSize * 0.05,
                    ),
                    Text(
                      t.pleaseEnterNewPassword,
                      style: AppTextStyles.commonLightTextStyle(),
                    ),
                    SizedBox(
                      height: heightSize * 0.03,
                    ),
                    _buildCurrentPassTextField(t),
                    SizedBox(
                      height: heightSize * 0.01,
                    ),
                    _buildNewPassTextField(t),
                    SizedBox(
                      height: heightSize * 0.01,
                    ),
                    _buildConfirmPassTextField(t),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: _buildButton(context, t),
        ),
        if (controller.isLoading.value) const LoadingWidget(),
      ],
    );
  }

  Widget _buildCurrentPassTextField(AppLocalizations t) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return t.passCannotBeEmpty;
        }
        if (value.length < 6) {
          return t.minPasswordLength;
        }
        return null;
      },
      controller: controller.currentPassController,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          suffixIcon: IconButton(
            onPressed: controller.onChangeCurrentPassVisibility,
            icon: Icon(controller.isCurrentPassVisibility.value
                ? Icons.visibility_off_sharp
                : Icons.visibility_sharp),
          ),
          hintText: t.currentPassword),
      obscureText: !controller.isCurrentPassVisibility.value,
    );
  }

  Widget _buildNewPassTextField(AppLocalizations t) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return t.passCannotBeEmpty;
        }
        if (value.length < 6) {
          return t.minPasswordLength;
        }
        return null;
      },
      controller: controller.newPassController,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          suffixIcon: IconButton(
            onPressed: controller.onChangeNewPassVisibility,
            icon: Icon(controller.isNewPassVisibility.value
                ? Icons.visibility_off_sharp
                : Icons.visibility_sharp),
          ),
          hintText: t.newPassword),
      obscureText: !controller.isNewPassVisibility.value,
    );
  }

  Widget _buildConfirmPassTextField(AppLocalizations t) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return t.passCannotBeEmpty;
        }
        if (value != controller.newPassController.text) {
          return t.passwordDoesNotMmatch;
        }
        return null;
      },
      controller: controller.confirmNewPasswordController,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          suffixIcon: IconButton(
            onPressed: controller.onChangeConfirmNewPassVisibility,
            icon: Icon(controller.isConfirmNewPassVisibility.value
                ? Icons.visibility_off_sharp
                : Icons.visibility_sharp),
          ),
          hintText: t.confirmNewPass),
      obscureText: !controller.isConfirmNewPassVisibility.value,
    );
  }

  Widget _buildButton(BuildContext context, AppLocalizations t) {
    return InkWell(
      onTap: controller.onChangePassword,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.thirdColor,
        ),
        child: Center(
          child: Text(
            t.complete,
            style: AppTextStyles.commonTextStyle()
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
