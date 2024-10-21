import 'package:pic_share/data/enums/friend_noti_type.dart';
import 'package:pic_share/data/enums/link_to_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'link_to_model.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class LinkToModel {
  @JsonKey(
      name: 'link_to_type',
      fromJson: linkToTypeFromJson,
      toJson: linkToTypeToJson)
  final LinkToType? type;
  @JsonKey(name: 'post_id')
  final int? postId;
  @JsonKey(name: 'comment_id')
  final int? commentId;
  @JsonKey(name: 'reply_id')
  final int? replyId;
  @JsonKey(
      name: 'friend_type',
      fromJson: friendNotiTypeFromJson,
      toJson: friendNotiTypeToJson)
  final FriendNotiType? friendNotiType;
  @JsonKey(name: 'notification_id')
  final int? notificationId;
  @JsonKey(name: 'conversation_id')
  final int? conversationId;

  @JsonKey(name: 'post_like_count')
  final int? likePostCount;
  @JsonKey(name: 'post_cmt_count')
  final int? likeCommentCount;
  @JsonKey(name: 'deletion_reason')
  final String? deletionReason;
  @JsonKey(name: 'post_image')
  final String? postUrl;
  @JsonKey(name: 'post_created_time')
  final String? postCreatedAt;
  @JsonKey(name: 'post_caption')
  final String? postCaption;
  LinkToModel({
    required this.type,
    this.postId,
    this.commentId,
    this.replyId,
    this.friendNotiType,
    this.conversationId,
    this.notificationId,
    this.likePostCount,
    this.likeCommentCount,
    this.deletionReason,
    this.postUrl,
    this.postCreatedAt,
    this.postCaption,
  });
  factory LinkToModel.fromJson(Map<String, dynamic> json) =>
      _$LinkToModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToModelToJson(this);
}
