import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/models/comment/reply.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
part 'comment.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class Comment {
  @JsonKey(name: 'commentId')
  final int? id;
  final String? content;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'listReply')
  List<Reply> listReply;
  final UserSummaryModel? user;
  Comment({
    this.content,
    this.createdAt,
    this.id,
    this.listReply = const [],
    this.user,
    this.updatedAt,
  });
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
