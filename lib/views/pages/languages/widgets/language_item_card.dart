import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/data/models/language.dart';

class LanguageItemCard extends StatelessWidget {
  const LanguageItemCard(
      {super.key,
      required this.isSelected,
      required this.onSelected,
      required this.language});
  final bool isSelected;
  final void Function() onSelected;
  final Language language;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: AppColors.appBorder, width: 0.5),
      ),
      onTap: onSelected,
      leading: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
        child: Image.asset(language.image),
      ),
      title: Text(
        language.code,
        style: AppTextStyles.headingTextStyle(),
      ),
      trailing: buildCheckContainer(isSelected),
    );
  }

  Widget buildCheckContainer(bool check) {
    return check
        ? Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.green),
            child: const Padding(
              padding: EdgeInsets.all(3),
              child: Icon(Icons.check, color: Colors.white, size: 10),
            ),
          )
        : const SizedBox();
  }
}
