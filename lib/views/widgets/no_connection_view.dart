import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/custom_filled_button.dart';

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final logoSize = size.height * 0.4;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Lottie.asset(AppResources.noInternet, height: logoSize),
              ),
            ),
            Text(
              "WHOOPS! ",
              style: AppTextStyles.headingTextStyle().copyWith(
                color: AppColors.warningColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Text(
                t.noConnection,
                style: AppTextStyles.commonTextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            CustomFilledButton(text: t.tryAgain, onTap: () {})
          ],
        ),
      ),
    );
  }
}
