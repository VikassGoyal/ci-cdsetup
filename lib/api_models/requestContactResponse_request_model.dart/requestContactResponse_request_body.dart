import 'package:freezed_annotation/freezed_annotation.dart';
part 'requestContactResponse_request_body.freezed.dart';
part 'requestContactResponse_request_body.g.dart';

@freezed
class RequestContactResponseRequestBody with _$RequestContactResponseRequestBody {
  @JsonSerializable(includeIfNull: false)
  const factory RequestContactResponseRequestBody(
      {@JsonKey(name: 'id') required String id,
      @JsonKey(name: 'responseid') required dynamic responseid}) = _RequestContactResponseRequestBody;
  factory RequestContactResponseRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RequestContactResponseRequestBodyFromJson(json);
}
