// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

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
