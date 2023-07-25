import 'package:freezed_annotation/freezed_annotation.dart';
 part ' filterSearchResults_request_body.freezed.dart';
 part ' filterSearchResults_request_body.g.dart';

@freezed
class  FilterSearchResultsRequestBody with _$FilterSearchResultsRequestBody {
  const FilterSearchResultsRequestBody._();

  @JsonSerializable(includeIfNull: false)
  const factory  FilterSearchResultsRequestBody({
    @JsonKey(name: 'filter') required String filter}) = _FilterSearchResultsRequestBody;

  factory FilterSearchResultsRequestBody.fromJson(Map<String, dynamic> json) => _$FilterSearchResultsRequestBodyFromJson(json);
}

