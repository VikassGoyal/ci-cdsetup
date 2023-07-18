import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/entrepreneureData.dart';
part 'addNewContact_request_body.freezed.dart';
part 'addNewContact_request_body.g.dart';

@freezed
class AddNewContactRequestBody with _$AddNewContactRequestBody {
  const AddNewContactRequestBody._();

  @JsonSerializable(includeIfNull: false)
  const factory AddNewContactRequestBody({
    @JsonKey(name: "per_name") required String per_name,
    @JsonKey(name: "per_num") required String per_num,
    @JsonKey(name: 'per_email') required String per_email,
    @JsonKey(name: 'per_dob') required String per_dob,
    @JsonKey(name: 'per_add') required String per_add,
    @JsonKey(name: 'per_lan') int? per_lan,
    @JsonKey(name: 'pro_occ') required String per_occ,
    @JsonKey(name: 'pro_ind') required String per_ind,
    @JsonKey(name: 'pro_com') required String per_com,
    @JsonKey(name: 'pro_com_website') required String per_com_website,
    @JsonKey(name: 'pro_wn') required String pro_wn,
    @JsonKey(name: 'pro_des') required String pro_des,
    @JsonKey(name: 'pro_sch') required String pro_sch,
    @JsonKey(name: 'pro_gra') required String pro_gra,
    @JsonKey(name: 'fb') required String fb,
    @JsonKey(name: 'in') required String inn,
    @JsonKey(name: 'tt') required String tt,
    @JsonKey(name: 'sk') required String sk,
    @JsonKey(name: 'entreprenerur_list') required List<Map<String, dynamic>> entreprenerur_list,
  }) = _AddNewContactRequestBody;

  factory AddNewContactRequestBody.fromJson(Map<String, dynamic> json) => _$AddNewContactRequestBodyFromJson(json);
}
