// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationDataCWProxy {
  NotificationData clickAction(String? clickAction);

  NotificationData commentId(String? commentId);

  NotificationData friendType(FriendNotiType? friendType);

  NotificationData postId(String? postId);

  NotificationData replyId(String? replyId);

  NotificationData status(String? status);

  NotificationData type(LinkToType? type);

  NotificationData conversationId(String? conversationId);

  NotificationData notificationId(String? notificationId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationData(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationData call({
    String? clickAction,
    String? commentId,
    FriendNotiType? friendType,
    String? postId,
    String? replyId,
    String? status,
    LinkToType? type,
    String? conversationId,
    String? notificationId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationData.copyWith.fieldName(...)`
class _$NotificationDataCWProxyImpl implements _$NotificationDataCWProxy {
  const _$NotificationDataCWProxyImpl(this._value);

  final NotificationData _value;

  @override
  NotificationData clickAction(String? clickAction) =>
      this(clickAction: clickAction);

  @override
  NotificationData commentId(String? commentId) => this(commentId: commentId);

  @override
  NotificationData friendType(FriendNotiType? friendType) =>
      this(friendType: friendType);

  @override
  NotificationData postId(String? postId) => this(postId: postId);

  @override
  NotificationData replyId(String? replyId) => this(replyId: replyId);

  @override
  NotificationData status(String? status) => this(status: status);

  @override
  NotificationData type(LinkToType? type) => this(type: type);

  @override
  NotificationData conversationId(String? conversationId) =>
      this(conversationId: conversationId);

  @override
  NotificationData notificationId(String? notificationId) =>
      this(notificationId: notificationId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationData(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationData call({
    Object? clickAction = const $CopyWithPlaceholder(),
    Object? commentId = const $CopyWithPlaceholder(),
    Object? friendType = const $CopyWithPlaceholder(),
    Object? postId = const $CopyWithPlaceholder(),
    Object? replyId = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? conversationId = const $CopyWithPlaceholder(),
    Object? notificationId = const $CopyWithPlaceholder(),
  }) {
    return NotificationData(
      clickAction: clickAction == const $CopyWithPlaceholder()
          ? _value.clickAction
          // ignore: cast_nullable_to_non_nullable
          : clickAction as String?,
      commentId: commentId == const $CopyWithPlaceholder()
          ? _value.commentId
          // ignore: cast_nullable_to_non_nullable
          : commentId as String?,
      friendType: friendType == const $CopyWithPlaceholder()
          ? _value.friendType
          // ignore: cast_nullable_to_non_nullable
          : friendType as FriendNotiType?,
      postId: postId == const $CopyWithPlaceholder()
          ? _value.postId
          // ignore: cast_nullable_to_non_nullable
          : postId as String?,
      replyId: replyId == const $CopyWithPlaceholder()
          ? _value.replyId
          // ignore: cast_nullable_to_non_nullable
          : replyId as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as LinkToType?,
      conversationId: conversationId == const $CopyWithPlaceholder()
          ? _value.conversationId
          // ignore: cast_nullable_to_non_nullable
          : conversationId as String?,
      notificationId: notificationId == const $CopyWithPlaceholder()
          ? _value.notificationId
          // ignore: cast_nullable_to_non_nullable
          : notificationId as String?,
    );
  }
}

extension $NotificationDataCopyWith on NotificationData {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationData.copyWith(...)` or like so:`instanceOfNotificationData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationDataCWProxy get copyWith => _$NotificationDataCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `NotificationData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationData(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  NotificationData copyWithNull({
    bool clickAction = false,
    bool commentId = false,
    bool friendType = false,
    bool postId = false,
    bool replyId = false,
    bool status = false,
    bool type = false,
    bool conversationId = false,
    bool notificationId = false,
  }) {
    return NotificationData(
      clickAction: clickAction == true ? null : this.clickAction,
      commentId: commentId == true ? null : this.commentId,
      friendType: friendType == true ? null : this.friendType,
      postId: postId == true ? null : this.postId,
      replyId: replyId == true ? null : this.replyId,
      status: status == true ? null : this.status,
      type: type == true ? null : this.type,
      conversationId: conversationId == true ? null : this.conversationId,
      notificationId: notificationId == true ? null : this.notificationId,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    NotificationData(
      clickAction: json['click_action'] as String?,
      commentId: json['comment_id'] as String?,
      friendType: friendNotiTypeFromJson(json['friend_type'] as String?),
      postId: json['post_id'] as String?,
      replyId: json['reply_id'] as String?,
      status: json['status'] as String?,
      type: linkToTypeFromJson(json['type'] as String?),
      conversationId: json['conversation_id'] as String?,
      notificationId: json['notification_id'] as String?,
    );

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'reply_id': instance.replyId,
      'post_id': instance.postId,
      'friend_type': friendNotiTypeToJson(instance.friendType),
      'type': linkToTypeToJson(instance.type),
      'click_action': instance.clickAction,
      'comment_id': instance.commentId,
      'status': instance.status,
      'notification_id': instance.notificationId,
      'conversation_id': instance.conversationId,
    };
