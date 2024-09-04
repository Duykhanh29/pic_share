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
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.userCode,
            style: AppTextStyles.commonTextStyle()
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.selectedColor,
              border: Border.all(color: AppColors.greyBorder),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
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
