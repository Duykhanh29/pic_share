import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
    required this.title,
    this.subtitle,
    required this.icon,
  });

  final Color backgroundColor;
  final Color iconColor;
  final Function()? onTap;
  final String title;
  final String? subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric( horizontal: 10),
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
              ),
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.commonTextStyle()
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: AppTextStyles.smallTextStyle(),
                  ),
              ],
            )
          ],
        ),
      ),
    );

    // ListTile(
    //   leading: Container(
    //     height: 45,
    //     width: 45,
    //     decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //       color: backgroundColor,
    //     ),
    //     child: Icon(
    //       icon,
    //       color: iconColor,
    //     ),
    //   ),
    //   title: Text(
    //     title,
    //     style: AppTextStyles.commonTextStyle()
    //         .copyWith(fontWeight: FontWeight.w600),
    //   ),
    //   subtitle: subtitle != null
    //       ? Text(
    //           subtitle!,
    //           style: AppTextStyles.smallTextStyle(),
    //         )
    //       : null,
    //   onTap: onTap,
    // );
  }
}
