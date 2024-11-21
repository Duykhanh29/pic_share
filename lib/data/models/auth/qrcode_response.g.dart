// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qrcode_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$QRCodeResponseCWProxy {
  QRCodeResponse code(String code);

  QRCodeResponse qrCodeUrl(String qrCodeUrl);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `QRCodeResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// QRCodeResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  QRCodeResponse call({
    String? code,
    String? qrCodeUrl,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfQRCodeResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfQRCodeResponse.copyWith.fieldName(...)`
class _$QRCodeResponseCWProxyImpl implements _$QRCodeResponseCWProxy {
  const _$QRCodeResponseCWProxyImpl(this._value);

  final QRCodeResponse _value;

  @override
  QRCodeResponse code(String code) => this(code: code);

  @override
  QRCodeResponse qrCodeUrl(String qrCodeUrl) => this(qrCodeUrl: qrCodeUrl);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `QRCodeResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// QRCodeResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  QRCodeResponse call({
    Object? code = const $CopyWithPlaceholder(),
    Object? qrCodeUrl = const $CopyWithPlaceholder(),
  }) {
    return QRCodeResponse(
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      qrCodeUrl: qrCodeUrl == const $CopyWithPlaceholder() || qrCodeUrl == null
          ? _value.qrCodeUrl
          // ignore: cast_nullable_to_non_nullable
          : qrCodeUrl as String,
    );
  }
}

extension $QRCodeResponseCopyWith on QRCodeResponse {
  /// Returns a callable class that can be used as follows: `instanceOfQRCodeResponse.copyWith(...)` or like so:`instanceOfQRCodeResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QRCodeResponseCWProxy get copyWith => _$QRCodeResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRCodeResponse _$QRCodeResponseFromJson(Map<String, dynamic> json) =>
    QRCodeResponse(
      code: json['code'] as String,
      qrCodeUrl: json['qr_code_url'] as String,
    );

Map<String, dynamic> _$QRCodeResponseToJson(QRCodeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'qr_code_url': instance.qrCodeUrl,
    };
