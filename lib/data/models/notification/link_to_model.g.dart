// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_to_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LinkToModelCWProxy {
  LinkToModel type(LinkToType? type);

  LinkToModel postId(int? postId);

  LinkToModel commentId(int? commentId);

  LinkToModel replyId(int? replyId);

  LinkToModel friendNotiType(FriendNotiType? friendNotiType);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LinkToModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LinkToModel(...).copyWith(id: 12, name: "My name")
  /// ````
  LinkToModel call({
    LinkToType? type,
    int? postId,
    int? commentId,
    int? replyId,
    FriendNotiType? friendNotiType,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLinkToModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLinkToModel.copyWith.fieldName(...)`
class _$LinkToModelCWProxyImpl implements _$LinkToModelCWProxy {
  const _$LinkToModelCWProxyImpl(this._value);

  final LinkToModel _value;

  @override
  LinkToModel type(LinkToType? type) => this(type: type);

  @override
  LinkToModel postId(int? postId) => this(postId: postId);

  @override
  LinkToModel commentId(int? commentId) => this(commentId: commentId);

  @override
  LinkToModel replyId(int? replyId) => this(replyId: replyId);

  @override
  LinkToModel friendNotiType(FriendNotiType? friendNotiType) =>
      this(friendNotiType: friendNotiType);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LinkToModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LinkToModel(...).copyWith(id: 12, name: "My name")
  /// ````
  LinkToModel call({
    Object? type = const $CopyWithPlaceholder(),
    Object? postId = const $CopyWithPlaceholder(),
    Object? commentId = const $CopyWithPlaceholder(),
    Object? replyId = const $CopyWithPlaceholder(),
    Object? friendNotiType = const $CopyWithPlaceholder(),
  }) {
    return LinkToModel(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as LinkToType?,
      postId: postId == const $CopyWithPlaceholder()
          ? _value.postId
          // ignore: cast_nullable_to_non_nullable
          : postId as int?,
      commentId: commentId == const $CopyWithPlaceholder()
          ? _value.commentId
          // ignore: cast_nullable_to_non_nullable
          : commentId as int?,
      replyId: replyId == const $CopyWithPlaceholder()
          ? _value.replyId
          // ignore: cast_nullable_to_non_nullable
          : replyId as int?,
      friendNotiType: friendNotiType == const $CopyWithPlaceholder()
          ? _value.friendNotiType
          // ignore: cast_nullable_to_non_nullable
          : friendNotiType as FriendNotiType?,
    );
  }
}

extension $LinkToModelCopyWith on LinkToModel {
  /// Returns a callable class that can be used as follows: `instanceOfLinkToModel.copyWith(...)` or like so:`instanceOfLinkToModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LinkToModelCWProxy get copyWith => _$LinkToModelCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `LinkToModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LinkToModel(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  LinkToModel copyWithNull({
    bool type = false,
    bool postId = false,
    bool commentId = false,
    bool replyId = false,
    bool friendNotiType = false,
  }) {
    return LinkToModel(
      type: type == true ? null : this.type,
      postId: postId == true ? null : this.postId,
      commentId: commentId == true ? null : this.commentId,
      replyId: replyId == true ? null : this.replyId,
      friendNotiType: friendNotiType == true ? null : this.friendNotiType,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkToModel _$LinkToModelFromJson(Map<String, dynamic> json) => LinkToModel(
      type: linkToTypeFromJson(json['link_to_type'] as String?),
      postId: (json['post_id'] as num?)?.toInt(),
      commentId: (json['comment_id'] as num?)?.toInt(),
      replyId: (json['reply_id'] as num?)?.toInt(),
      friendNotiType: friendNotiTypeFromJson(json['friend_type'] as String?),
    );

Map<String, dynamic> _$LinkToModelToJson(LinkToModel instance) =>
    <String, dynamic>{
      'link_to_type': linkToTypeToJson(instance.type),
      'post_id': instance.postId,
      'comment_id': instance.commentId,
      'reply_id': instance.replyId,
      'friend_type': friendNotiTypeToJson(instance.friendNotiType),
    };
