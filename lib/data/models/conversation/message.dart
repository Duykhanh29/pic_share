import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:pic_share/app/extensions/json_extension.dart';
import 'package:pic_share/data/enums/message_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class Message {
  final int? id;
  final UserSummaryModel? sender;
  @JsonKey(name: "url_image")
  final String? urlImage;
  final String? text;
  @JsonKey(
      name: 'message_type',
      fromJson: messageTypeFromJson,
      toJson: messageTypeToJson)
  final MessageType? messageType;
  final double? height;
  final double? width;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'is_read', fromJson: fromJsonBool, toJson: toJsonBool)
  bool isRead;
  Message({
    this.createdAt,
    this.height,
    this.width,
    this.urlImage,
    this.updatedAt,
    this.id,
    this.sender,
    this.messageType = MessageType.text,
    this.isRead = false,
    this.text,
  });
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
