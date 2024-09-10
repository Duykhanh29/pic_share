import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_log.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class UserLog {
  final int id;
  @JsonKey(name: "user_id")
  final int userId;
  @JsonKey(name: "total_post")
  final int totalPosts;
  @JsonKey(name: "total_view")
  final int totalView;
  @JsonKey(name: "total_deleted")
  final int totalDeletePosts;
  @JsonKey(name: "total_like")
  final int totalLikes;
  UserLog({
    required this.id,
    required this.userId,
    this.totalDeletePosts = 0,
    this.totalPosts = 0,
    this.totalView = 0,
    this.totalLikes = 0,
  });

  factory UserLog.fromJson(Map<String, dynamic> json) =>
      _$UserLogFromJson(json);

  Map<String, dynamic> toJson() => _$UserLogToJson(this);
}
