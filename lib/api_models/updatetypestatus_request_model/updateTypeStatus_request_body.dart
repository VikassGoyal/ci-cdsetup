import 'package:freezed_annotation/freezed_annotation.dart';
part 'updateTypeStatus_request_body.freezed.dart';
part 'updateTypeStatus_request_body.g.dart';

@freezed
class UpdateTypeStatusRequestBody with _$UpdateTypeStatusRequestBody {
  @JsonSerializable(includeIfNull: false)
  const factory UpdateTypeStatusRequestBody(
      {@JsonKey(name: 'id') required int? id,
      @JsonKey(name: 'type') required String type}) = _UpdateTypeStatusRequestBody;
  factory UpdateTypeStatusRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateTypeStatusRequestBodyFromJson(json);
}
