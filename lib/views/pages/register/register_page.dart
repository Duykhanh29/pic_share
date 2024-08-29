import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/view_model/register/register_controller.dart';
import 'package:pic_share/views/pages/auth/auth_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Obx(
      () => AuthView(
        confirmPassController: controller.confirmPasswordController,
        isConfirmPassVissibility: controller.isConfirmPassVissibility.value,
        nameController: controller.nameController,
        onChangeConfirmPassVissibility:
            controller.onChangeConfirmPassVissibility,
        isRegister: true,
        title: t.register,
        emailController: controller.emailController,
        onSubmitted: controller.registerUserByEmailAndPass,
        passwordController: controller.passController,
        formKey: controller.formKey,
        isPassVissibility: controller.isPassVissibility.value,
        onChangePassVissibility: controller.onChangePassVissibility,
        child: Column(
          children: [
            const SizedBox(height: 30),
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
              height: MediaQuery.of(context).size.height * 0.08,
            ),
          ],
        ),
      ),
    );
  }
}
