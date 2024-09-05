// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FriendCWProxy {
  Friend id(int id);

  Friend userId(int userId);

  Friend friendId(int friendId);

  Friend status(FriendStatus status);

  Friend avatar(String? avatar);

  Friend createdAt(String? createdAt);

  Friend updatedAt(String? updatedAt);

  Friend name(String? name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Friend(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Friend(...).copyWith(id: 12, name: "My name")
  /// ````
  Friend call({
    int? id,
    int? userId,
    int? friendId,
    FriendStatus? status,
    String? avatar,
    String? createdAt,
    String? updatedAt,
    String? name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFriend.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFriend.copyWith.fieldName(...)`
class _$FriendCWProxyImpl implements _$FriendCWProxy {
  const _$FriendCWProxyImpl(this._value);

  final Friend _value;

  @override
  Friend id(int id) => this(id: id);

  @override
  Friend userId(int userId) => this(userId: userId);

  @override
  Friend friendId(int friendId) => this(friendId: friendId);

  @override
  Friend status(FriendStatus status) => this(status: status);

  @override
  Friend avatar(String? avatar) => this(avatar: avatar);

  @override
  Friend createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  Friend updatedAt(String? updatedAt) => this(updatedAt: updatedAt);

  @override
  Friend name(String? name) => this(name: name);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Friend(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Friend(...).copyWith(id: 12, name: "My name")
  /// ````
  Friend call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? friendId = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? avatar = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return Friend(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as int,
      friendId: friendId == const $CopyWithPlaceholder() || friendId == null
          ? _value.friendId
          // ignore: cast_nullable_to_non_nullable
          : friendId as int,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as FriendStatus,
      avatar: avatar == const $CopyWithPlaceholder()
          ? _value.avatar
          // ignore: cast_nullable_to_non_nullable
          : avatar as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
    );
  }
}

extension $FriendCopyWith on Friend {
  /// Returns a callable class that can be used as follows: `instanceOfFriend.copyWith(...)` or like so:`instanceOfFriend.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FriendCWProxy get copyWith => _$FriendCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `Friend(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Friend(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  Friend copyWithNull({
    bool avatar = false,
    bool createdAt = false,
    bool updatedAt = false,
    bool name = false,
  }) {
    return Friend(
      id: id,
      userId: userId,
      friendId: friendId,
      status: status,
      avatar: avatar == true ? null : this.avatar,
      createdAt: createdAt == true ? null : this.createdAt,
      updatedAt: updatedAt == true ? null : this.updatedAt,
      name: name == true ? null : this.name,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) => Friend(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      friendId: (json['friend_id'] as num).toInt(),
      status: $enumDecode(_$FriendStatusEnumMap, json['status']),
      avatar: json['avatar'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'friend_id': instance.friendId,
      'status': _$FriendStatusEnumMap[instance.status]!,
      'avatar': instance.avatar,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

const _$FriendStatusEnumMap = {
  FriendStatus.friend: 'friend',
  FriendStatus.pending: 'pending',
};
