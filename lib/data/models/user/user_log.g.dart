// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_log.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserLogCWProxy {
  UserLog id(int id);

  UserLog userId(int userId);

  UserLog totalDeletePosts(int totalDeletePosts);

  UserLog totalPosts(int totalPosts);

  UserLog totalView(int totalView);

  UserLog totalLikes(int totalLikes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserLog(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserLog(...).copyWith(id: 12, name: "My name")
  /// ````
  UserLog call({
    int? id,
    int? userId,
    int? totalDeletePosts,
    int? totalPosts,
    int? totalView,
    int? totalLikes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserLog.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserLog.copyWith.fieldName(...)`
class _$UserLogCWProxyImpl implements _$UserLogCWProxy {
  const _$UserLogCWProxyImpl(this._value);

  final UserLog _value;

  @override
  UserLog id(int id) => this(id: id);

  @override
  UserLog userId(int userId) => this(userId: userId);

  @override
  UserLog totalDeletePosts(int totalDeletePosts) =>
      this(totalDeletePosts: totalDeletePosts);

  @override
  UserLog totalPosts(int totalPosts) => this(totalPosts: totalPosts);

  @override
  UserLog totalView(int totalView) => this(totalView: totalView);

  @override
  UserLog totalLikes(int totalLikes) => this(totalLikes: totalLikes);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserLog(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserLog(...).copyWith(id: 12, name: "My name")
  /// ````
  UserLog call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? totalDeletePosts = const $CopyWithPlaceholder(),
    Object? totalPosts = const $CopyWithPlaceholder(),
    Object? totalView = const $CopyWithPlaceholder(),
    Object? totalLikes = const $CopyWithPlaceholder(),
  }) {
    return UserLog(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as int,
      totalDeletePosts: totalDeletePosts == const $CopyWithPlaceholder() ||
              totalDeletePosts == null
          ? _value.totalDeletePosts
          // ignore: cast_nullable_to_non_nullable
          : totalDeletePosts as int,
      totalPosts:
          totalPosts == const $CopyWithPlaceholder() || totalPosts == null
              ? _value.totalPosts
              // ignore: cast_nullable_to_non_nullable
              : totalPosts as int,
      totalView: totalView == const $CopyWithPlaceholder() || totalView == null
          ? _value.totalView
          // ignore: cast_nullable_to_non_nullable
          : totalView as int,
      totalLikes:
          totalLikes == const $CopyWithPlaceholder() || totalLikes == null
              ? _value.totalLikes
              // ignore: cast_nullable_to_non_nullable
              : totalLikes as int,
    );
  }
}

extension $UserLogCopyWith on UserLog {
  /// Returns a callable class that can be used as follows: `instanceOfUserLog.copyWith(...)` or like so:`instanceOfUserLog.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserLogCWProxy get copyWith => _$UserLogCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLog _$UserLogFromJson(Map<String, dynamic> json) => UserLog(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      totalDeletePosts: (json['total_deleted'] as num?)?.toInt() ?? 0,
      totalPosts: (json['total_post'] as num?)?.toInt() ?? 0,
      totalView: (json['total_view'] as num?)?.toInt() ?? 0,
      totalLikes: (json['total_like'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$UserLogToJson(UserLog instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'total_post': instance.totalPosts,
      'total_view': instance.totalView,
      'total_deleted': instance.totalDeletePosts,
      'total_like': instance.totalLikes,
    };
