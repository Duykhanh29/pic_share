import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/view_model/new_post/new_post_controller.dart';

class SharedUserWidget extends GetView<NewPostController> {
  const SharedUserWidget({
    super.key,
    required this.name,
    required this.url,
    required this.isSelected,
    this.isAll = false,
  });
  final String? url;
  final String name;
  final bool isSelected;
  final bool isAll;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: AppColors.selectedColor, width: 2)
                    : Border.all(
                        color: AppColors.transparentColor, width: 0.5)),
            child: isAll
                ? Icon(
                    Icons.people,
                    size: isSelected ? 40 : 30,
                    color: AppColors.white,
                  )
                : url != null
                    ? ImageCacheHelper.avatarImage(
                        url: url!,
                        height: isSelected ? 40 : 30,
                        width: isSelected ? 40 : 30,
                      )
                    : CircleAvatar(
                        radius: isSelected ? 20 : 15,
                        backgroundImage:
                            const AssetImage(AppImage.userEmptyAvatar),
                      ),
          ),
          Text(
            name,
            style: isSelected
                ? AppTextStyles.commonSelectedTextStyle()
                : AppTextStyles.smallLightTextStyle(),
          ),
        ],
      ),
    );
  }
}
