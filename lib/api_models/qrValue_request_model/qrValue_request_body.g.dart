// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qrValue_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QrValueRequestBody _$$_QrValueRequestBodyFromJson(Map<String, dynamic> json) => _$_QrValueRequestBody(
      value: json['value'] as String?,
      qrcode: json['qrcode'] as bool,
      content: json['content'],
      viaid: json['viaid'],
    );

Map<String, dynamic> _$$_QrValueRequestBodyToJson(_$_QrValueRequestBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.value);
  val['qrcode'] = instance.qrcode;
  writeNotNull('content', instance.content);
  writeNotNull('viaid', instance.viaid);
  return val;
}
