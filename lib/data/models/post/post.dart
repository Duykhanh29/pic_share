import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/models/comment/comment.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class Post {
  final String? id;
  final String? uid;
  final String? urlImage;
  final String? caption;
  final int likeCount;
  final bool isDeleted;
  final int cmtCount;
  final List<Comment> listComment;
  Post(
      {this.caption,
      this.cmtCount = 0,
      this.id,
      this.isDeleted = false,
      this.likeCount = 0,
      this.listComment = const [],
      this.uid,
      this.urlImage});
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
