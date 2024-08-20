import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_log.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class UserLog {
  final String uid;
  final int totalPosts;
  final int totalView;
  final int totalDeletePosts;
  UserLog(
      {required this.uid,
      this.totalDeletePosts = 0,
      this.totalPosts = 0,
      this.totalView = 0});

  factory UserLog.fromJson(Map<String, dynamic> json) =>
      _$UserLogFromJson(json);

  Map<String, dynamic> toJson() => _$UserLogToJson(this);
}
