// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_log.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserLogCWProxy {
  UserLog uid(String uid);

  UserLog totalDeletePosts(int totalDeletePosts);

  UserLog totalPosts(int totalPosts);

  UserLog totalView(int totalView);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserLog(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserLog(...).copyWith(id: 12, name: "My name")
  /// ````
  UserLog call({
    String? uid,
    int? totalDeletePosts,
    int? totalPosts,
    int? totalView,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserLog.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserLog.copyWith.fieldName(...)`
class _$UserLogCWProxyImpl implements _$UserLogCWProxy {
  const _$UserLogCWProxyImpl(this._value);

  final UserLog _value;

  @override
  UserLog uid(String uid) => this(uid: uid);

  @override
  UserLog totalDeletePosts(int totalDeletePosts) =>
      this(totalDeletePosts: totalDeletePosts);

  @override
  UserLog totalPosts(int totalPosts) => this(totalPosts: totalPosts);

  @override
  UserLog totalView(int totalView) => this(totalView: totalView);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserLog(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserLog(...).copyWith(id: 12, name: "My name")
  /// ````
  UserLog call({
    Object? uid = const $CopyWithPlaceholder(),
    Object? totalDeletePosts = const $CopyWithPlaceholder(),
    Object? totalPosts = const $CopyWithPlaceholder(),
    Object? totalView = const $CopyWithPlaceholder(),
  }) {
    return UserLog(
      uid: uid == const $CopyWithPlaceholder() || uid == null
          ? _value.uid
          // ignore: cast_nullable_to_non_nullable
          : uid as String,
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
      uid: json['uid'] as String,
      totalDeletePosts: (json['totalDeletePosts'] as num?)?.toInt() ?? 0,
      totalPosts: (json['totalPosts'] as num?)?.toInt() ?? 0,
      totalView: (json['totalView'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$UserLogToJson(UserLog instance) => <String, dynamic>{
      'uid': instance.uid,
      'totalPosts': instance.totalPosts,
      'totalView': instance.totalView,
      'totalDeletePosts': instance.totalDeletePosts,
    };
