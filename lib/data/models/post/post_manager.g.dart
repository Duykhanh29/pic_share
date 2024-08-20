// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_manager.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostManager _$PostManagerFromJson(Map<String, dynamic> json) => PostManager(
      caption: json['caption'] as String?,
      id: json['id'] as String?,
      image: json['image'] as String?,
      time: (json['time'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PostManagerToJson(PostManager instance) =>
    <String, dynamic>{
      'id': instance.id,
      'caption': instance.caption,
      'image': instance.image,
      'type': instance.type,
      'time': instance.time,
    };
