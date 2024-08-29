// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MessageCWProxy {
  Message id(String? id);

  Message messageContent(MessageContent? messageContent);

  Message messageType(MessageType messageType);

  Message sennderId(String? sennderId);

  Message time(int? time);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Message(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Message(...).copyWith(id: 12, name: "My name")
  /// ````
  Message call({
    String? id,
    MessageContent? messageContent,
    MessageType? messageType,
    String? sennderId,
    int? time,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMessage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMessage.copyWith.fieldName(...)`
class _$MessageCWProxyImpl implements _$MessageCWProxy {
  const _$MessageCWProxyImpl(this._value);

  final Message _value;

  @override
  Message id(String? id) => this(id: id);

  @override
  Message messageContent(MessageContent? messageContent) =>
      this(messageContent: messageContent);

  @override
  Message messageType(MessageType messageType) =>
      this(messageType: messageType);

  @override
  Message sennderId(String? sennderId) => this(sennderId: sennderId);

  @override
  Message time(int? time) => this(time: time);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Message(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Message(...).copyWith(id: 12, name: "My name")
  /// ````
  Message call({
    Object? id = const $CopyWithPlaceholder(),
    Object? messageContent = const $CopyWithPlaceholder(),
    Object? messageType = const $CopyWithPlaceholder(),
    Object? sennderId = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
  }) {
    return Message(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      messageContent: messageContent == const $CopyWithPlaceholder()
          ? _value.messageContent
          // ignore: cast_nullable_to_non_nullable
          : messageContent as MessageContent?,
      messageType:
          messageType == const $CopyWithPlaceholder() || messageType == null
              ? _value.messageType
              // ignore: cast_nullable_to_non_nullable
              : messageType as MessageType,
      sennderId: sennderId == const $CopyWithPlaceholder()
          ? _value.sennderId
          // ignore: cast_nullable_to_non_nullable
          : sennderId as String?,
      time: time == const $CopyWithPlaceholder()
          ? _value.time
          // ignore: cast_nullable_to_non_nullable
          : time as int?,
    );
  }
}

extension $MessageCopyWith on Message {
  /// Returns a callable class that can be used as follows: `instanceOfMessage.copyWith(...)` or like so:`instanceOfMessage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MessageCWProxy get copyWith => _$MessageCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `Message(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Message(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  Message copyWithNull({
    bool id = false,
    bool messageContent = false,
    bool sennderId = false,
    bool time = false,
  }) {
    return Message(
      id: id == true ? null : this.id,
      messageContent: messageContent == true ? null : this.messageContent,
      messageType: messageType,
      sennderId: sennderId == true ? null : this.sennderId,
      time: time == true ? null : this.time,
    );
  }
}

abstract class _$MessageContentCWProxy {
  MessageContent height(double? height);

  MessageContent text(String? text);

  MessageContent urlPath(String? urlPath);

  MessageContent width(double? width);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MessageContent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MessageContent(...).copyWith(id: 12, name: "My name")
  /// ````
  MessageContent call({
    double? height,
    String? text,
    String? urlPath,
    double? width,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMessageContent.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMessageContent.copyWith.fieldName(...)`
class _$MessageContentCWProxyImpl implements _$MessageContentCWProxy {
  const _$MessageContentCWProxyImpl(this._value);

  final MessageContent _value;

  @override
  MessageContent height(double? height) => this(height: height);

  @override
  MessageContent text(String? text) => this(text: text);

  @override
  MessageContent urlPath(String? urlPath) => this(urlPath: urlPath);

  @override
  MessageContent width(double? width) => this(width: width);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MessageContent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MessageContent(...).copyWith(id: 12, name: "My name")
  /// ````
  MessageContent call({
    Object? height = const $CopyWithPlaceholder(),
    Object? text = const $CopyWithPlaceholder(),
    Object? urlPath = const $CopyWithPlaceholder(),
    Object? width = const $CopyWithPlaceholder(),
  }) {
    return MessageContent(
      height: height == const $CopyWithPlaceholder()
          ? _value.height
          // ignore: cast_nullable_to_non_nullable
          : height as double?,
      text: text == const $CopyWithPlaceholder()
          ? _value.text
          // ignore: cast_nullable_to_non_nullable
          : text as String?,
      urlPath: urlPath == const $CopyWithPlaceholder()
          ? _value.urlPath
          // ignore: cast_nullable_to_non_nullable
          : urlPath as String?,
      width: width == const $CopyWithPlaceholder()
          ? _value.width
          // ignore: cast_nullable_to_non_nullable
          : width as double?,
    );
  }
}

extension $MessageContentCopyWith on MessageContent {
  /// Returns a callable class that can be used as follows: `instanceOfMessageContent.copyWith(...)` or like so:`instanceOfMessageContent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MessageContentCWProxy get copyWith => _$MessageContentCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `MessageContent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MessageContent(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  MessageContent copyWithNull({
    bool height = false,
    bool text = false,
    bool urlPath = false,
    bool width = false,
  }) {
    return MessageContent(
      height: height == true ? null : this.height,
      text: text == true ? null : this.text,
      urlPath: urlPath == true ? null : this.urlPath,
      width: width == true ? null : this.width,
    );
  }
}

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
      time: (json['time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'sennderId': instance.sennderId,
      'messageType': _$MessageTypeEnumMap[instance.messageType]!,
      'messageContent': instance.messageContent?.toJson(),
      'time': instance.time,
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
