// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationCWProxy {
  Notification content(String? content);

  Notification createdAt(int? createdAt);

  Notification id(String? id);

  Notification isSeen(bool isSeen);

  Notification notificationType(NotificationType notificationType);

  Notification senderID(String? senderID);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Notification(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Notification(...).copyWith(id: 12, name: "My name")
  /// ````
  Notification call({
    String? content,
    int? createdAt,
    String? id,
    bool? isSeen,
    NotificationType? notificationType,
    String? senderID,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotification.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotification.copyWith.fieldName(...)`
class _$NotificationCWProxyImpl implements _$NotificationCWProxy {
  const _$NotificationCWProxyImpl(this._value);

  final Notification _value;

  @override
  Notification content(String? content) => this(content: content);

  @override
  Notification createdAt(int? createdAt) => this(createdAt: createdAt);

  @override
  Notification id(String? id) => this(id: id);

  @override
  Notification isSeen(bool isSeen) => this(isSeen: isSeen);

  @override
  Notification notificationType(NotificationType notificationType) =>
      this(notificationType: notificationType);

  @override
  Notification senderID(String? senderID) => this(senderID: senderID);

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
    Object? senderID = const $CopyWithPlaceholder(),
  }) {
    return Notification(
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as int?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      isSeen: isSeen == const $CopyWithPlaceholder() || isSeen == null
          ? _value.isSeen
          // ignore: cast_nullable_to_non_nullable
          : isSeen as bool,
      notificationType: notificationType == const $CopyWithPlaceholder() ||
              notificationType == null
          ? _value.notificationType
          // ignore: cast_nullable_to_non_nullable
          : notificationType as NotificationType,
      senderID: senderID == const $CopyWithPlaceholder()
          ? _value.senderID
          // ignore: cast_nullable_to_non_nullable
          : senderID as String?,
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
    bool senderID = false,
  }) {
    return Notification(
      content: content == true ? null : this.content,
      createdAt: createdAt == true ? null : this.createdAt,
      id: id == true ? null : this.id,
      isSeen: isSeen,
      notificationType: notificationType,
      senderID: senderID == true ? null : this.senderID,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      content: json['content'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      id: json['id'] as String?,
      isSeen: json['isSeen'] as bool? ?? false,
      notificationType: $enumDecodeNullable(
              _$NotificationTypeEnumMap, json['notificationType']) ??
          NotificationType.user,
      senderID: json['senderID'] as String?,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'isSeen': instance.isSeen,
      'senderID': instance.senderID,
      'createdAt': instance.createdAt,
      'notificationType': _$NotificationTypeEnumMap[instance.notificationType]!,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.user: 'user',
  NotificationType.system: 'system',
};
