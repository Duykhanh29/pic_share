// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentUser _$CommentUserFromJson(Map<String, dynamic> json) => CommentUser(
      uid: json['uid'] as String?,
      urlAvatar: json['urlAvatar'] as String?,
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$CommentUserToJson(CommentUser instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'uid': instance.uid,
      'urlAvatar': instance.urlAvatar,
    };
