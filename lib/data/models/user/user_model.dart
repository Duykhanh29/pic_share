import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/enums/role_type.dart';
part 'user_model.g.dart';

@JsonSerializable(
    explicitToJson:
        true) // add explicitToJson to make sure toJson of UserModel calls to another toJson inside this userModel
@CopyWith(copyWithNull: true)
class UserModel {
  final RoleType roleType;
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? urlAvatar;
  final bool? isVerified;
  final String? userCode;
  final GeoInfo? geoInfo;
  final Config? config;
  UserModel({
    this.roleType = RoleType.user,
    this.config,
    this.email,
    this.geoInfo,
    this.id,
    this.isVerified,
    this.name,
    this.phone,
    this.urlAvatar,
    this.userCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
@CopyWith(copyWithNull: true)
class GeoInfo {
  final double latitude;
  final double longitude;
  GeoInfo({required this.latitude, required this.longitude});
  factory GeoInfo.fromJson(Map<String, dynamic> json) =>
      _$GeoInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoInfoToJson(this);
}

@JsonSerializable()
@CopyWith(copyWithNull: true)
class Config {
  final String language;
  Config({required this.language});
  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
