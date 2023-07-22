import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/entrepreneureData.dart';
part 'addNewContact_request_body.freezed.dart';
part 'addNewContact_request_body.g.dart';

@freezed
class AddNewContactRequestBody with _$AddNewContactRequestBody {
  const AddNewContactRequestBody._();

  @JsonSerializable(includeIfNull: false)
  const factory AddNewContactRequestBody({
    @JsonKey(name: "per_name") required String personalName,
    @JsonKey(name: "per_num") required String personalNumber,
    @JsonKey(name: 'per_email') required String personalEmail,
    @JsonKey(name: 'per_dob') required String personalDob,
    @JsonKey(name: 'per_add') required String personalAddress,
    @JsonKey(name: 'per_lan') int? personalLandline,
    @JsonKey(name: 'pro_occ') required String professionalOccupation,
    @JsonKey(name: 'pro_ind') required String professionalIndustry,
    @JsonKey(name: 'pro_com') required String professionalCompany,
    @JsonKey(name: 'pro_com_website') required String professionalCompanyWebsite,
    @JsonKey(name: 'pro_wn') required String professionalWorkNature,
    @JsonKey(name: 'pro_des') required String professionalDesignation,
    @JsonKey(name: 'pro_sch') required String professionalSchool,
    @JsonKey(name: 'pro_gra') required String professionalGrade,
    @JsonKey(name: 'fb') required String socialFacebook,
    @JsonKey(name: 'in') required String socialInstagram,
    @JsonKey(name: 'tt') required String socialTwitter,
    @JsonKey(name: 'sk') required String socialSkype,
    @JsonKey(name: 'entreprenerur_list') required List<Map<String, dynamic>> entreprenerur_list,
  }) = _AddNewContactRequestBody;

  factory AddNewContactRequestBody.fromJson(Map<String, dynamic> json) => _$AddNewContactRequestBodyFromJson(json);
}
