import 'package:freezed_annotation/freezed_annotation.dart';
part 'konetwebpage_request_body.freezed.dart';
part 'konetwebpage_request_body.g.dart';

@freezed
class KonetwebpageRequestBody with _$KonetwebpageRequestBody {
  const KonetwebpageRequestBody._();

  @JsonSerializable(includeIfNull: false)
  const factory KonetwebpageRequestBody({
    @JsonKey(name: 'id') required String id,
  }) = _KonetwebpageRequestBody;

  factory KonetwebpageRequestBody.fromJson(Map<String, dynamic> json) => _$KonetwebpageRequestBodyFromJson(json);
}
