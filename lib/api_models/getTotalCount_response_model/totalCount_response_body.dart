import 'package:freezed_annotation/freezed_annotation.dart';

part 'totalCount_response_body.freezed.dart';
part 'totalCount_response_body.g.dart';


@freezed
class TotalCountResponse with _$TotalCountResponse {
  const TotalCountResponse._();

  const factory TotalCountResponse({
     required bool  status,
     @Default([])  List<TotalCountResponseData> data,
  }) = _TotalCountResponse;

  factory TotalCountResponse.fromJson(Map<String, dynamic> json) => _$TotalCountResponseFromJson(json);
}

@freezed
class TotalCountResponseData with _$TotalCountResponseData {
  const TotalCountResponseData._();

  const factory TotalCountResponseData({
    @Default(0)  @JsonKey(name: 'totalContact') int? totalContact,
   @Default(0)  @JsonKey(name: 'totalConnection')  int?  totalConnection,
   @Default(0)  @JsonKey(name: 'totalUsers')  int? totalUsers,
  }) = _TotalCountResponseData;

  factory TotalCountResponseData.fromJson(Map<String, dynamic> json) => _$TotalCountResponseDataFromJson(json);
}