import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/models/comment/comment_user.dart';
part 'reply.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class Reply {
  final String? id;
  final String? content;
  final int? createdAt;
  final CommentUser? user;
  Reply({this.content, this.createdAt, this.id, this.user});

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyToJson(this);
}
