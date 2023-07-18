import 'package:freezed_annotation/freezed_annotation.dart';
 part 'forgotpassword_request_body.freezed.dart';
 part 'forgotpassword_request_body.g.dart';

@freezed
class ForgotpasswordRequestBody with _$ForgotpasswordRequestBody {
  const ForgotpasswordRequestBody._();

  @JsonSerializable(includeIfNull: false)
  const factory  ForgotpasswordRequestBody({
      @JsonKey(name: "email") required String email,
    

    }) = _ForgotpasswordRequestBody;

  factory ForgotpasswordRequestBody.fromJson(Map<String, dynamic> json) => _$ForgotpasswordRequestBodyFromJson(json);
}

