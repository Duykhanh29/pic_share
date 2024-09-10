import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class Report {
  final int id;
  @JsonKey(name: 'post_id')
  final int postID;
  @JsonKey(name: 'reported_user')
  final int reportedUserID;
  @JsonKey(name: 'user_reporting')
  final int userReportingID;
  final String reason;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'created_at')
  final String createddAt;

  Report({
    required this.id,
    required this.postID,
    required this.reportedUserID,
    required this.userReportingID,
    required this.reason,
    required this.updatedAt,
    required this.createddAt,
  });
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
