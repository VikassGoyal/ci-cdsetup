// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploadebusinesslogo_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UploadbusinesslogoRequestBody _$$_UploadbusinesslogoRequestBodyFromJson(
        Map<String, dynamic> json) =>
    _$_UploadbusinesslogoRequestBody(
      base64data_logo: json['base64data_logo'],
    );

Map<String, dynamic> _$$_UploadbusinesslogoRequestBodyToJson(
    _$_UploadbusinesslogoRequestBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('base64data_logo', instance.base64data_logo);
  return val;
}
