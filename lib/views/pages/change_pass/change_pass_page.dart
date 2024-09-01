import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/view_model/change_password/change_pass_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
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
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  t.pleaseEnterNewPassword,
                  style: AppTextStyles.commonLightTextStyle(),
                ),
                const SizedBox(height: 30),
                TextFormField(
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
                        onPressed: controller.onChangeCurrentPassVissibility,
                        icon: Icon(controller.isCurrentPassVissibility.value
                            ? Icons.visibility_off_sharp
                            : Icons.visibility_sharp),
                      ),
                      hintText: t.currentPassword),
                  obscureText: !controller.isCurrentPassVissibility.value,
                ),
                const SizedBox(height: 10),
                TextFormField(
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
                        onPressed: controller.onChangeNewPassVissibility,
                        icon: Icon(controller.isNewPassVissibility.value
                            ? Icons.visibility_off_sharp
                            : Icons.visibility_sharp),
                      ),
                      hintText: t.newPassword),
                  obscureText: !controller.isNewPassVissibility.value,
                ),
                const SizedBox(height: 10),
                TextFormField(
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
                        onPressed: controller.onChangeConfirmNewPassVissibility,
                        icon: Icon(controller.isConfirmNewPassVissibility.value
                            ? Icons.visibility_off_sharp
                            : Icons.visibility_sharp),
                      ),
                      hintText: t.confirmNewPass),
                  obscureText: !controller.isConfirmNewPassVissibility.value,
                ),
                const SizedBox(height: 40),
                InkWell(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
