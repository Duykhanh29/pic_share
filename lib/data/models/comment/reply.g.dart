// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReplyCWProxy {
  Reply content(String? content);

  Reply createdAt(String? createdAt);

  Reply id(int? id);

  Reply user(UserSummaryModel? user);

  Reply updatedAt(String? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Reply(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Reply(...).copyWith(id: 12, name: "My name")
  /// ````
  Reply call({
    String? content,
    String? createdAt,
    int? id,
    UserSummaryModel? user,
    String? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReply.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReply.copyWith.fieldName(...)`
class _$ReplyCWProxyImpl implements _$ReplyCWProxy {
  const _$ReplyCWProxyImpl(this._value);

  final Reply _value;

  @override
  Reply content(String? content) => this(content: content);

  @override
  Reply createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  Reply id(int? id) => this(id: id);

  @override
  Reply user(UserSummaryModel? user) => this(user: user);

  @override
  Reply updatedAt(String? updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Reply(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Reply(...).copyWith(id: 12, name: "My name")
  /// ````
  Reply call({
    Object? content = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Reply(
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as UserSummaryModel?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String?,
    );
  }
}

extension $ReplyCopyWith on Reply {
  /// Returns a callable class that can be used as follows: `instanceOfReply.copyWith(...)` or like so:`instanceOfReply.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReplyCWProxy get copyWith => _$ReplyCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `Reply(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Reply(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  Reply copyWithNull({
    bool content = false,
    bool createdAt = false,
    bool id = false,
    bool user = false,
    bool updatedAt = false,
  }) {
    return Reply(
      content: content == true ? null : this.content,
      createdAt: createdAt == true ? null : this.createdAt,
      id: id == true ? null : this.id,
      user: user == true ? null : this.user,
      updatedAt: updatedAt == true ? null : this.updatedAt,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reply _$ReplyFromJson(Map<String, dynamic> json) => Reply(
      content: json['content'] as String?,
      createdAt: json['created_at'] as String?,
      id: (json['replyId'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : UserSummaryModel.fromJson(json['user'] as Map<String, dynamic>),
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'replyId': instance.id,
      'content': instance.content,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'user': instance.user?.toJson(),
    };
