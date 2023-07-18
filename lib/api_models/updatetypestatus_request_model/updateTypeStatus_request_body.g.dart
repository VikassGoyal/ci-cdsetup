// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updateTypeStatus_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UpdateTypeStatusRequestBody _$$_UpdateTypeStatusRequestBodyFromJson(
        Map<String, dynamic> json) =>
    _$_UpdateTypeStatusRequestBody(
      id: json['id'] as int?,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$_UpdateTypeStatusRequestBodyToJson(
    _$_UpdateTypeStatusRequestBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['type'] = instance.type;
  return val;
}
