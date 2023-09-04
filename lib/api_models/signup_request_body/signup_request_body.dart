import 'package:freezed_annotation/freezed_annotation.dart';
part 'signup_request_body.freezed.dart';
part 'signup_request_body.g.dart';

@freezed
class SignupRequestBody with _$SignupRequestBody {
  const SignupRequestBody._();

  @JsonSerializable(includeIfNull: false)
  const factory SignupRequestBody({
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'phone') required String phone,
    @JsonKey(name: 'password') required String password,
  }) = _SignupRequestBody;

  factory SignupRequestBody.fromJson(Map<String, dynamic> json) => _$SignupRequestBodyFromJson(json);
}
