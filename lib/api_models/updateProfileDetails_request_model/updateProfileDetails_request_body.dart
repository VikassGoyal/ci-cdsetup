import 'package:freezed_annotation/freezed_annotation.dart';
part 'updateProfileDetails_request_body.freezed.dart';
part 'updateProfileDetails_request_body.g.dart';

@freezed
class UpdateProfileDetailsRequestBody with _$UpdateProfileDetailsRequestBody {
  const UpdateProfileDetailsRequestBody._();

  @JsonSerializable(includeIfNull: false)
  const factory UpdateProfileDetailsRequestBody({
    @JsonKey(name: "per_name") required String per_name,
    @JsonKey(name: "per_num") required String per_num,
    @JsonKey(name: "per_secondary_num") required String per_secondary_num,
    @JsonKey(name: 'per_email') required String per_email,
    @JsonKey(name: 'per_dob') required String per_dob,
    @JsonKey(name: 'per_add') required String per_add,
    @JsonKey(name: 'per_lan') required String per_lan,
    @JsonKey(name: 'per_keyword') required String per_keyword,
    @JsonKey(name: 'per_city') required String per_city,
    @JsonKey(name: 'per_state') required String per_state,
    @JsonKey(name: 'per_country') required String per_country,
    @JsonKey(name: 'per_pincode') required String per_pincode,
    @JsonKey(name: 'pro_occ') required String pro_occ,
    @JsonKey(name: 'pro_ind') required String pro_ind,
    @JsonKey(name: 'pro_com') required String pro_com,
    @JsonKey(name: 'pro_com_website') required String pro_com_website,
    @JsonKey(name: 'pro_wn') required String pro_wn,
    @JsonKey(name: 'pro_des') required String pro_des,
    @JsonKey(name: 'pro_sch') required String pro_sch,
    @JsonKey(name: 'pro_gra') required String pro_gra,
    @JsonKey(name: 'fb') required String fb,
    @JsonKey(name: 'in') required String inn,
    @JsonKey(name: 'tt') required String tt,
    @JsonKey(name: 'sk') required String sk,
    @JsonKey(name: 'entreprenerur_list') required List<Map<String, dynamic>> entreprenerur_list,
  }) = _UpdateProfileDetailsRequestBody;

  factory UpdateProfileDetailsRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileDetailsRequestBodyFromJson(json);
}
