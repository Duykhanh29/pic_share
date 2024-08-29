// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommentCWProxy {
  Comment content(String? content);

  Comment createdAt(int? createdAt);

  Comment id(String? id);

  Comment listReply(List<Reply> listReply);

  Comment user(CommentUser? user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Comment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Comment(...).copyWith(id: 12, name: "My name")
  /// ````
  Comment call({
    String? content,
    int? createdAt,
    String? id,
    List<Reply>? listReply,
    CommentUser? user,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfComment.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfComment.copyWith.fieldName(...)`
class _$CommentCWProxyImpl implements _$CommentCWProxy {
  const _$CommentCWProxyImpl(this._value);

  final Comment _value;

  @override
  Comment content(String? content) => this(content: content);

  @override
  Comment createdAt(int? createdAt) => this(createdAt: createdAt);

  @override
  Comment id(String? id) => this(id: id);

  @override
  Comment listReply(List<Reply> listReply) => this(listReply: listReply);

  @override
  Comment user(CommentUser? user) => this(user: user);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Comment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Comment(...).copyWith(id: 12, name: "My name")
  /// ````
  Comment call({
    Object? content = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? listReply = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return Comment(
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
      listReply: listReply == const $CopyWithPlaceholder() || listReply == null
          ? _value.listReply
          // ignore: cast_nullable_to_non_nullable
          : listReply as List<Reply>,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as CommentUser?,
    );
  }
}

extension $CommentCopyWith on Comment {
  /// Returns a callable class that can be used as follows: `instanceOfComment.copyWith(...)` or like so:`instanceOfComment.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommentCWProxy get copyWith => _$CommentCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `Comment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Comment(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  Comment copyWithNull({
    bool content = false,
    bool createdAt = false,
    bool id = false,
    bool user = false,
  }) {
    return Comment(
      content: content == true ? null : this.content,
      createdAt: createdAt == true ? null : this.createdAt,
      id: id == true ? null : this.id,
      listReply: listReply,
      user: user == true ? null : this.user,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      content: json['content'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      id: json['id'] as String?,
      listReply: (json['listReply'] as List<dynamic>?)
              ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      user: json['user'] == null
          ? null
          : CommentUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'listReply': instance.listReply.map((e) => e.toJson()).toList(),
      'user': instance.user?.toJson(),
    };
