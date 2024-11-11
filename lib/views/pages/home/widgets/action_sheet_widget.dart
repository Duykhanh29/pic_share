import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/helper/dialog_helper.dart';

class ActionSheetWidget extends StatelessWidget {
  const ActionSheetWidget({
    super.key,
    required this.isPostOwner,
    required this.onDeletePost,
    required this.onDownloadImage,
    required this.onOpenReportSheetAction,
  });
  final bool isPostOwner;
  final Function()? onDownloadImage;
  final Function()? onDeletePost;
  final Function()? onOpenReportSheetAction;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return IntrinsicHeight(
      child: Container(
        // height: isPostOwner ? 200 : 300,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 187, 196, 201),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(t.share),
                ),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.blueGrey,
            ),
            InkWell(
              onTap: () async {
                Get.back();
                await onDownloadImage?.call();
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(t.download),
                ),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.blueGrey,
            ),
            isPostOwner
                ? InkWell(
                    onTap: () async {
                      DialogHelper.showConfirmDialog(
                        title: t.warning,
                        message: t.areYouSureToDeleteThisPost,
                        onConfirm: () async {
                          Get.back();
                          await onDeletePost?.call();
                        },
                        onCancel: () {
                          Get.back();
                        },
                        context: context,
                      );
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          t.delete,
                          style: const TextStyle(color: AppColors.warningColor),
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      Get.back(); // Close the current bottom sheet

                      // Wait a moment to make sure the bottom sheet is completely closed
                      await Future.delayed(const Duration(milliseconds: 200));

                      if (!context.mounted) return;

                      //show another bottom sheet
                      await onOpenReportSheetAction?.call();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          t.report,
                          style: const TextStyle(color: AppColors.warningColor),
                        ),
                      ),
                    ),
                  ),
            Container(
              height: 4,
              color: AppColors.black,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    t.cancel,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
