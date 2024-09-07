import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/enums/role_type.dart';
part 'user_model.g.dart';

@CopyWith(copyWithNull: true)
@JsonSerializable(
    explicitToJson:
        true) // add explicitToJson to make sure toJson of UserModel calls to another toJson inside this userModel
class UserModel {
  @JsonKey(name: 'role')
  final RoleType roleType;

  final int? id;
  final String? name;
  final String? email;

  @JsonKey(name: 'url_avatar')
  final String? urlAvatar;

  @JsonKey(name: 'email_verified_at')
  final String? isVerifiedAt;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'user_code')
  final String? userCode;

  @JsonKey(name: 'google_id')
  final String? googleID;

  final GeoInfo? geoInfo;

  final Config? config;

  @JsonKey(name: 'access_token')
  final String? accessToken;
  UserModel({
    this.roleType = RoleType.user,
    this.config,
    this.email,
    this.geoInfo,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isVerifiedAt,
    this.googleID,
    this.name,
    this.urlAvatar,
    this.userCode,
    this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@CopyWith(copyWithNull: true)
@JsonSerializable()
class GeoInfo {
  final double latitude;
  final double longitude;
  GeoInfo({required this.latitude, required this.longitude});
  factory GeoInfo.fromJson(Map<String, dynamic> json) =>
      _$GeoInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoInfoToJson(this);
}

@CopyWith(copyWithNull: true)
@JsonSerializable()
class Config {
  final String language;
  @JsonKey(name: 'fcm_token')
  final String? fcmToken;
  Config({required this.language, this.fcmToken});
  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
  Config customCopyWith({
    String? language,
    String? fcmToken,
  }) {
    return Config(
      language: language ?? this.language,
      fcmToken: fcmToken,
    );
  }
}
