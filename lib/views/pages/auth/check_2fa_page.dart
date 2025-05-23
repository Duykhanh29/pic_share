import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/helper/custom_filled_button.dart';
import 'package:pic_share/app/helper/custom_material_view.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/views/pages/auth/widgets/auth_layout_view.dart';
import 'package:pic_share/views/widgets/labelled_otp_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Check2FPage extends StatefulWidget {
  const Check2FPage({super.key});

  @override
  State<Check2FPage> createState() => _Check2FPageState();
}

class _Check2FPageState extends State<Check2FPage> {
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthController authController = Get.find<AuthController>();

  @override
  void dispose() {
    otpController.dispose();
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
            verticalSpace(size * 0.06),
            LabelledOtpField(
              otpController: otpController,
              title: t.check2FA,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return t.invalidOTPFormat;
                }
                return null;
              },
            ),
            verticalSpace(size * 0.06),
            CustomFilledButton(
              text: t.check2FA,
              onTap: () async {
                if (formKey.currentState?.validate() ?? false) {
                  await authController.check2FA(code: otpController.text);
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
