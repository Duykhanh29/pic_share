// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConversationDataCWProxy {
  ConversationData conversations(List<Conversation> conversations);

  ConversationData unreadCount(int unreadCount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConversationData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConversationData(...).copyWith(id: 12, name: "My name")
  /// ````
  ConversationData call({
    List<Conversation>? conversations,
    int? unreadCount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConversationData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConversationData.copyWith.fieldName(...)`
class _$ConversationDataCWProxyImpl implements _$ConversationDataCWProxy {
  const _$ConversationDataCWProxyImpl(this._value);

  final ConversationData _value;

  @override
  ConversationData conversations(List<Conversation> conversations) =>
      this(conversations: conversations);

  @override
  ConversationData unreadCount(int unreadCount) =>
      this(unreadCount: unreadCount);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConversationData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConversationData(...).copyWith(id: 12, name: "My name")
  /// ````
  ConversationData call({
    Object? conversations = const $CopyWithPlaceholder(),
    Object? unreadCount = const $CopyWithPlaceholder(),
  }) {
    return ConversationData(
      conversations:
          conversations == const $CopyWithPlaceholder() || conversations == null
              ? _value.conversations
              // ignore: cast_nullable_to_non_nullable
              : conversations as List<Conversation>,
      unreadCount:
          unreadCount == const $CopyWithPlaceholder() || unreadCount == null
              ? _value.unreadCount
              // ignore: cast_nullable_to_non_nullable
              : unreadCount as int,
    );
  }
}

extension $ConversationDataCopyWith on ConversationData {
  /// Returns a callable class that can be used as follows: `instanceOfConversationData.copyWith(...)` or like so:`instanceOfConversationData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConversationDataCWProxy get copyWith => _$ConversationDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationData _$ConversationDataFromJson(Map<String, dynamic> json) =>
    ConversationData(
      conversations: (json['conversations'] as List<dynamic>?)
              ?.map((e) => Conversation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      unreadCount: (json['unread_chats'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ConversationDataToJson(ConversationData instance) =>
    <String, dynamic>{
      'conversations': instance.conversations.map((e) => e.toJson()).toList(),
      'unread_chats': instance.unreadCount,
    };
