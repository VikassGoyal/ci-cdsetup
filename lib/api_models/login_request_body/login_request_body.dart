import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_request_body.freezed.dart';
part 'login_request_body.g.dart';

@freezed
class LoginRequestBody with _$LoginRequestBody {
  const LoginRequestBody._();

  @JsonSerializable(includeIfNull: false)
  const factory LoginRequestBody({
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'password') required String password,
  }) = _LoginRequestBody;

  factory LoginRequestBody.fromJson(Map<String, dynamic> json) => _$LoginRequestBodyFromJson(json);
}
