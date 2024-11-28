import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';

class UserCodeSection extends StatelessWidget {
  const UserCodeSection(
      {super.key, required this.userCode, required this.onCopyUserCode});
  final String userCode;
  final void Function() onCopyUserCode;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final heightSize = MediaQuery.of(context).size.height;
    final verticalPadding = heightSize * 0.02;
    return Container(
      padding: EdgeInsets.all(verticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.userCode,
            style: AppTextStyles.commonTextStyle()
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: verticalPadding),
          Container(
            padding: EdgeInsets.all(verticalPadding / 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(verticalPadding),
              color: AppColors.selectedColor,
              border: Border.all(color: AppColors.greyBorder),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: verticalPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userCode,
                        style: AppTextStyles.commonTextStyle(),
                      ),
                      IconButton(
                        onPressed: onCopyUserCode,
                        icon: const Icon(Icons.copy),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
