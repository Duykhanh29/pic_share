// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_summary_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserSummaryModelCWProxy {
  UserSummaryModel id(int? id);

  UserSummaryModel name(String? name);

  UserSummaryModel urlAvatar(String? urlAvatar);

  UserSummaryModel userCode(String? userCode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserSummaryModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserSummaryModel(...).copyWith(id: 12, name: "My name")
  /// ````
  UserSummaryModel call({
    int? id,
    String? name,
    String? urlAvatar,
    String? userCode,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserSummaryModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserSummaryModel.copyWith.fieldName(...)`
class _$UserSummaryModelCWProxyImpl implements _$UserSummaryModelCWProxy {
  const _$UserSummaryModelCWProxyImpl(this._value);

  final UserSummaryModel _value;

  @override
  UserSummaryModel id(int? id) => this(id: id);

  @override
  UserSummaryModel name(String? name) => this(name: name);

  @override
  UserSummaryModel urlAvatar(String? urlAvatar) => this(urlAvatar: urlAvatar);

  @override
  UserSummaryModel userCode(String? userCode) => this(userCode: userCode);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserSummaryModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserSummaryModel(...).copyWith(id: 12, name: "My name")
  /// ````
  UserSummaryModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? urlAvatar = const $CopyWithPlaceholder(),
    Object? userCode = const $CopyWithPlaceholder(),
  }) {
    return UserSummaryModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      urlAvatar: urlAvatar == const $CopyWithPlaceholder()
          ? _value.urlAvatar
          // ignore: cast_nullable_to_non_nullable
          : urlAvatar as String?,
      userCode: userCode == const $CopyWithPlaceholder()
          ? _value.userCode
          // ignore: cast_nullable_to_non_nullable
          : userCode as String?,
    );
  }
}

extension $UserSummaryModelCopyWith on UserSummaryModel {
  /// Returns a callable class that can be used as follows: `instanceOfUserSummaryModel.copyWith(...)` or like so:`instanceOfUserSummaryModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserSummaryModelCWProxy get copyWith => _$UserSummaryModelCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `UserSummaryModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserSummaryModel(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  UserSummaryModel copyWithNull({
    bool id = false,
    bool name = false,
    bool urlAvatar = false,
    bool userCode = false,
  }) {
    return UserSummaryModel(
      id: id == true ? null : this.id,
      name: name == true ? null : this.name,
      urlAvatar: urlAvatar == true ? null : this.urlAvatar,
      userCode: userCode == true ? null : this.userCode,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSummaryModel _$UserSummaryModelFromJson(Map<String, dynamic> json) =>
    UserSummaryModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      urlAvatar: json['avatar'] as String?,
      userCode: json['user_code'] as String?,
    );

Map<String, dynamic> _$UserSummaryModelToJson(UserSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.urlAvatar,
      'user_code': instance.userCode,
    };
