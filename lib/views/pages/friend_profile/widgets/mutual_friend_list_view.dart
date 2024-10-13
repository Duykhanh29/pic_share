import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/views/pages/friend_profile/widgets/mutual_friend_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MuatualFriendListView extends StatelessWidget {
  const MuatualFriendListView({
    super.key,
    required this.mutualFriends,
    required this.isLoading,
    required this.onTap,
  });
  final List<UserSummaryModel> mutualFriends;
  final bool isLoading;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return isLoading
        ? ShimmerHelper().buildListViewShimmer()
        : (mutualFriends.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final friend = mutualFriends[index];
                    return MutualFriendCard(
                      onTap: () {
                        onTap(index);
                      },
                      friend: friend,
                      key: UniqueKey(),
                    );
                  },
                  itemCount: mutualFriends.length,
                ),
              )
            : Center(
                child: Text(
                  t.noMutualFriend,
                  style: AppTextStyles.commonTextStyle()
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ));
  }
}
