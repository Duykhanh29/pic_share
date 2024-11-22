// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MessageCWProxy {
  Message createdAt(String? createdAt);

  Message height(double? height);

  Message width(double? width);

  Message urlImage(String? urlImage);

  Message updatedAt(String? updatedAt);

  Message id(int? id);

  Message sender(UserSummaryModel? sender);

  Message messageType(MessageType? messageType);

  Message isRead(bool isRead);

  Message text(String? text);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Message(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Message(...).copyWith(id: 12, name: "My name")
  /// ````
  Message call({
    String? createdAt,
    double? height,
    double? width,
    String? urlImage,
    String? updatedAt,
    int? id,
    UserSummaryModel? sender,
    MessageType? messageType,
    bool? isRead,
    String? text,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMessage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMessage.copyWith.fieldName(...)`
class _$MessageCWProxyImpl implements _$MessageCWProxy {
  const _$MessageCWProxyImpl(this._value);

  final Message _value;

  @override
  Message createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  Message height(double? height) => this(height: height);

  @override
  Message width(double? width) => this(width: width);

  @override
  Message urlImage(String? urlImage) => this(urlImage: urlImage);

  @override
  Message updatedAt(String? updatedAt) => this(updatedAt: updatedAt);

  @override
  Message id(int? id) => this(id: id);

  @override
  Message sender(UserSummaryModel? sender) => this(sender: sender);

  @override
  Message messageType(MessageType? messageType) =>
      this(messageType: messageType);

  @override
  Message isRead(bool isRead) => this(isRead: isRead);

  @override
  Message text(String? text) => this(text: text);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Message(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Message(...).copyWith(id: 12, name: "My name")
  /// ````
  Message call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? height = const $CopyWithPlaceholder(),
    Object? width = const $CopyWithPlaceholder(),
    Object? urlImage = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? sender = const $CopyWithPlaceholder(),
    Object? messageType = const $CopyWithPlaceholder(),
    Object? isRead = const $CopyWithPlaceholder(),
    Object? text = const $CopyWithPlaceholder(),
  }) {
    return Message(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      height: height == const $CopyWithPlaceholder()
          ? _value.height
          // ignore: cast_nullable_to_non_nullable
          : height as double?,
      width: width == const $CopyWithPlaceholder()
          ? _value.width
          // ignore: cast_nullable_to_non_nullable
          : width as double?,
      urlImage: urlImage == const $CopyWithPlaceholder()
          ? _value.urlImage
          // ignore: cast_nullable_to_non_nullable
          : urlImage as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      sender: sender == const $CopyWithPlaceholder()
          ? _value.sender
          // ignore: cast_nullable_to_non_nullable
          : sender as UserSummaryModel?,
      messageType: messageType == const $CopyWithPlaceholder()
          ? _value.messageType
          // ignore: cast_nullable_to_non_nullable
          : messageType as MessageType?,
      isRead: isRead == const $CopyWithPlaceholder() || isRead == null
          ? _value.isRead
          // ignore: cast_nullable_to_non_nullable
          : isRead as bool,
      text: text == const $CopyWithPlaceholder()
          ? _value.text
          // ignore: cast_nullable_to_non_nullable
          : text as String?,
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
    bool createdAt = false,
    bool height = false,
    bool width = false,
    bool urlImage = false,
    bool updatedAt = false,
    bool id = false,
    bool sender = false,
    bool messageType = false,
    bool text = false,
  }) {
    return Message(
      createdAt: createdAt == true ? null : this.createdAt,
      height: height == true ? null : this.height,
      width: width == true ? null : this.width,
      urlImage: urlImage == true ? null : this.urlImage,
      updatedAt: updatedAt == true ? null : this.updatedAt,
      id: id == true ? null : this.id,
      sender: sender == true ? null : this.sender,
      messageType: messageType == true ? null : this.messageType,
      isRead: isRead,
      text: text == true ? null : this.text,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      createdAt: json['created_at'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      urlImage: json['url_image'] as String?,
      updatedAt: json['updated_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
      sender: json['sender'] == null
          ? null
          : UserSummaryModel.fromJson(json['sender'] as Map<String, dynamic>),
      messageType: json['message_type'] == null
          ? MessageType.text
          : messageTypeFromJson(json['message_type'] as String?),
      isRead: json['is_read'] == null
          ? false
          : fromJsonBool((json['is_read'] as num).toInt()),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender?.toJson(),
      'url_image': instance.urlImage,
      'text': instance.text,
      'message_type': messageTypeToJson(instance.messageType),
      'height': instance.height,
      'width': instance.width,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_read': toJsonBool(instance.isRead),
    };
