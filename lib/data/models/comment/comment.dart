import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/models/comment/comment_user.dart';
import 'package:pic_share/data/models/comment/reply.dart';
part 'comment.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class Comment {
  final String? id;
  final String? content;
  final int? createdAt;
  final List<Reply> listReply;
  final CommentUser? user;
  Comment(
      {this.content,
      this.createdAt,
      this.id,
      this.listReply = const [],
      this.user});
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
