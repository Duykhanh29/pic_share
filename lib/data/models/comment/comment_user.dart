import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_user.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class CommentUser {
  final String? userName;
  final String? uid;
  final String? urlAvatar;
  CommentUser({this.uid, this.urlAvatar, this.userName});
  factory CommentUser.fromJson(Map<String, dynamic> json) =>
      _$CommentUserFromJson(json);

  Map<String, dynamic> toJson() => _$CommentUserToJson(this);
}
