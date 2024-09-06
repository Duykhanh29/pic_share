import 'package:pic_share/data/enums/friend_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'friend.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class Friend {
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'friend_id')
  final int friendId;
  final FriendStatus status;
  final String? avatar;
  final String? name;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  Friend({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.status,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  Map<String, dynamic> toJson() => _$FriendToJson(this);
}
