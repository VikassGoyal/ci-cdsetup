// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of ' filterSearchResults_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FilterSearchResultsRequestBody _$FilterSearchResultsRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _FilterSearchResultsRequestBody.fromJson(json);
}

/// @nodoc
mixin _$FilterSearchResultsRequestBody {
  @JsonKey(name: 'filter')
  String get filter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterSearchResultsRequestBodyCopyWith<FilterSearchResultsRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterSearchResultsRequestBodyCopyWith<$Res> {
  factory $FilterSearchResultsRequestBodyCopyWith(
          FilterSearchResultsRequestBody value,
          $Res Function(FilterSearchResultsRequestBody) then) =
      _$FilterSearchResultsRequestBodyCopyWithImpl<$Res,
          FilterSearchResultsRequestBody>;
  @useResult
  $Res call({@JsonKey(name: 'filter') String filter});
}

/// @nodoc
class _$FilterSearchResultsRequestBodyCopyWithImpl<$Res,
        $Val extends FilterSearchResultsRequestBody>
    implements $FilterSearchResultsRequestBodyCopyWith<$Res> {
  _$FilterSearchResultsRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = null,
  }) {
    return _then(_value.copyWith(
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FilterSearchResultsRequestBodyCopyWith<$Res>
    implements $FilterSearchResultsRequestBodyCopyWith<$Res> {
  factory _$$_FilterSearchResultsRequestBodyCopyWith(
          _$_FilterSearchResultsRequestBody value,
          $Res Function(_$_FilterSearchResultsRequestBody) then) =
      __$$_FilterSearchResultsRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'filter') String filter});
}

/// @nodoc
class __$$_FilterSearchResultsRequestBodyCopyWithImpl<$Res>
    extends _$FilterSearchResultsRequestBodyCopyWithImpl<$Res,
        _$_FilterSearchResultsRequestBody>
    implements _$$_FilterSearchResultsRequestBodyCopyWith<$Res> {
  __$$_FilterSearchResultsRequestBodyCopyWithImpl(
      _$_FilterSearchResultsRequestBody _value,
      $Res Function(_$_FilterSearchResultsRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = null,
  }) {
    return _then(_$_FilterSearchResultsRequestBody(
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_FilterSearchResultsRequestBody
    extends _FilterSearchResultsRequestBody {
  const _$_FilterSearchResultsRequestBody(
      {@JsonKey(name: 'filter') required this.filter})
      : super._();

  factory _$_FilterSearchResultsRequestBody.fromJson(
          Map<String, dynamic> json) =>
      _$$_FilterSearchResultsRequestBodyFromJson(json);

  @override
  @JsonKey(name: 'filter')
  final String filter;

  @override
  String toString() {
    return 'FilterSearchResultsRequestBody(filter: $filter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FilterSearchResultsRequestBody &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, filter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FilterSearchResultsRequestBodyCopyWith<_$_FilterSearchResultsRequestBody>
      get copyWith => __$$_FilterSearchResultsRequestBodyCopyWithImpl<
          _$_FilterSearchResultsRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FilterSearchResultsRequestBodyToJson(
      this,
    );
  }
}

abstract class _FilterSearchResultsRequestBody
    extends FilterSearchResultsRequestBody {
  const factory _FilterSearchResultsRequestBody(
          {@JsonKey(name: 'filter') required final String filter}) =
      _$_FilterSearchResultsRequestBody;
  const _FilterSearchResultsRequestBody._() : super._();

  factory _FilterSearchResultsRequestBody.fromJson(Map<String, dynamic> json) =
      _$_FilterSearchResultsRequestBody.fromJson;

  @override
  @JsonKey(name: 'filter')
  String get filter;
  @override
  @JsonKey(ignore: true)
  _$$_FilterSearchResultsRequestBodyCopyWith<_$_FilterSearchResultsRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}
