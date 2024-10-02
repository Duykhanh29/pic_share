// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConversationCWProxy {
  Conversation createdAt(String? createdAt);

  Conversation id(int? id);

  Conversation lastMessage(Message? lastMessage);

  Conversation unreadCount(int unreadCount);

  Conversation updatedAt(String? updatedAt);

  Conversation currentUser(UserSummaryModel? currentUser);

  Conversation friend(UserSummaryModel? friend);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Conversation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Conversation(...).copyWith(id: 12, name: "My name")
  /// ````
  Conversation call({
    String? createdAt,
    int? id,
    Message? lastMessage,
    int? unreadCount,
    String? updatedAt,
    UserSummaryModel? currentUser,
    UserSummaryModel? friend,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConversation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConversation.copyWith.fieldName(...)`
class _$ConversationCWProxyImpl implements _$ConversationCWProxy {
  const _$ConversationCWProxyImpl(this._value);

  final Conversation _value;

  @override
  Conversation createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  Conversation id(int? id) => this(id: id);

  @override
  Conversation lastMessage(Message? lastMessage) =>
      this(lastMessage: lastMessage);

  @override
  Conversation unreadCount(int unreadCount) => this(unreadCount: unreadCount);

  @override
  Conversation updatedAt(String? updatedAt) => this(updatedAt: updatedAt);

  @override
  Conversation currentUser(UserSummaryModel? currentUser) =>
      this(currentUser: currentUser);

  @override
  Conversation friend(UserSummaryModel? friend) => this(friend: friend);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Conversation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Conversation(...).copyWith(id: 12, name: "My name")
  /// ````
  Conversation call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? lastMessage = const $CopyWithPlaceholder(),
    Object? unreadCount = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? currentUser = const $CopyWithPlaceholder(),
    Object? friend = const $CopyWithPlaceholder(),
  }) {
    return Conversation(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      lastMessage: lastMessage == const $CopyWithPlaceholder()
          ? _value.lastMessage
          // ignore: cast_nullable_to_non_nullable
          : lastMessage as Message?,
      unreadCount:
          unreadCount == const $CopyWithPlaceholder() || unreadCount == null
              ? _value.unreadCount
              // ignore: cast_nullable_to_non_nullable
              : unreadCount as int,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String?,
      currentUser: currentUser == const $CopyWithPlaceholder()
          ? _value.currentUser
          // ignore: cast_nullable_to_non_nullable
          : currentUser as UserSummaryModel?,
      friend: friend == const $CopyWithPlaceholder()
          ? _value.friend
          // ignore: cast_nullable_to_non_nullable
          : friend as UserSummaryModel?,
    );
  }
}

extension $ConversationCopyWith on Conversation {
  /// Returns a callable class that can be used as follows: `instanceOfConversation.copyWith(...)` or like so:`instanceOfConversation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConversationCWProxy get copyWith => _$ConversationCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `Conversation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Conversation(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  Conversation copyWithNull({
    bool createdAt = false,
    bool id = false,
    bool lastMessage = false,
    bool updatedAt = false,
    bool currentUser = false,
    bool friend = false,
  }) {
    return Conversation(
      createdAt: createdAt == true ? null : this.createdAt,
      id: id == true ? null : this.id,
      lastMessage: lastMessage == true ? null : this.lastMessage,
      unreadCount: unreadCount,
      updatedAt: updatedAt == true ? null : this.updatedAt,
      currentUser: currentUser == true ? null : this.currentUser,
      friend: friend == true ? null : this.friend,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
      createdAt: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
      lastMessage: json['last_message'] == null
          ? null
          : Message.fromJson(json['last_message'] as Map<String, dynamic>),
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      updatedAt: json['updated_at'] as String?,
      currentUser: json['current_user'] == null
          ? null
          : UserSummaryModel.fromJson(
              json['current_user'] as Map<String, dynamic>),
      friend: json['friend'] == null
          ? null
          : UserSummaryModel.fromJson(json['friend'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'last_message': instance.lastMessage?.toJson(),
      'unread_count': instance.unreadCount,
      'current_user': instance.currentUser?.toJson(),
      'friend': instance.friend?.toJson(),
    };
