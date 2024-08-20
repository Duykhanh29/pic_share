import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:pic_share/data/enums/message_type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class Message {
  final String? id;
  final String? sennderId;
  final MessageType messageType;
  final MessageContent? messageContent;
  final int? time;
  Message({
    this.id,
    this.messageContent,
    this.messageType = MessageType.text,
    this.sennderId,
    this.time,
  });
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
@CopyWith(copyWithNull: true)
class MessageContent {
  final String? text;
  final String? urlPath;
  final double? height;
  final double? width;
  MessageContent({this.height, this.text, this.urlPath, this.width});
  factory MessageContent.fromJson(Map<String, dynamic> json) =>
      _$MessageContentFromJson(json);

  Map<String, dynamic> toJson() => _$MessageContentToJson(this);
}
