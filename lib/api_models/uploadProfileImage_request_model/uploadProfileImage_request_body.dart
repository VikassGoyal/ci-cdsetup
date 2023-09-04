import 'package:freezed_annotation/freezed_annotation.dart';
part 'uploadProfileImage_request_body.freezed.dart';
part 'uploadProfileImage_request_body.g.dart';

@freezed
class UploadProfileImageRequestBody with _$UploadProfileImageRequestBody {
  @JsonSerializable(includeIfNull: false)
  const factory UploadProfileImageRequestBody({
    @JsonKey(name: 'base64data_profile') required String base64data_profile,
  }) = _UploadProfileImageRequestBody;
  factory UploadProfileImageRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UploadProfileImageRequestBodyFromJson(json);
}
