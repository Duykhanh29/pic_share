import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';

class FooterText extends StatelessWidget {
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
}
