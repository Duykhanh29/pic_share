import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/sign_in/sign_in_controller.dart';
import 'package:pic_share/views/pages/auth/auth_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Obx(
      () => AuthView(
        title: t.signIn,
        emailController: controller.emailController,
        onSubmitted: controller.signInWithEmailPass,
        passwordController: controller.passController,
        formKey: controller.formKey,
        isPassVissibility: controller.isPassVissibility.value,
        onChangePassVissibility: controller.onChangePassVissibility,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
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
                  Get.toNamed(Routes.register);
                },
                child: Text(
                  t.register,
                  style: AppTextStyles.commonTextStyle()
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            _buildOrLine(t),
            const SizedBox(
              height: 20,
            ),
            _buildSignInOptions(t),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrLine(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 9,
            ),
            child: SizedBox(
              width: 100,
              child: Divider(
                color: AppColors.appBorder,
                height: 0.4,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            t.or,
          ),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 9,
            ),
            child: SizedBox(
              width: 100,
              child: Divider(
                color: AppColors.appBorder,
                height: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInOptions(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: controller.signInWithGoogle,
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: AppColors.secondaryColor, width: 0.8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(AppImage.googleLogo)),
          ),
          const SizedBox(width: 50),
          GestureDetector(
            onTap: () {},
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: AppColors.secondaryColor, width: 0.8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(AppImage.facebookLogo)),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
