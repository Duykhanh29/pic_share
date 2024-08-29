// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConversationCWProxy {
  Conversation createdAt(int? createdAt);

  Conversation id(String? id);

  Conversation lastMessage(Message? lastMessage);

  Conversation messages(List<Message> messages);

  Conversation participants(List<String> participants);

  Conversation updatedAt(int? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Conversation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Conversation(...).copyWith(id: 12, name: "My name")
  /// ````
  Conversation call({
    int? createdAt,
    String? id,
    Message? lastMessage,
    List<Message>? messages,
    List<String>? participants,
    int? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConversation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConversation.copyWith.fieldName(...)`
class _$ConversationCWProxyImpl implements _$ConversationCWProxy {
  const _$ConversationCWProxyImpl(this._value);

  final Conversation _value;

  @override
  Conversation createdAt(int? createdAt) => this(createdAt: createdAt);

  @override
  Conversation id(String? id) => this(id: id);

  @override
  Conversation lastMessage(Message? lastMessage) =>
      this(lastMessage: lastMessage);

  @override
  Conversation messages(List<Message> messages) => this(messages: messages);

  @override
  Conversation participants(List<String> participants) =>
      this(participants: participants);

  @override
  Conversation updatedAt(int? updatedAt) => this(updatedAt: updatedAt);

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
    Object? messages = const $CopyWithPlaceholder(),
    Object? participants = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Conversation(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as int?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      lastMessage: lastMessage == const $CopyWithPlaceholder()
          ? _value.lastMessage
          // ignore: cast_nullable_to_non_nullable
          : lastMessage as Message?,
      messages: messages == const $CopyWithPlaceholder() || messages == null
          ? _value.messages
          // ignore: cast_nullable_to_non_nullable
          : messages as List<Message>,
      participants:
          participants == const $CopyWithPlaceholder() || participants == null
              ? _value.participants
              // ignore: cast_nullable_to_non_nullable
              : participants as List<String>,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as int?,
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
  }) {
    return Conversation(
      createdAt: createdAt == true ? null : this.createdAt,
      id: id == true ? null : this.id,
      lastMessage: lastMessage == true ? null : this.lastMessage,
      messages: messages,
      participants: participants,
      updatedAt: updatedAt == true ? null : this.updatedAt,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
      createdAt: (json['createdAt'] as num?)?.toInt(),
      id: json['id'] as String?,
      lastMessage: json['lastMessage'] == null
          ? null
          : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      participants: (json['participants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      updatedAt: (json['updatedAt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'participants': instance.participants,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'lastMessage': instance.lastMessage?.toJson(),
    };
