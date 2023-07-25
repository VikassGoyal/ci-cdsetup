// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestContactResponse_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RequestContactResponseRequestBody
    _$$_RequestContactResponseRequestBodyFromJson(Map<String, dynamic> json) =>
        _$_RequestContactResponseRequestBody(
          id: json['id'] as String,
          responseid: json['responseid'],
        );

Map<String, dynamic> _$$_RequestContactResponseRequestBodyToJson(
    _$_RequestContactResponseRequestBody instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('responseid', instance.responseid);
  return val;
}
