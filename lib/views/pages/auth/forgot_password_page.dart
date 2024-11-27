import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/helper/custom_filled_button.dart';
import 'package:pic_share/app/helper/custom_material_view.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/views/pages/auth/widgets/auth_layout_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return mainView(context);
  }

  Widget mainView(BuildContext context) {
    return Obx(
      () => AuthLayoutView(
        isLoading: authController.actionLoading.value,
        child: _formView(context),
      ),
    );
  }

  Widget _formView(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size.height;
    return CustomMaterialView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return t.emailFieldCanNotBeEmpty;
                }
                if (!EmailValidator.validate(value)) {
                  return t.pleaseEnterValidEmail;
                }
                return null;
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: t.email),
            ),
            verticalSpace(size * 0.06),
            CustomFilledButton(
              text: t.resetPassword,
              onTap: () async {
                if (formKey.currentState?.validate() ?? false) {
                  await authController.forgotPassword(
                      email: emailController.text);
                }
              },
            ),
            verticalSpace(size * 0.06),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                t.backToLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget verticalSpace(double size) {
    return SizedBox(height: size);
  }
}
