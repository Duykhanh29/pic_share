import 'package:flutter/material.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/views/pages/notification/widgets/notification_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: t.notification, isLeadingShow: false).show(),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return NotificationItemCard(
            isSeen: index % 2 == 0,
          );
        },
        itemCount: 40,
      ),
    );
  }
}
