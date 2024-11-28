import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/data/models/auth/qrcode_response.dart';
import 'package:pic_share/views/pages/security/widgets/bottom_sheet_button.dart';
import 'package:pic_share/views/widgets/custom_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordDialog extends StatefulWidget {
  const PasswordDialog({
    required this.onUpdate2FA,
    required this.onShowConfirm2FA,
    super.key,
  });

  final Future<QRCodeResponse?> Function(String) onUpdate2FA;
  final Future<void> Function(QRCodeResponse) onShowConfirm2FA;

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  final TextEditingController passwordController = TextEditingController();
  bool isPassVisibility = false;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return CustomDialog(
      title: t.enterPasswordToConfirm,
      actions: [
        _buildCancelButton(t),
        _buildConfirmButton(t),
      ],
      content: _buildContent(context),
    );
  }

  Widget _buildCancelButton(AppLocalizations t) => BottomSheetBottom(
        title: t.cancel,
        backgroundColor: AppColors.appBorder,
        onTap: () {
          Get.back();
        },
        textColor: AppColors.postViewColor,
      );

  Widget _buildConfirmButton(AppLocalizations t) => BottomSheetBottom(
        title: t.confirm,
        onTap: () async {
          Get.back();
          QRCodeResponse? qrCodeModel =
              await widget.onUpdate2FA(passwordController.text.trim());
          if (qrCodeModel != null) {
            await widget.onShowConfirm2FA(qrCodeModel);
          }
        },
      );

  Widget _buildContent(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    final t = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
                onPressed: () {
                  setState(() {
                    isPassVisibility = !isPassVisibility;
                  });
                },
                icon: Icon(isPassVisibility
                    ? Icons.visibility_off_sharp
                    : Icons.visibility_sharp),
              ),
              hintText: t.password),
          obscureText: !isPassVisibility,
        ),
        SizedBox(height: size * 0.02),
      ],
    );
  }
}
