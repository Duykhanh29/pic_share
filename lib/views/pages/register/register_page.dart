import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/view_model/register/register_controller.dart';
import 'package:pic_share/views/pages/auth/auth_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/widgets/loading_widget.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    final t = AppLocalizations.of(context)!;
    return Obx(
      () => Stack(
        children: [
          AuthView(
            confirmPassController: controller.confirmPasswordController,
            isConfirmPassVisibility: controller.isConfirmPassVisibility.value,
            nameController: controller.nameController,
            onChangeConfirmPassVisibility:
                controller.onChangeConfirmPassVisibility,
            isRegister: true,
            title: t.register,
            emailController: controller.emailController,
            onSubmitted: controller.registerUserByEmailAndPass,
            passwordController: controller.passController,
            formKey: controller.formKey,
            isPassVisibility: controller.isPassVisibility.value,
            onChangePassVisibility: controller.onChangePassVisibility,
            child: Column(
              children: [
                SizedBox(height: size * 0.02),
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      t.alreadyHaveAccount,
                      style: AppTextStyles.commonTextStyle()
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                SizedBox(
                  height: size * 0.06,
                ),
              ],
            ),
          ),
          if (controller.isLoading.value) const LoadingWidget(),
        ],
      ),
    );
  }
}
