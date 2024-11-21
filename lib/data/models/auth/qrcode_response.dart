import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'qrcode_response.g.dart';

@JsonSerializable()
@CopyWith()
class QRCodeResponse {
  final String code;

  @JsonKey(name: 'qr_code_url')
  final String qrCodeUrl;

  QRCodeResponse({required this.code, required this.qrCodeUrl});

  factory QRCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$QRCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QRCodeResponseToJson(this);
}
