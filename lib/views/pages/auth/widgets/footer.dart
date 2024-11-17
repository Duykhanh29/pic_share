import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/view_model/app/app_controller.dart';

class FooterText extends GetView<AppController> {
  const FooterText({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: "© ${DateTime.now().year}. ",
            style: AppTextStyles.headingTextStyle(),
            children: [
              TextSpan(
                text: t.appName,
                style: AppTextStyles.headingTextStyle().copyWith(
                    color: Colors.red[400], fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Handle resend logic here
                  },
              ),
              TextSpan(
                text: appInfo,
                style: AppTextStyles.commonTextStyle(),
              ),
            ],
          ),
        ),
        Text(
          t.allRightReserved,
          style: AppTextStyles.smallTextStyle(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String get appInfo {
    return "  v${controller.appVersion.value} (${controller.buildNumber.value})";
  }
}
