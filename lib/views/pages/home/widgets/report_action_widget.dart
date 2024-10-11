import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';

class ReportActionWidget extends StatelessWidget {
  const ReportActionWidget(
      {super.key, required this.onReportPost, required this.reasonController});
  final TextEditingController reasonController;
  final Function()? onReportPost;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      height: 240,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 187, 196, 201),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              t.reason,
              style: AppTextStyles.commonTextStyle(),
            ),
          ),
          TextField(
            textInputAction: TextInputAction.done,
            maxLines: 4,
            controller: reasonController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: AppColors.appBorder,
                ),
              ),
              alignLabelWithHint: true,
              hintText: t.inputReason,
              hintStyle: AppTextStyles.smallTextStyle(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.thirdColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () async {
                  await onReportPost?.call();
                },
                child: Text(
                  t.submit,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
