// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PostCWProxy {
  Post caption(String? caption);

  Post cmtCount(int cmtCount);

  Post id(String? id);

  Post isDeleted(bool isDeleted);

  Post likeCount(int likeCount);

  Post listComment(List<Comment> listComment);

  Post uid(String? uid);

  Post urlImage(String? urlImage);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Post(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Post(...).copyWith(id: 12, name: "My name")
  /// ````
  Post call({
    String? caption,
    int? cmtCount,
    String? id,
    bool? isDeleted,
    int? likeCount,
    List<Comment>? listComment,
    String? uid,
    String? urlImage,
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
  Post id(String? id) => this(id: id);

  @override
  Post isDeleted(bool isDeleted) => this(isDeleted: isDeleted);

  @override
  Post likeCount(int likeCount) => this(likeCount: likeCount);

  @override
  Post listComment(List<Comment> listComment) => this(listComment: listComment);

  @override
  Post uid(String? uid) => this(uid: uid);

  @override
  Post urlImage(String? urlImage) => this(urlImage: urlImage);

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
    Object? listComment = const $CopyWithPlaceholder(),
    Object? uid = const $CopyWithPlaceholder(),
    Object? urlImage = const $CopyWithPlaceholder(),
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
          : id as String?,
      isDeleted: isDeleted == const $CopyWithPlaceholder() || isDeleted == null
          ? _value.isDeleted
          // ignore: cast_nullable_to_non_nullable
          : isDeleted as bool,
      likeCount: likeCount == const $CopyWithPlaceholder() || likeCount == null
          ? _value.likeCount
          // ignore: cast_nullable_to_non_nullable
          : likeCount as int,
      listComment:
          listComment == const $CopyWithPlaceholder() || listComment == null
              ? _value.listComment
              // ignore: cast_nullable_to_non_nullable
              : listComment as List<Comment>,
      uid: uid == const $CopyWithPlaceholder()
          ? _value.uid
          // ignore: cast_nullable_to_non_nullable
          : uid as String?,
      urlImage: urlImage == const $CopyWithPlaceholder()
          ? _value.urlImage
          // ignore: cast_nullable_to_non_nullable
          : urlImage as String?,
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
    bool uid = false,
    bool urlImage = false,
  }) {
    return Post(
      caption: caption == true ? null : this.caption,
      cmtCount: cmtCount,
      id: id == true ? null : this.id,
      isDeleted: isDeleted,
      likeCount: likeCount,
      listComment: listComment,
      uid: uid == true ? null : this.uid,
      urlImage: urlImage == true ? null : this.urlImage,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      caption: json['caption'] as String?,
      cmtCount: (json['cmtCount'] as num?)?.toInt() ?? 0,
      id: json['id'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      listComment: (json['listComment'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      uid: json['uid'] as String?,
      urlImage: json['urlImage'] as String?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'urlImage': instance.urlImage,
      'caption': instance.caption,
      'likeCount': instance.likeCount,
      'isDeleted': instance.isDeleted,
      'cmtCount': instance.cmtCount,
      'listComment': instance.listComment.map((e) => e.toJson()).toList(),
    };
