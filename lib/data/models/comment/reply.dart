import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
part 'reply.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class Reply {
  @JsonKey(name: 'replyId')
  final int? id;
  final String? content;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final UserSummaryModel? user;
  Reply({
    this.content,
    this.createdAt,
    this.id,
    this.user,
    this.updatedAt,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyToJson(this);
}
