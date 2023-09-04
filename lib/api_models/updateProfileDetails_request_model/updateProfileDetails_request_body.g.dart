// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updateProfileDetails_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UpdateProfileDetailsRequestBody _$$_UpdateProfileDetailsRequestBodyFromJson(
        Map<String, dynamic> json) =>
    _$_UpdateProfileDetailsRequestBody(
      per_name: json['per_name'] as String,
      per_num: json['per_num'] as String,
      per_secondary_num: json['per_secondary_num'] as String,
      per_email: json['per_email'] as String,
      per_dob: json['per_dob'] as String,
      per_add: json['per_add'] as String,
      per_lan: json['per_lan'] as String,
      per_keyword: json['per_keyword'] as String,
      per_city: json['per_city'] as String,
      per_state: json['per_state'] as String,
      per_country: json['per_country'] as String,
      per_pincode: json['per_pincode'] as String,
      pro_occ: json['pro_occ'] as String,
      pro_ind: json['pro_ind'] as String,
      pro_com: json['pro_com'] as String,
      pro_com_website: json['pro_com_website'] as String,
      pro_wn: json['pro_wn'] as String,
      pro_des: json['pro_des'] as String,
      pro_sch: json['pro_sch'] as String,
      pro_gra: json['pro_gra'] as String,
      fb: json['fb'] as String,
      inn: json['in'] as String,
      tt: json['tt'] as String,
      sk: json['sk'] as String,
      entreprenerur_list: (json['entreprenerur_list'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$_UpdateProfileDetailsRequestBodyToJson(
        _$_UpdateProfileDetailsRequestBody instance) =>
    <String, dynamic>{
      'per_name': instance.per_name,
      'per_num': instance.per_num,
      'per_secondary_num': instance.per_secondary_num,
      'per_email': instance.per_email,
      'per_dob': instance.per_dob,
      'per_add': instance.per_add,
      'per_lan': instance.per_lan,
      'per_keyword': instance.per_keyword,
      'per_city': instance.per_city,
      'per_state': instance.per_state,
      'per_country': instance.per_country,
      'per_pincode': instance.per_pincode,
      'pro_occ': instance.pro_occ,
      'pro_ind': instance.pro_ind,
      'pro_com': instance.pro_com,
      'pro_com_website': instance.pro_com_website,
      'pro_wn': instance.pro_wn,
      'pro_des': instance.pro_des,
      'pro_sch': instance.pro_sch,
      'pro_gra': instance.pro_gra,
      'fb': instance.fb,
      'in': instance.inn,
      'tt': instance.tt,
      'sk': instance.sk,
      'entreprenerur_list': instance.entreprenerur_list,
    };
