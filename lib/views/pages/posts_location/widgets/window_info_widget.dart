import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/config/app_config.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WindowInfoWidget extends StatelessWidget {
  const WindowInfoWidget({
    super.key,
    required this.title,
    this.imageUrl,
    required this.details,
    required this.onTap,
    this.isShowActionRow = true,
  });
  final String? title;
  final String? imageUrl;
  final String? details;
  final Function() onTap;
  final bool isShowActionRow;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Card(
      elevation: 5,
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(title ?? ""),
              const SizedBox(height: 5),
              imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      AppConfig.baseUrl + imageUrl!,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.9,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 15),
              Container(
                height: 1,
                color: AppColors.greyBorder,
              ),
              const SizedBox(height: 15),
              _buildActionRow(t),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionRow(AppLocalizations t) {
    return isShowActionRow
        ? Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.thirdBorder),
                    child: Text(
                      t.cancel,
                      style: AppTextStyles.commonTextStyle()
                          .copyWith(color: AppColors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onTap.call();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.thirdColor),
                    child: Text(
                      t.postDetail,
                      style: AppTextStyles.commonTextStyle()
                          .copyWith(color: AppColors.black),
                    ),
                  ),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
