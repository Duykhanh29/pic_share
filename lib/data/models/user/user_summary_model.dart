import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_summary_model.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class UserSummaryModel {
  final int? id;
  final String? name;
  @JsonKey(name: 'avatar')
  final String? urlAvatar;
  @JsonKey(name: 'user_code')
  final String? userCode;
  UserSummaryModel({this.id, this.name, this.urlAvatar, this.userCode});

  factory UserSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserSummaryModelToJson(this);
}
