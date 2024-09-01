import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/view_model/verify/verify_controller.dart';

class VerifyPage extends GetView<VerifyController> {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: t.verifyAccount).show(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(
                  t.pleaseEnterEmailForVerify,
                  style: AppTextStyles.commonLightTextStyle(),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return t.emailFieldCanNotBeEmpty;
                    }
                    if (!EmailValidator.validate(value)) {
                      return t.pleaseEnterValidEmail;
                    }
                    return null;
                  },
                  controller: controller.emailController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: t.email),
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: () {},
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
                        t.confirm,
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
