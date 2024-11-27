import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/custom_filled_button.dart';
import 'package:pic_share/app/helper/custom_material_view.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/pages/auth/widgets/auth_layout_view.dart';
import 'package:pic_share/views/widgets/labelled_otp_field.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isConfirmPassInVisibility = true;
  bool isPassInVisibility = true;
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              LabelledOtpField(
                otpController: otpController,
                title: t.verificationCode,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return t.invalidOTPFormat;
                  }
                  return null;
                },
              ),
              verticalSpace(size * 0.02),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return t.passCannotBeEmpty;
                  }
                  if (value.length < 6) {
                    return t.minPasswordLength;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: t.password,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPassInVisibility = !isPassInVisibility;
                      });
                    },
                    icon: Icon(isPassInVisibility == true
                        ? Icons.visibility_off_sharp
                        : Icons.visibility_sharp),
                  ),
                ),
                obscureText: isPassInVisibility,
              ),
              verticalSpace(size * 0.02),
              TextFormField(
                controller: confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return t.passCannotBeEmpty;
                  }
                  if (value != passwordController.text) {
                    return t.passwordDoesNotMmatch;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: t.passwordConfirmation,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isConfirmPassInVisibility = !isConfirmPassInVisibility;
                      });
                    },
                    icon: Icon(isConfirmPassInVisibility == true
                        ? Icons.visibility_off_sharp
                        : Icons.visibility_sharp),
                  ),
                ),
                obscureText: isConfirmPassInVisibility,
              ),
              verticalSpace(size * 0.02),
              Obx(
                () => Text(
                  t.otpValidity(authController.otpValidity.value.toString()),
                  style: AppTextStyles.smallTextStyle(),
                ),
              ),
              verticalSpace(size * 0.02),
              CustomFilledButton(
                text: t.resetPassword,
                onTap: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    await authController.resetPassword(
                      otp: otpController.text,
                      password: passwordController.text.trim(),
                      passwordConfirmation:
                          confirmPasswordController.text.trim(),
                      email: authController.resetEmail.value,
                    );
                  }
                },
              ),
              verticalSpace(size * 0.02),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  t.back,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget verticalSpace(double size) {
    return SizedBox(height: size);
  }
}
