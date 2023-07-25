// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getMutualsContact_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetMutualsContactRequestBody _$$_GetMutualsContactRequestBodyFromJson(
        Map<String, dynamic> json) =>
    _$_GetMutualsContactRequestBody(
      to_id: json['to_id'] as int?,
    );

Map<String, dynamic> _$$_GetMutualsContactRequestBodyToJson(
    _$_GetMutualsContactRequestBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('to_id', instance.to_id);
  return val;
}
