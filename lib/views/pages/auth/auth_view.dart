import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/pages/auth/widgets/footer.dart';
import 'package:pic_share/views/widgets/keyboard_dismiss.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({
    super.key,
    required this.title,
    required this.emailController,
    required this.onSubmitted,
    required this.passwordController,
    required this.formKey,
    required this.isPassVissibility,
    required this.onChangePassVissibility,
    required this.child,
    this.isRegister = false,
    this.onChangeConfirmPassVissibility,
    this.confirmPassController,
    this.nameController,
    this.isConfirmPassVissibility,
  });
  final Future<void> Function() onSubmitted;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPassVissibility;
  final bool? isConfirmPassVissibility;
  final void Function() onChangePassVissibility;
  final void Function()? onChangeConfirmPassVissibility;
  final TextEditingController? nameController;
  final TextEditingController? confirmPassController;
  final String title;
  final GlobalKey formKey;
  final Widget child;
  final bool isRegister;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return KeyboardDismiss(
      child: Scaffold(
        backgroundColor: AppColors.backgrounAuthScreendColor,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 50),
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      AppImage.picShareLogo,
                      width: 90,
                      height: 90,
                    ),
                  ),
                  Visibility(
                    visible: isRegister,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: t.name),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
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
                  const SizedBox(height: 15),
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
                    controller: passwordController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: IconButton(
                          onPressed: onChangePassVissibility,
                          icon: Icon(isPassVissibility
                              ? Icons.visibility_off_sharp
                              : Icons.visibility_sharp),
                        ),
                        hintText: t.password),
                    obscureText: !isPassVissibility,
                  ),
                  Visibility(
                    visible: isRegister,
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return t.passCannotBeEmpty;
                            }
                            if (value != passwordController.text) {
                              return t.passwordDoesNotMmatch;
                            }
                            return null;
                          },
                          controller: confirmPassController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              suffixIcon: IconButton(
                                onPressed: onChangeConfirmPassVissibility,
                                icon: Icon(isConfirmPassVissibility == true
                                    ? Icons.visibility_off_sharp
                                    : Icons.visibility_sharp),
                              ),
                              hintText: t.passwordConfirmation),
                          obscureText: isConfirmPassVissibility != null
                              ? !isConfirmPassVissibility!
                              : false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: onSubmitted,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.postViewColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          title,
                          style: AppTextStyles.headingLightTextStyle(),
                        ),
                      ),
                    ),
                  ),
                  child,
                  const FooterText()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
