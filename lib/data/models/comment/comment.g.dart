// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

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
