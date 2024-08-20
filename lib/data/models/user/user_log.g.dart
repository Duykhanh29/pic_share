// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_log.dart';

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
