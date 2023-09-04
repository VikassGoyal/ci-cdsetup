// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleteContact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DeleteContactdRequestBody _$$_DeleteContactdRequestBodyFromJson(
        Map<String, dynamic> json) =>
    _$_DeleteContactdRequestBody(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$_DeleteContactdRequestBodyToJson(
    _$_DeleteContactdRequestBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}
