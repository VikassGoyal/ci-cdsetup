import 'package:freezed_annotation/freezed_annotation.dart';
 part 'checkContactForAddNew_request_body.freezed.dart';
 part 'checkContactForAddNew_request_body.g.dart';
@freezed
class  CheckContactForAddNewRequestBody with _$CheckContactForAddNewRequestBody {
  const  CheckContactForAddNewRequestBody._();

  @JsonSerializable(includeIfNull: false)
  const factory   CheckContactForAddNewRequestBody({
    @JsonKey(name: 'phone') required String phone}) = _CheckContactForAddNewRequestBody;

  factory  CheckContactForAddNewRequestBody.fromJson(Map<String, dynamic> json) => _$CheckContactForAddNewRequestBodyFromJson(json);
}

