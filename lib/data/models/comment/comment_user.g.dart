// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommentUserCWProxy {
  CommentUser uid(String? uid);

  CommentUser urlAvatar(String? urlAvatar);

  CommentUser userName(String? userName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CommentUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommentUser(...).copyWith(id: 12, name: "My name")
  /// ````
  CommentUser call({
    String? uid,
    String? urlAvatar,
    String? userName,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCommentUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCommentUser.copyWith.fieldName(...)`
class _$CommentUserCWProxyImpl implements _$CommentUserCWProxy {
  const _$CommentUserCWProxyImpl(this._value);

  final CommentUser _value;

  @override
  CommentUser uid(String? uid) => this(uid: uid);

  @override
  CommentUser urlAvatar(String? urlAvatar) => this(urlAvatar: urlAvatar);

  @override
  CommentUser userName(String? userName) => this(userName: userName);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CommentUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommentUser(...).copyWith(id: 12, name: "My name")
  /// ````
  CommentUser call({
    Object? uid = const $CopyWithPlaceholder(),
    Object? urlAvatar = const $CopyWithPlaceholder(),
    Object? userName = const $CopyWithPlaceholder(),
  }) {
    return CommentUser(
      uid: uid == const $CopyWithPlaceholder()
          ? _value.uid
          // ignore: cast_nullable_to_non_nullable
          : uid as String?,
      urlAvatar: urlAvatar == const $CopyWithPlaceholder()
          ? _value.urlAvatar
          // ignore: cast_nullable_to_non_nullable
          : urlAvatar as String?,
      userName: userName == const $CopyWithPlaceholder()
          ? _value.userName
          // ignore: cast_nullable_to_non_nullable
          : userName as String?,
    );
  }
}

extension $CommentUserCopyWith on CommentUser {
  /// Returns a callable class that can be used as follows: `instanceOfCommentUser.copyWith(...)` or like so:`instanceOfCommentUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommentUserCWProxy get copyWith => _$CommentUserCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `CommentUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommentUser(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  CommentUser copyWithNull({
    bool uid = false,
    bool urlAvatar = false,
    bool userName = false,
  }) {
    return CommentUser(
      uid: uid == true ? null : this.uid,
      urlAvatar: urlAvatar == true ? null : this.urlAvatar,
      userName: userName == true ? null : this.userName,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentUser _$CommentUserFromJson(Map<String, dynamic> json) => CommentUser(
      uid: json['uid'] as String?,
      urlAvatar: json['urlAvatar'] as String?,
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$CommentUserToJson(CommentUser instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'uid': instance.uid,
      'urlAvatar': instance.urlAvatar,
    };
