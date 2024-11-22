import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/views/pages/security/widgets/dialogs/confirm_2fa_dialog.dart';
import 'package:pic_share/views/pages/security/widgets/dialogs/password_confirm.dart';
import 'package:pic_share/views/widgets/loading_widget.dart';

class SecurityPage extends GetView<AuthController> {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        mainView(context),
        Obx(() {
          return controller.actionLoading.value
              ? const LoadingWidget()
              : const SizedBox.shrink();
        })
      ],
    );
  }

  Widget mainView(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: t.security).show(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Get.toNamed(Routes.changePassword);
              },
              title: Text(t.changePass),
              trailing: IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.changePassword);
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: AppColors.darkBorderColor,
                thickness: 0.3,
              ),
            ),
            Obx(
              () {
                return SwitchListTile(
                  title: Text(t.twoFactorAuthentication),
                  value: controller.currentUser.value?.isEnable2FA ?? false,
                  onChanged: (val) {
                    Get.dialog(PasswordDialog(
                      onUpdate2FA: (p0) async {
                        return await controller.updateState2FA(
                            password: p0, isEnable: val);
                      },
                      onShowConfirm2FA: (qrCodeData) async {
                        await Get.dialog(Confirm2faDialog(
                          qrCodeData: qrCodeData,
                          onConfirm: (code) async {
                            await controller.confirmEnable2FA(code: code);
                          },
                        ));
                      },
                    ));
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: AppColors.darkBorderColor,
                thickness: 0.3,
              ),
            ),
            Obx(
              () {
                return SwitchListTile(
                  title: Text(t.sendEmailForLogin),
                  value: controller
                          .currentUser.value?.config?.isEnableLoginEmail ??
                      false,
                  onChanged: (val) async {
                    await controller.updateUserInfo(isEnableLoginEmail: val);
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: AppColors.darkBorderColor,
                thickness: 0.3,
              ),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.notFound);
              },
              title: Text(t.termConditions),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
