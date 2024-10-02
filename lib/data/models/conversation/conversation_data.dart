import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/models/conversation/conversation.dart';
part 'conversation_data.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class ConversationData {
  List<Conversation> conversations;
  @JsonKey(name: 'unread_chats')
  int unreadCount;

  ConversationData({
    this.conversations = const [],
    this.unreadCount = 0,
  });
  factory ConversationData.fromJson(Map<String, dynamic> json) =>
      _$ConversationDataFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationDataToJson(this);
}
