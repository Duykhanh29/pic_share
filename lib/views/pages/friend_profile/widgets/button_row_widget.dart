import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/data/enums/user_relationship.dart';
import 'package:pic_share/data/models/user/user_friendship_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonRowWidget extends StatelessWidget {
  const ButtonRowWidget(
      {super.key,
      required this.friend,
      required this.onChatClick,
      required this.onAddFriendTap,
      required this.onAcceptTap,
      required this.onRejectTap});
  final UserFriendShipModel? friend;
  final Function(int) onAddFriendTap, onAcceptTap, onRejectTap;
  final Function() onChatClick;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: friend?.relationship == UserRelationship.friend
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSingleButton(
                    t: t,
                    context: context,
                    title: t.chat,
                    onTap: () {
                      onChatClick.call();
                    },
                    icon: Icons.message_outlined,
                    backgroundColor: AppColors.white,
                    borderColor: AppColors.appBorder),
                _buildSingleButton(
                    t: t,
                    context: context,
                    title: t.unfriend,
                    onTap: () async {
                      await onReject();
                    },
                    icon: Icons.person_add_disabled,
                    backgroundColor: AppColors.orange,
                    borderColor: AppColors.white),
              ],
            )
          : friend?.relationship == UserRelationship.notFriend
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSingleButton(
                        t: t,
                        context: context,
                        title: t.addFriend,
                        onTap: () async {
                          if (friend?.user.id == null) return;
                          await onAddFriendTap.call(friend!.user.id!);
                        },
                        icon: Icons.person_add_alt_1,
                        backgroundColor: AppColors.secondaryBorder,
                        borderColor: AppColors.white),
                  ],
                )
              : friend?.relationship == UserRelationship.sent
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSingleButton(
                            t: t,
                            context: context,
                            title: t.recall,
                            onTap: () async {
                              await onReject();
                            },
                            icon: Icons.cancel,
                            backgroundColor: AppColors.warningColor,
                            borderColor: AppColors.white),
                      ],
                    )
                  : friend?.relationship == UserRelationship.requested
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildSingleButton(
                                t: t,
                                context: context,
                                title: t.reject,
                                onTap: () async {
                                  await onReject();
                                },
                                icon: Icons.clear,
                                backgroundColor: AppColors.warningColor,
                                borderColor: AppColors.white),
                            _buildSingleButton(
                                t: t,
                                context: context,
                                title: t.accept,
                                onTap: () async {
                                  if (friend?.user.id == null) return;
                                  await onAcceptTap(friend!.id);
                                },
                                icon: Icons.done,
                                backgroundColor: AppColors.white,
                                borderColor: AppColors.appBorder),
                          ],
                        )
                      : const SizedBox.shrink(),
    );
  }

  Widget _buildSingleButton({
    required AppLocalizations t,
    required BuildContext context,
    required String title,
    required Function() onTap,
    required IconData icon,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor ?? AppColors.lightTabBarColor,
          border: Border.all(color: borderColor ?? AppColors.appBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon),
            const SizedBox(width: 15),
            Text(title, style: AppTextStyles.headingTextStyle()),
          ],
        ),
      ),
    );
  }

  Future<void> onReject() async {
    if (friend?.user.id == null) return;
    await onRejectTap(friend!.id);
  }
}
