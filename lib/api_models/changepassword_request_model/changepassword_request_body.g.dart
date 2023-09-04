// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changepassword_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChangePasswordRequestBody _$$_ChangePasswordRequestBodyFromJson(Map<String, dynamic> json) =>
    _$_ChangePasswordRequestBody(
      oldpassword: json['oldpassword'] as String,
      newpassword: json['newpassword'] as String,
    );

Map<String, dynamic> _$$_ChangePasswordRequestBodyToJson(_$_ChangePasswordRequestBody instance) => <String, dynamic>{
      'oldpassword': instance.oldpassword,
      'newpassword': instance.newpassword,
    };
