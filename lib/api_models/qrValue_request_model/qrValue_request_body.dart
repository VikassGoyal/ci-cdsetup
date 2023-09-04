import 'package:freezed_annotation/freezed_annotation.dart';
part 'qrValue_request_body.freezed.dart';
part 'qrValue_request_body.g.dart';

@freezed
class QrValueRequestBody with _$QrValueRequestBody {
  @JsonSerializable(includeIfNull: false)
  const factory QrValueRequestBody({
    @JsonKey(name: 'value') required String? value,
    @JsonKey(name: 'qrcode') required bool qrcode,
    @JsonKey(name: 'content') dynamic content,
    @JsonKey(name: 'viaid') dynamic viaid,
  }) = _QrValueRequestBody;
  factory QrValueRequestBody.fromJson(Map<String, dynamic> json) => _$QrValueRequestBodyFromJson(json);
}
