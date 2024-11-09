import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/pages/auth/widgets/footer.dart';
import 'package:pic_share/views/pages/logo_widget.dart';
import 'package:pic_share/views/widgets/keyboard_dismiss.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({
    super.key,
    required this.title,
    required this.emailController,
    required this.onSubmitted,
    required this.passwordController,
    required this.formKey,
    required this.isPassVisibility,
    required this.onChangePassVisibility,
    required this.child,
    this.isRegister = false,
    this.onChangeConfirmPassVisibility,
    this.confirmPassController,
    this.nameController,
    this.isConfirmPassVisibility,
  });
  final Future<void> Function() onSubmitted;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPassVisibility;
  final bool? isConfirmPassVisibility;
  final void Function() onChangePassVisibility;
  final void Function()? onChangeConfirmPassVisibility;
  final TextEditingController? nameController;
  final TextEditingController? confirmPassController;
  final String title;
  final GlobalKey formKey;
  final Widget child;
  final bool isRegister;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightSize = size.height;
    final t = AppLocalizations.of(context)!;
    return KeyboardDismiss(
      child: Scaffold(
        // backgroundColor: AppColors.backgrounAuthScreendColor,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.backgroundColor,
                  AppColors.backgroundAuthScreenColor,
                  AppColors.thirdColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const LogoWidget(),
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
                        SizedBox(
                          height: heightSize * 0.01,
                        ),
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
                  SizedBox(
                    height: heightSize * 0.01,
                  ),
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
                          onPressed: onChangePassVisibility,
                          icon: Icon(isPassVisibility
                              ? Icons.visibility_off_sharp
                              : Icons.visibility_sharp),
                        ),
                        hintText: t.password),
                    obscureText: !isPassVisibility,
                  ),
                  Visibility(
                    visible: isRegister,
                    child: Column(
                      children: [
                        SizedBox(
                          height: heightSize * 0.01,
                        ),
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
                                onPressed: onChangeConfirmPassVisibility,
                                icon: Icon(isConfirmPassVisibility == true
                                    ? Icons.visibility_off_sharp
                                    : Icons.visibility_sharp),
                              ),
                              hintText: t.passwordConfirmation),
                          obscureText: isConfirmPassVisibility != null
                              ? !isConfirmPassVisibility!
                              : false,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: heightSize * 0.02,
                  ),
                  GestureDetector(
                    onTap: onSubmitted,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: heightSize * 0.06,
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
