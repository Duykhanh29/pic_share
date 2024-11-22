// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationCWProxy {
  Notification content(String? content);

  Notification createdAt(String? createdAt);

  Notification id(int? id);

  Notification isSeen(bool isSeen);

  Notification notificationType(NotificationType notificationType);

  Notification user(UserSummaryModel? user);

  Notification linkTo(LinkToModel? linkTo);

  Notification sender(UserSummaryModel? sender);

  Notification title(String? title);

  Notification updatedAt(String? updatedAt);

  Notification isRead(bool isRead);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Notification(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Notification(...).copyWith(id: 12, name: "My name")
  /// ````
  Notification call({
    String? content,
    String? createdAt,
    int? id,
    bool? isSeen,
    NotificationType? notificationType,
    UserSummaryModel? user,
    LinkToModel? linkTo,
    UserSummaryModel? sender,
    String? title,
    String? updatedAt,
    bool? isRead,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotification.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotification.copyWith.fieldName(...)`
class _$NotificationCWProxyImpl implements _$NotificationCWProxy {
  const _$NotificationCWProxyImpl(this._value);

  final Notification _value;

  @override
  Notification content(String? content) => this(content: content);

  @override
  Notification createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  Notification id(int? id) => this(id: id);

  @override
  Notification isSeen(bool isSeen) => this(isSeen: isSeen);

  @override
  Notification notificationType(NotificationType notificationType) =>
      this(notificationType: notificationType);

  @override
  Notification user(UserSummaryModel? user) => this(user: user);

  @override
  Notification linkTo(LinkToModel? linkTo) => this(linkTo: linkTo);

  @override
  Notification sender(UserSummaryModel? sender) => this(sender: sender);

  @override
  Notification title(String? title) => this(title: title);

  @override
  Notification updatedAt(String? updatedAt) => this(updatedAt: updatedAt);

  @override
  Notification isRead(bool isRead) => this(isRead: isRead);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Notification(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Notification(...).copyWith(id: 12, name: "My name")
  /// ````
  Notification call({
    Object? content = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isSeen = const $CopyWithPlaceholder(),
    Object? notificationType = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? linkTo = const $CopyWithPlaceholder(),
    Object? sender = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? isRead = const $CopyWithPlaceholder(),
  }) {
    return Notification(
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      isSeen: isSeen == const $CopyWithPlaceholder() || isSeen == null
          ? _value.isSeen
          // ignore: cast_nullable_to_non_nullable
          : isSeen as bool,
      notificationType: notificationType == const $CopyWithPlaceholder() ||
              notificationType == null
          ? _value.notificationType
          // ignore: cast_nullable_to_non_nullable
          : notificationType as NotificationType,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as UserSummaryModel?,
      linkTo: linkTo == const $CopyWithPlaceholder()
          ? _value.linkTo
          // ignore: cast_nullable_to_non_nullable
          : linkTo as LinkToModel?,
      sender: sender == const $CopyWithPlaceholder()
          ? _value.sender
          // ignore: cast_nullable_to_non_nullable
          : sender as UserSummaryModel?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String?,
      isRead: isRead == const $CopyWithPlaceholder() || isRead == null
          ? _value.isRead
          // ignore: cast_nullable_to_non_nullable
          : isRead as bool,
    );
  }
}

extension $NotificationCopyWith on Notification {
  /// Returns a callable class that can be used as follows: `instanceOfNotification.copyWith(...)` or like so:`instanceOfNotification.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationCWProxy get copyWith => _$NotificationCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `Notification(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Notification(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  Notification copyWithNull({
    bool content = false,
    bool createdAt = false,
    bool id = false,
    bool user = false,
    bool linkTo = false,
    bool sender = false,
    bool title = false,
    bool updatedAt = false,
  }) {
    return Notification(
      content: content == true ? null : this.content,
      createdAt: createdAt == true ? null : this.createdAt,
      id: id == true ? null : this.id,
      isSeen: isSeen,
      notificationType: notificationType,
      user: user == true ? null : this.user,
      linkTo: linkTo == true ? null : this.linkTo,
      sender: sender == true ? null : this.sender,
      title: title == true ? null : this.title,
      updatedAt: updatedAt == true ? null : this.updatedAt,
      isRead: isRead,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      content: json['content'] as String?,
      createdAt: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
      isSeen: json['is_seen'] == null
          ? false
          : fromJsonBool((json['is_seen'] as num).toInt()),
      notificationType: $enumDecodeNullable(
              _$NotificationTypeEnumMap, json['notification_type']) ??
          NotificationType.user,
      user: json['user'] == null
          ? null
          : UserSummaryModel.fromJson(json['user'] as Map<String, dynamic>),
      linkTo: json['link_to'] == null
          ? null
          : LinkToModel.fromJson(json['link_to'] as Map<String, dynamic>),
      sender: json['sender'] == null
          ? null
          : UserSummaryModel.fromJson(json['sender'] as Map<String, dynamic>),
      title: json['title'] as String?,
      updatedAt: json['updated_at'] as String?,
      isRead: json['is_read'] == null
          ? false
          : fromJsonBool((json['is_read'] as num).toInt()),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'sender': instance.sender,
      'content': instance.content,
      'title': instance.title,
      'is_seen': toJsonBool(instance.isSeen),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'notification_type':
          _$NotificationTypeEnumMap[instance.notificationType]!,
      'link_to': instance.linkTo,
      'is_read': toJsonBool(instance.isRead),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.user: 'user',
  NotificationType.system: 'system',
};
