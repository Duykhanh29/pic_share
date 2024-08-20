import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:pic_share/data/models/conversation/message.dart';
import 'package:json_annotation/json_annotation.dart';
part 'conversation.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class Conversation {
  final String? id;
  final int? createdAt;
  final int? updatedAt;
  List<String> participants;
  List<Message> messages;
  Message? lastMessage;
  Conversation(
      {this.createdAt,
      this.id,
      this.lastMessage,
      this.messages = const [],
      this.participants = const [],
      this.updatedAt});

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
