import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/enums/shared_post_type.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
part 'post_detail.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class PostDetail {
  final int? id;
  @JsonKey(name: 'user_id')
  final int? userID;
  final UserSummaryModel? user;
  @JsonKey(
      name: 'type',
      fromJson: sharedPostTypeFromJson,
      toJson: sharedPostTypeToJson)
  final SharedPostType? type;
  @JsonKey(name: 'url_image')
  final String? urlImage;
  final String? caption;
  @JsonKey(name: 'like_count')
  int likeCount;
  @JsonKey(name: 'is_deleted', fromJson: _fromJsonBool, toJson: _toJsonBool)
  bool isDeleted;
  @JsonKey(name: 'cmt_count')
  int cmtCount;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'user_views')
  final List<UserSummaryModel>? userViews;
  @JsonKey(name: 'user_likes')
  final List<UserSummaryModel> userLikes;
  final double? latitude;
  final double? longitude;
  PostDetail({
    this.caption,
    this.cmtCount = 0,
    this.id,
    this.isDeleted = false,
    this.likeCount = 0,
    this.userID,
    this.urlImage,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.type,
    this.userLikes = const [],
    this.userViews,
    this.latitude,
    this.longitude,
  });
  factory PostDetail.fromJson(Map<String, dynamic> json) =>
      _$PostDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PostDetailToJson(this);

  static bool _fromJsonBool(int value) => value == 1;
  static int _toJsonBool(bool value) => value ? 1 : 0;
}
