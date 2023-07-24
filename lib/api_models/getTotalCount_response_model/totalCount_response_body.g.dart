// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totalCount_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TotalCountResponse _$$_TotalCountResponseFromJson(
        Map<String, dynamic> json) =>
    _$_TotalCountResponse(
      status: json['status'] as bool,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  TotalCountResponseData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TotalCountResponseToJson(
        _$_TotalCountResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

_$_TotalCountResponseData _$$_TotalCountResponseDataFromJson(
        Map<String, dynamic> json) =>
    _$_TotalCountResponseData(
      totalContact: json['totalContact'] as int? ?? 0,
      totalConnection: json['totalConnection'] as int? ?? 0,
      totalUsers: json['totalUsers'] as int? ?? 0,
    );

Map<String, dynamic> _$$_TotalCountResponseDataToJson(
        _$_TotalCountResponseData instance) =>
    <String, dynamic>{
      'totalContact': instance.totalContact,
      'totalConnection': instance.totalConnection,
      'totalUsers': instance.totalUsers,
    };
