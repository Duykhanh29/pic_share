// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReplyCWProxy {
  Reply content(String? content);

  Reply createdAt(int? createdAt);

  Reply id(String? id);

  Reply user(CommentUser? user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Reply(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Reply(...).copyWith(id: 12, name: "My name")
  /// ````
  Reply call({
    String? content,
    int? createdAt,
    String? id,
    CommentUser? user,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReply.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReply.copyWith.fieldName(...)`
class _$ReplyCWProxyImpl implements _$ReplyCWProxy {
  const _$ReplyCWProxyImpl(this._value);

  final Reply _value;

  @override
  Reply content(String? content) => this(content: content);

  @override
  Reply createdAt(int? createdAt) => this(createdAt: createdAt);

  @override
  Reply id(String? id) => this(id: id);

  @override
  Reply user(CommentUser? user) => this(user: user);

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
  }) {
    return Reply(
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as int?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as CommentUser?,
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
  }) {
    return Reply(
      content: content == true ? null : this.content,
      createdAt: createdAt == true ? null : this.createdAt,
      id: id == true ? null : this.id,
      user: user == true ? null : this.user,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reply _$ReplyFromJson(Map<String, dynamic> json) => Reply(
      content: json['content'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      id: json['id'] as String?,
      user: json['user'] == null
          ? null
          : CommentUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'user': instance.user?.toJson(),
    };
