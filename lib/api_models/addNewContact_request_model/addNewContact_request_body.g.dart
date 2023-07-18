// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addNewContact_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddNewContactRequestBody _$$_AddNewContactRequestBodyFromJson(
        Map<String, dynamic> json) =>
    _$_AddNewContactRequestBody(
      per_name: json['per_name'] as String,
      per_num: json['per_num'] as String,
      per_email: json['per_email'] as String,
      per_dob: json['per_dob'] as String,
      per_add: json['per_add'] as String,
      per_lan: json['per_lan'] as int?,
      per_occ: json['pro_occ'] as String,
      per_ind: json['pro_ind'] as String,
      per_com: json['pro_com'] as String,
      per_com_website: json['pro_com_website'] as String,
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

Map<String, dynamic> _$$_AddNewContactRequestBodyToJson(
    _$_AddNewContactRequestBody instance) {
  final val = <String, dynamic>{
    'per_name': instance.per_name,
    'per_num': instance.per_num,
    'per_email': instance.per_email,
    'per_dob': instance.per_dob,
    'per_add': instance.per_add,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_lan', instance.per_lan);
  val['pro_occ'] = instance.per_occ;
  val['pro_ind'] = instance.per_ind;
  val['pro_com'] = instance.per_com;
  val['pro_com_website'] = instance.per_com_website;
  val['pro_wn'] = instance.pro_wn;
  val['pro_des'] = instance.pro_des;
  val['pro_sch'] = instance.pro_sch;
  val['pro_gra'] = instance.pro_gra;
  val['fb'] = instance.fb;
  val['in'] = instance.inn;
  val['tt'] = instance.tt;
  val['sk'] = instance.sk;
  val['entreprenerur_list'] = instance.entreprenerur_list;
  return val;
}
