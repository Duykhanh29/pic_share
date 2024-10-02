import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:pic_share/data/models/conversation/message.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
part 'conversation.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
class Conversation {
  final int? id;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'last_message')
  Message? lastMessage;
  @JsonKey(name: 'unread_count')
  int unreadCount;
  @JsonKey(name: 'current_user')
  UserSummaryModel? currentUser;
  @JsonKey(name: 'friend')
  UserSummaryModel? friend;
  Conversation({
    this.createdAt,
    this.id,
    this.lastMessage,
    this.unreadCount = 0,
    this.updatedAt,
    this.currentUser,
    this.friend,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
