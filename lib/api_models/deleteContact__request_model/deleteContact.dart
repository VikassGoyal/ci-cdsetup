import 'package:freezed_annotation/freezed_annotation.dart';
part 'deleteContact.freezed.dart';
part 'deleteContact.g.dart';

@freezed
class DeleteContactdRequestBody with _$DeleteContactdRequestBody {
  const DeleteContactdRequestBody._();

  @JsonSerializable(includeIfNull: false)
  const factory DeleteContactdRequestBody({
    @JsonKey(name: "id") required String? id,
  }) = _DeleteContactdRequestBody;

  factory DeleteContactdRequestBody.fromJson(Map<String, dynamic> json) => _$DeleteContactdRequestBodyFromJson(json);
}
