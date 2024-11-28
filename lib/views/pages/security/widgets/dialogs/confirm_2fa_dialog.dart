import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/data/models/auth/qrcode_response.dart';
import 'package:pic_share/views/pages/security/widgets/bottom_sheet_button.dart';
import 'package:pic_share/views/widgets/custom_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/widgets/labelled_otp_field.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Confirm2faDialog extends StatefulWidget {
  const Confirm2faDialog({
    required this.qrCodeData,
    required this.onConfirm,
    super.key,
  });

  final QRCodeResponse qrCodeData;
  final Function(String) onConfirm;

  @override
  State<Confirm2faDialog> createState() => _Confirm2faDialogState();
}

class _Confirm2faDialogState extends State<Confirm2faDialog> {
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isOpenTextCode = false;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Form(
      key: formKey,
      child: CustomDialog(
        title: t.account_security_activate2FA,
        actions: [
          _buildCancelButton(t),
          _buildActivateButton(t),
        ],
        content: _buildDialogContent(context),
      ),
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

  Widget _buildActivateButton(AppLocalizations t) => BottomSheetBottom(
        title: t.account_security_activate,
        onTap: () {
          if (formKey.currentState?.validate() ?? false) {
            widget.onConfirm(otpController.text);
            Get.back();
          }
        },
      );

  Widget _buildDialogContent(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final spaceM = MediaQuery.of(context).size.height * 0.02;
    final spaceL = MediaQuery.of(context).size.height * 0.04;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildGuidance(context),
        verticalSpace(spaceM),
        _buildQRCodeImage(context),
        verticalSpace(spaceL),
        _buildScanWithCode(context),
        verticalSpace(spaceL),
        _buildOtpField(t),
        verticalSpace(spaceL),
      ],
    );
  }

  Widget _buildGuidance(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: size * 0.02),
          child: Text(
            t.account_security_authAppSetup,
            style: context.textTheme.bodyMedium!,
          ),
        ),
        _buildGuideline(context, t.account_security_installAuthApp),
        _buildGuideline(context, t.account_security_addAnAcc),
        _buildGuideline(context, t.account_security_scanBarcode),
        verticalSpace(size * 0.01),
        _buildRecommendedApps(t),
      ],
    );
  }

  Widget _buildGuideline(BuildContext context, String title) {
    final size = MediaQuery.of(context).size.width * 0.02;
    return Row(
      children: [
        Icon(Icons.circle, size: size / 2, color: AppColors.black),
        horizontalSpace(size),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(2),
            child: Text(
              title,
              style: AppTextStyles.smallTextStyle().copyWith(fontSize: 10),
              overflow: TextOverflow.clip,
              maxLines: 2,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildRecommendedApps(AppLocalizations t) => Text(
        "(${t.account_security_popularApps})",
        style: AppTextStyles.smallTextStyle().copyWith(fontSize: 8),
        overflow: TextOverflow.clip,
        maxLines: 3,
      );

  Widget _buildQRCodeImage(BuildContext context) {
    final screenHeightQuarter = MediaQuery.of(context).size.height * 0.25;
    return SizedBox(
      height: screenHeightQuarter,
      width: screenHeightQuarter,
      child: QrImageView(
        data: widget.qrCodeData.qrCodeUrl,
        size: screenHeightQuarter,
        gapless: false,
      ),
    );
  }

  Widget _buildScanWithCode(BuildContext context) {
    final spaceM = MediaQuery.of(context).size.height * 0.01;
    final t = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              isOpenTextCode = !isOpenTextCode;
            });
          },
          child: Text(
            t.account_security_cannotScan,
            style: context.textTheme.bodyMedium
                ?.copyWith(color: AppColors.backgroundColor),
          ),
        ),
        if (isOpenTextCode) ...[
          verticalSpace(spaceM),
          _buildCodeWithText(),
        ],
      ],
    );
  }

  Widget _buildCodeWithText() => Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: AppColors.backgroundColor),
          ),
        ),
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.qrCodeData.code,
                style: context.textTheme.bodyMedium,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            InkWell(
              onTap: () async {
                await Clipboard.setData(
                  ClipboardData(text: widget.qrCodeData.code),
                );
              },
              child: Icon(Icons.copy, color: AppColors.darkBackgroundColor),
            ),
          ],
        ),
      );

  Widget _buildOtpField(AppLocalizations t) {
    return LabelledOtpField(
      otpController: otpController,
      title: t.account_security_enterSixDigit,
      validator: (p0) {
        if (p0!.isEmpty) {
          return t.invalidOTPFormat;
        }
        return null;
      },
    );
  }

  Widget verticalSpace(double size) {
    return SizedBox(height: size);
  }

  Widget horizontalSpace(double size) {
    return SizedBox(width: size);
  }
}
