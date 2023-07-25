import 'package:freezed_annotation/freezed_annotation.dart';
 part 'getProfileDetails_request_body.freezed.dart';
 part 'getProfileDetails_request_body.g.dart';
@freezed
class  GetProfileDetailsRequestBody with _$GetProfileDetailsRequestBody {
  const  GetProfileDetailsRequestBody._();

  @JsonSerializable(includeIfNull: false)
  const factory   GetProfileDetailsRequestBody({
    @JsonKey(name: 'phone') required String phone}) = _GetProfileDetailsRequestBody;

  factory GetProfileDetailsRequestBody.fromJson(Map<String, dynamic> json) => _$GetProfileDetailsRequestBodyFromJson(json);
}

