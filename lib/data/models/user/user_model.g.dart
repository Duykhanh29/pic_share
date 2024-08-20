// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      roleType: $enumDecodeNullable(_$RoleTypeEnumMap, json['roleType']) ??
          RoleType.user,
      config: json['config'] == null
          ? null
          : Config.fromJson(json['config'] as Map<String, dynamic>),
      email: json['email'] as String?,
      geoInfo: json['geoInfo'] == null
          ? null
          : GeoInfo.fromJson(json['geoInfo'] as Map<String, dynamic>),
      id: json['id'] as String?,
      isVerified: json['isVerified'] as bool?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      urlAvatar: json['urlAvatar'] as String?,
      userCode: json['userCode'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'urlAvatar': instance.urlAvatar,
      'isVerified': instance.isVerified,
      'userCode': instance.userCode,
      'geoInfo': instance.geoInfo,
      'config': instance.config,
    };

const _$RoleTypeEnumMap = {
  RoleType.user: 'user',
  RoleType.admin: 'admin',
};

GeoInfo _$GeoInfoFromJson(Map<String, dynamic> json) => GeoInfo(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$GeoInfoToJson(GeoInfo instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      language: json['language'] as String,
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'language': instance.language,
    };
