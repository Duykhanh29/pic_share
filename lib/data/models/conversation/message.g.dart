// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String?,
      messageContent: json['messageContent'] == null
          ? null
          : MessageContent.fromJson(
              json['messageContent'] as Map<String, dynamic>),
      messageType:
          $enumDecodeNullable(_$MessageTypeEnumMap, json['messageType']) ??
              MessageType.text,
      sennderId: json['sennderId'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'sennderId': instance.sennderId,
      'messageType': _$MessageTypeEnumMap[instance.messageType]!,
      'messageContent': instance.messageContent,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
};

MessageContent _$MessageContentFromJson(Map<String, dynamic> json) =>
    MessageContent(
      height: (json['height'] as num?)?.toDouble(),
      text: json['text'] as String?,
      urlPath: json['urlPath'] as String?,
      width: (json['width'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MessageContentToJson(MessageContent instance) =>
    <String, dynamic>{
      'text': instance.text,
      'urlPath': instance.urlPath,
      'height': instance.height,
      'width': instance.width,
    };
