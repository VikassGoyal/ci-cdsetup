import 'package:freezed_annotation/freezed_annotation.dart';
part 'uploadebusinesslogo_request_body.freezed.dart';
part 'uploadebusinesslogo_request_body.g.dart';

@freezed
class UploadbusinesslogoRequestBody with _$UploadbusinesslogoRequestBody {
  @JsonSerializable(includeIfNull: false)
  const factory UploadbusinesslogoRequestBody({
    @JsonKey(name: 'base64data_logo') required String base64data_logo,
  }) = _UploadbusinesslogoRequestBody;
  factory UploadbusinesslogoRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UploadbusinesslogoRequestBodyFromJson(json);
}
