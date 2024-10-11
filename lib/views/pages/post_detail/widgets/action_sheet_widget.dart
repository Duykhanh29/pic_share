import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/helper/dialog_helper.dart';

class ActionSheetWidgetDetail extends StatelessWidget {
  const ActionSheetWidgetDetail({
    super.key,
    required this.onDeletePost,
    required this.onDownloadImage,
  });
  final Function() onDownloadImage;
  final Function() onDeletePost;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      height: 200,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 187, 196, 201),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {},
            child: Center(
              child: Text(t.share),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.blueGrey,
          ),
          InkWell(
            onTap: () async {
              Get.back();
              await onDownloadImage.call();
            },
            child: Center(
              child: Text(t.download),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.blueGrey,
          ),
          InkWell(
            onTap: () async {
              DialogHelper.showConfirmDialog(
                title: t.warning,
                message: t.areYouSureToDeleteThisPost,
                onConfirm: () async {
                  await onDeletePost.call();
                  Get.back(result: true);
                },
                onCancel: () {
                  Get.back();
                },
                context: context,
              );
            },
            child: Center(
              child: Text(
                t.delete,
                style: const TextStyle(color: AppColors.warningColor),
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.blueGrey,
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Center(
              child: Text(
                t.cancel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
