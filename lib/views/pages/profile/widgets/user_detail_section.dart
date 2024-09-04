import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';

class UserDetailsSection extends StatelessWidget {
  const UserDetailsSection(
      {super.key, required this.email, required this.name});
  final String name;
  final String email;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.details,
            style: AppTextStyles.commonTextStyle()
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.secondaryColor,
              border: Border.all(color: AppColors.greyBorder),
            ),
            child: Column(
              children: [
                _buildRow(t.name, name),
                _buildRow(t.email, email),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.smallTextStyle(),
            textAlign: TextAlign.left,
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyles.smallTextStyle(),
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
  }
}
