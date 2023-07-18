import 'package:freezed_annotation/freezed_annotation.dart';
part 'changepassword_request_body.freezed.dart';
part 'changepassword_request_body.g.dart';

@freezed
class ChangePasswordRequestBody with _$ChangePasswordRequestBody {
  const ChangePasswordRequestBody._();
  @JsonSerializable(includeIfNull: false)
  const factory ChangePasswordRequestBody({
    @JsonKey(name: 'oldpassword') required String oldpassword,
    @JsonKey(name: ' newpassword') required String newpassword,
  }) = _ChangePasswordRequestBody;
  factory ChangePasswordRequestBody.fromJson(Map<String, dynamic> json) => _$ChangePasswordRequestBodyFromJson(json);
}
