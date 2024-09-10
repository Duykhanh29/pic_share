// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportCWProxy {
  Report id(int id);

  Report postID(int postID);

  Report reportedUserID(int reportedUserID);

  Report userReportingID(int userReportingID);

  Report reason(String reason);

  Report updatedAt(String updatedAt);

  Report createddAt(String createddAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Report(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Report(...).copyWith(id: 12, name: "My name")
  /// ````
  Report call({
    int? id,
    int? postID,
    int? reportedUserID,
    int? userReportingID,
    String? reason,
    String? updatedAt,
    String? createddAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReport.copyWith.fieldName(...)`
class _$ReportCWProxyImpl implements _$ReportCWProxy {
  const _$ReportCWProxyImpl(this._value);

  final Report _value;

  @override
  Report id(int id) => this(id: id);

  @override
  Report postID(int postID) => this(postID: postID);

  @override
  Report reportedUserID(int reportedUserID) =>
      this(reportedUserID: reportedUserID);

  @override
  Report userReportingID(int userReportingID) =>
      this(userReportingID: userReportingID);

  @override
  Report reason(String reason) => this(reason: reason);

  @override
  Report updatedAt(String updatedAt) => this(updatedAt: updatedAt);

  @override
  Report createddAt(String createddAt) => this(createddAt: createddAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Report(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Report(...).copyWith(id: 12, name: "My name")
  /// ````
  Report call({
    Object? id = const $CopyWithPlaceholder(),
    Object? postID = const $CopyWithPlaceholder(),
    Object? reportedUserID = const $CopyWithPlaceholder(),
    Object? userReportingID = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? createddAt = const $CopyWithPlaceholder(),
  }) {
    return Report(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      postID: postID == const $CopyWithPlaceholder() || postID == null
          ? _value.postID
          // ignore: cast_nullable_to_non_nullable
          : postID as int,
      reportedUserID: reportedUserID == const $CopyWithPlaceholder() ||
              reportedUserID == null
          ? _value.reportedUserID
          // ignore: cast_nullable_to_non_nullable
          : reportedUserID as int,
      userReportingID: userReportingID == const $CopyWithPlaceholder() ||
              userReportingID == null
          ? _value.userReportingID
          // ignore: cast_nullable_to_non_nullable
          : userReportingID as int,
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String,
      createddAt:
          createddAt == const $CopyWithPlaceholder() || createddAt == null
              ? _value.createddAt
              // ignore: cast_nullable_to_non_nullable
              : createddAt as String,
    );
  }
}

extension $ReportCopyWith on Report {
  /// Returns a callable class that can be used as follows: `instanceOfReport.copyWith(...)` or like so:`instanceOfReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportCWProxy get copyWith => _$ReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      id: (json['id'] as num).toInt(),
      postID: (json['post_id'] as num).toInt(),
      reportedUserID: (json['reported_user'] as num).toInt(),
      userReportingID: (json['user_reporting'] as num).toInt(),
      reason: json['reason'] as String,
      updatedAt: json['updated_at'] as String,
      createddAt: json['created_at'] as String,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'post_id': instance.postID,
      'reported_user': instance.reportedUserID,
      'user_reporting': instance.userReportingID,
      'reason': instance.reason,
      'updated_at': instance.updatedAt,
      'created_at': instance.createddAt,
    };
