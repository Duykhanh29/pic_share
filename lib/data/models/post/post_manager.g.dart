// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_manager.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PostManagerCWProxy {
  PostManager caption(String? caption);

  PostManager id(String? id);

  PostManager image(String? image);

  PostManager time(int? time);

  PostManager type(int? type);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PostManager(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PostManager(...).copyWith(id: 12, name: "My name")
  /// ````
  PostManager call({
    String? caption,
    String? id,
    String? image,
    int? time,
    int? type,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPostManager.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPostManager.copyWith.fieldName(...)`
class _$PostManagerCWProxyImpl implements _$PostManagerCWProxy {
  const _$PostManagerCWProxyImpl(this._value);

  final PostManager _value;

  @override
  PostManager caption(String? caption) => this(caption: caption);

  @override
  PostManager id(String? id) => this(id: id);

  @override
  PostManager image(String? image) => this(image: image);

  @override
  PostManager time(int? time) => this(time: time);

  @override
  PostManager type(int? type) => this(type: type);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PostManager(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PostManager(...).copyWith(id: 12, name: "My name")
  /// ````
  PostManager call({
    Object? caption = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return PostManager(
      caption: caption == const $CopyWithPlaceholder()
          ? _value.caption
          // ignore: cast_nullable_to_non_nullable
          : caption as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
      time: time == const $CopyWithPlaceholder()
          ? _value.time
          // ignore: cast_nullable_to_non_nullable
          : time as int?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as int?,
    );
  }
}

extension $PostManagerCopyWith on PostManager {
  /// Returns a callable class that can be used as follows: `instanceOfPostManager.copyWith(...)` or like so:`instanceOfPostManager.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PostManagerCWProxy get copyWith => _$PostManagerCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `PostManager(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PostManager(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  PostManager copyWithNull({
    bool caption = false,
    bool id = false,
    bool image = false,
    bool time = false,
    bool type = false,
  }) {
    return PostManager(
      caption: caption == true ? null : this.caption,
      id: id == true ? null : this.id,
      image: image == true ? null : this.image,
      time: time == true ? null : this.time,
      type: type == true ? null : this.type,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostManager _$PostManagerFromJson(Map<String, dynamic> json) => PostManager(
      caption: json['caption'] as String?,
      id: json['id'] as String?,
      image: json['image'] as String?,
      time: (json['time'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PostManagerToJson(PostManager instance) =>
    <String, dynamic>{
      'id': instance.id,
      'caption': instance.caption,
      'image': instance.image,
      'type': instance.type,
      'time': instance.time,
    };
