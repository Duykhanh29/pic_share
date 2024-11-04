import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'suggested_friend.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class SuggestedFriend {
  final int score;
  final UserSummaryModel user;

  SuggestedFriend({required this.score, required this.user});

  factory SuggestedFriend.fromJson(Map<String, dynamic> json) =>
      _$SuggestedFriendFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestedFriendToJson(this);
}
