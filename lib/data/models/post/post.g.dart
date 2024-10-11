// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PostCWProxy {
  Post caption(String? caption);

  Post cmtCount(int cmtCount);

  Post id(int? id);

  Post isDeleted(bool isDeleted);

  Post likeCount(int likeCount);

  Post userID(int? userID);

  Post urlImage(String? urlImage);

  Post createdAt(String? createdAt);

  Post updatedAt(String? updatedAt);

  Post type(SharedPostType? type);

  Post latitude(double? latitude);

  Post longitude(double? longitude);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Post(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Post(...).copyWith(id: 12, name: "My name")
  /// ````
  Post call({
    String? caption,
    int? cmtCount,
    int? id,
    bool? isDeleted,
    int? likeCount,
    int? userID,
    String? urlImage,
    String? createdAt,
    String? updatedAt,
    SharedPostType? type,
    double? latitude,
    double? longitude,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPost.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPost.copyWith.fieldName(...)`
class _$PostCWProxyImpl implements _$PostCWProxy {
  const _$PostCWProxyImpl(this._value);

  final Post _value;

  @override
  Post caption(String? caption) => this(caption: caption);

  @override
  Post cmtCount(int cmtCount) => this(cmtCount: cmtCount);

  @override
  Post id(int? id) => this(id: id);

  @override
  Post isDeleted(bool isDeleted) => this(isDeleted: isDeleted);

  @override
  Post likeCount(int likeCount) => this(likeCount: likeCount);

  @override
  Post userID(int? userID) => this(userID: userID);

  @override
  Post urlImage(String? urlImage) => this(urlImage: urlImage);

  @override
  Post createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  Post updatedAt(String? updatedAt) => this(updatedAt: updatedAt);

  @override
  Post type(SharedPostType? type) => this(type: type);

  @override
  Post latitude(double? latitude) => this(latitude: latitude);

  @override
  Post longitude(double? longitude) => this(longitude: longitude);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Post(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Post(...).copyWith(id: 12, name: "My name")
  /// ````
  Post call({
    Object? caption = const $CopyWithPlaceholder(),
    Object? cmtCount = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isDeleted = const $CopyWithPlaceholder(),
    Object? likeCount = const $CopyWithPlaceholder(),
    Object? userID = const $CopyWithPlaceholder(),
    Object? urlImage = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? latitude = const $CopyWithPlaceholder(),
    Object? longitude = const $CopyWithPlaceholder(),
  }) {
    return Post(
      caption: caption == const $CopyWithPlaceholder()
          ? _value.caption
          // ignore: cast_nullable_to_non_nullable
          : caption as String?,
      cmtCount: cmtCount == const $CopyWithPlaceholder() || cmtCount == null
          ? _value.cmtCount
          // ignore: cast_nullable_to_non_nullable
          : cmtCount as int,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      isDeleted: isDeleted == const $CopyWithPlaceholder() || isDeleted == null
          ? _value.isDeleted
          // ignore: cast_nullable_to_non_nullable
          : isDeleted as bool,
      likeCount: likeCount == const $CopyWithPlaceholder() || likeCount == null
          ? _value.likeCount
          // ignore: cast_nullable_to_non_nullable
          : likeCount as int,
      userID: userID == const $CopyWithPlaceholder()
          ? _value.userID
          // ignore: cast_nullable_to_non_nullable
          : userID as int?,
      urlImage: urlImage == const $CopyWithPlaceholder()
          ? _value.urlImage
          // ignore: cast_nullable_to_non_nullable
          : urlImage as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as SharedPostType?,
      latitude: latitude == const $CopyWithPlaceholder()
          ? _value.latitude
          // ignore: cast_nullable_to_non_nullable
          : latitude as double?,
      longitude: longitude == const $CopyWithPlaceholder()
          ? _value.longitude
          // ignore: cast_nullable_to_non_nullable
          : longitude as double?,
    );
  }
}

extension $PostCopyWith on Post {
  /// Returns a callable class that can be used as follows: `instanceOfPost.copyWith(...)` or like so:`instanceOfPost.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PostCWProxy get copyWith => _$PostCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `Post(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Post(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  Post copyWithNull({
    bool caption = false,
    bool id = false,
    bool userID = false,
    bool urlImage = false,
    bool createdAt = false,
    bool updatedAt = false,
    bool type = false,
    bool latitude = false,
    bool longitude = false,
  }) {
    return Post(
      caption: caption == true ? null : this.caption,
      cmtCount: cmtCount,
      id: id == true ? null : this.id,
      isDeleted: isDeleted,
      likeCount: likeCount,
      userID: userID == true ? null : this.userID,
      urlImage: urlImage == true ? null : this.urlImage,
      createdAt: createdAt == true ? null : this.createdAt,
      updatedAt: updatedAt == true ? null : this.updatedAt,
      type: type == true ? null : this.type,
      latitude: latitude == true ? null : this.latitude,
      longitude: longitude == true ? null : this.longitude,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      caption: json['caption'] as String?,
      cmtCount: (json['cmt_count'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt(),
      isDeleted: json['is_deleted'] == null
          ? false
          : Post._fromJsonBool((json['is_deleted'] as num).toInt()),
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      userID: (json['user_id'] as num?)?.toInt(),
      urlImage: json['url_image'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      type: sharedPostTypeFromJson(json['type'] as String?),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userID,
      'url_image': instance.urlImage,
      'caption': instance.caption,
      'like_count': instance.likeCount,
      'is_deleted': Post._toJsonBool(instance.isDeleted),
      'cmt_count': instance.cmtCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'type': sharedPostTypeToJson(instance.type),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
