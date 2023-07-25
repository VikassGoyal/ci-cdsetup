import 'package:freezed_annotation/freezed_annotation.dart';
 part 'getMutualsContact_request_body.freezed.dart';
 part 'getMutualsContact_request_body.g.dart';

@freezed
class GetMutualsContactRequestBody with _$GetMutualsContactRequestBody {
  const GetMutualsContactRequestBody._();

  @JsonSerializable(includeIfNull: false)
  const factory  GetMutualsContactRequestBody({
      @JsonKey(name: "to_id") required int? to_id ,
    

    }) = _GetMutualsContactRequestBody;

  factory GetMutualsContactRequestBody.fromJson(Map<String, dynamic> json) => _$GetMutualsContactRequestBodyFromJson(json);
}

