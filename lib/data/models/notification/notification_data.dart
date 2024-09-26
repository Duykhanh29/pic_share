import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/enums/friend_noti_type.dart';
import 'package:pic_share/data/enums/link_to_type.dart';

part 'notification_data.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class NotificationData {
  @JsonKey(name: 'reply_id')
  final String? replyId;
  @JsonKey(name: 'post_id')
  final String? postId;
  @JsonKey(
      name: 'friend_type',
      fromJson: friendNotiTypeFromJson,
      toJson: friendNotiTypeToJson)
  final FriendNotiType? friendType;
  @JsonKey(name: 'type', fromJson: linkToTypeFromJson, toJson: linkToTypeToJson)
  final LinkToType? type;
  @JsonKey(name: 'click_action')
  final String? clickAction;
  @JsonKey(name: 'comment_id')
  final String? commentId;
  final String? status;
  NotificationData({
    this.clickAction,
    this.commentId,
    this.friendType,
    this.postId,
    this.replyId,
    this.status,
    this.type,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}
