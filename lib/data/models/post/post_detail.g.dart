// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_detail.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PostDetailCWProxy {
  PostDetail caption(String? caption);

  PostDetail cmtCount(int cmtCount);

  PostDetail id(int? id);

  PostDetail isDeleted(bool isDeleted);

  PostDetail likeCount(int likeCount);

  PostDetail listComment(List<Comment> listComment);

  PostDetail userID(int? userID);

  PostDetail urlImage(String? urlImage);

  PostDetail createdAt(String? createdAt);

  PostDetail updatedAt(String? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PostDetail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PostDetail(...).copyWith(id: 12, name: "My name")
  /// ````
  PostDetail call({
    String? caption,
    int? cmtCount,
    int? id,
    bool? isDeleted,
    int? likeCount,
    List<Comment>? listComment,
    int? userID,
    String? urlImage,
    String? createdAt,
    String? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPostDetail.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPostDetail.copyWith.fieldName(...)`
class _$PostDetailCWProxyImpl implements _$PostDetailCWProxy {
  const _$PostDetailCWProxyImpl(this._value);

  final PostDetail _value;

  @override
  PostDetail caption(String? caption) => this(caption: caption);

  @override
  PostDetail cmtCount(int cmtCount) => this(cmtCount: cmtCount);

  @override
  PostDetail id(int? id) => this(id: id);

  @override
  PostDetail isDeleted(bool isDeleted) => this(isDeleted: isDeleted);

  @override
  PostDetail likeCount(int likeCount) => this(likeCount: likeCount);

  @override
  PostDetail listComment(List<Comment> listComment) =>
      this(listComment: listComment);

  @override
  PostDetail userID(int? userID) => this(userID: userID);

  @override
  PostDetail urlImage(String? urlImage) => this(urlImage: urlImage);

  @override
  PostDetail createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  PostDetail updatedAt(String? updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PostDetail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PostDetail(...).copyWith(id: 12, name: "My name")
  /// ````
  PostDetail call({
    Object? caption = const $CopyWithPlaceholder(),
    Object? cmtCount = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isDeleted = const $CopyWithPlaceholder(),
    Object? likeCount = const $CopyWithPlaceholder(),
    Object? listComment = const $CopyWithPlaceholder(),
    Object? userID = const $CopyWithPlaceholder(),
    Object? urlImage = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return PostDetail(
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
      listComment:
          listComment == const $CopyWithPlaceholder() || listComment == null
              ? _value.listComment
              // ignore: cast_nullable_to_non_nullable
              : listComment as List<Comment>,
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
    );
  }
}

extension $PostDetailCopyWith on PostDetail {
  /// Returns a callable class that can be used as follows: `instanceOfPostDetail.copyWith(...)` or like so:`instanceOfPostDetail.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PostDetailCWProxy get copyWith => _$PostDetailCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `PostDetail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PostDetail(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  PostDetail copyWithNull({
    bool caption = false,
    bool id = false,
    bool userID = false,
    bool urlImage = false,
    bool createdAt = false,
    bool updatedAt = false,
  }) {
    return PostDetail(
      caption: caption == true ? null : this.caption,
      cmtCount: cmtCount,
      id: id == true ? null : this.id,
      isDeleted: isDeleted,
      likeCount: likeCount,
      listComment: listComment,
      userID: userID == true ? null : this.userID,
      urlImage: urlImage == true ? null : this.urlImage,
      createdAt: createdAt == true ? null : this.createdAt,
      updatedAt: updatedAt == true ? null : this.updatedAt,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetail _$PostDetailFromJson(Map<String, dynamic> json) => PostDetail(
      caption: json['caption'] as String?,
      cmtCount: (json['cmt_count'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt(),
      isDeleted: json['is_deleted'] == null
          ? false
          : PostDetail._fromJsonBool((json['is_deleted'] as num).toInt()),
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      listComment: (json['listCmt'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      userID: (json['userID'] as num?)?.toInt(),
      urlImage: json['url_image'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PostDetailToJson(PostDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'url_image': instance.urlImage,
      'caption': instance.caption,
      'like_count': instance.likeCount,
      'is_deleted': PostDetail._toJsonBool(instance.isDeleted),
      'cmt_count': instance.cmtCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'listCmt': instance.listComment.map((e) => e.toJson()).toList(),
    };
