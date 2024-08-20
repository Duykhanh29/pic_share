// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      caption: json['caption'] as String?,
      cmtCount: (json['cmtCount'] as num?)?.toInt() ?? 0,
      id: json['id'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      listComment: (json['listComment'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      uid: json['uid'] as String?,
      urlImage: json['urlImage'] as String?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'urlImage': instance.urlImage,
      'caption': instance.caption,
      'likeCount': instance.likeCount,
      'isDeleted': instance.isDeleted,
      'cmtCount': instance.cmtCount,
      'listComment': instance.listComment,
    };
