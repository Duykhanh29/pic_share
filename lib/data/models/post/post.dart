import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/enums/shared_post_type.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class Post {
  final int? id;
  @JsonKey(name: 'user_id')
  final int? userID;
  @JsonKey(name: 'url_image')
  final String? urlImage;
  final String? caption;
  @JsonKey(name: 'like_count')
  final int likeCount;
  @JsonKey(name: 'is_deleted', fromJson: _fromJsonBool, toJson: _toJsonBool)
  final bool isDeleted;
  @JsonKey(name: 'cmt_count')
  final int cmtCount;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(
      name: 'type',
      fromJson: sharedPostTypeFromJson,
      toJson: sharedPostTypeToJson)
  final SharedPostType? type;
  Post({
    this.caption,
    this.cmtCount = 0,
    this.id,
    this.isDeleted = false,
    this.likeCount = 0,
    this.userID,
    this.urlImage,
    this.createdAt,
    this.updatedAt,
    this.type,
  });
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
  static bool _fromJsonBool(int value) => value == 1;
  static int _toJsonBool(bool value) => value ? 1 : 0;
}
