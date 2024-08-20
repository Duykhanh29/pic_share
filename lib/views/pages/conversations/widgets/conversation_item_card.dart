import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/routes/app_pages.dart';

class ConversationItemCard extends StatelessWidget {
  const ConversationItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.toNamed(Routes.chat);
      },
      contentPadding: const EdgeInsets.all(5),
      title: Text(
        "DO XUAN DUONG",
        style: AppTextStyles.headingTextStyle(),
      ),
      leading: ImageCacheHelper.avatarImage(
          url:
              "https://st.depositphotos.com/2001755/3622/i/450/depositphotos_36220949-stock-photo-beautiful-landscape.jpg",
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.1),
      trailing: Text(
        "Time",
        style: AppTextStyles.smallTextStyle(),
      ),
    );
  }
}
