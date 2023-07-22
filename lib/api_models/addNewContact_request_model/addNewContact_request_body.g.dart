// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addNewContact_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddNewContactRequestBody _$$_AddNewContactRequestBodyFromJson(
        Map<String, dynamic> json) =>
    _$_AddNewContactRequestBody(
      personalName: json['per_name'] as String,
      personalNumber: json['per_num'] as String,
      personalEmail: json['per_email'] as String,
      personalDob: json['per_dob'] as String,
      personalAddress: json['per_add'] as String,
      personalLandline: json['per_lan'] as int?,
      professionalOccupation: json['pro_occ'] as String,
      professionalIndustry: json['pro_ind'] as String,
      professionalCompany: json['pro_com'] as String,
      professionalCompanyWebsite: json['pro_com_website'] as String,
      professionalWorkNature: json['pro_wn'] as String,
      professionalDesignation: json['pro_des'] as String,
      professionalSchool: json['pro_sch'] as String,
      professionalGrade: json['pro_gra'] as String,
      socialFacebook: json['fb'] as String,
      socialInstagram: json['in'] as String,
      socialTwitter: json['tt'] as String,
      socialSkype: json['sk'] as String,
      entreprenerur_list: (json['entreprenerur_list'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$_AddNewContactRequestBodyToJson(
    _$_AddNewContactRequestBody instance) {
  final val = <String, dynamic>{
    'per_name': instance.personalName,
    'per_num': instance.personalNumber,
    'per_email': instance.personalEmail,
    'per_dob': instance.personalDob,
    'per_add': instance.personalAddress,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_lan', instance.personalLandline);
  val['pro_occ'] = instance.professionalOccupation;
  val['pro_ind'] = instance.professionalIndustry;
  val['pro_com'] = instance.professionalCompany;
  val['pro_com_website'] = instance.professionalCompanyWebsite;
  val['pro_wn'] = instance.professionalWorkNature;
  val['pro_des'] = instance.professionalDesignation;
  val['pro_sch'] = instance.professionalSchool;
  val['pro_gra'] = instance.professionalGrade;
  val['fb'] = instance.socialFacebook;
  val['in'] = instance.socialInstagram;
  val['tt'] = instance.socialTwitter;
  val['sk'] = instance.socialSkype;
  val['entreprenerur_list'] = instance.entreprenerur_list;
  return val;
}
