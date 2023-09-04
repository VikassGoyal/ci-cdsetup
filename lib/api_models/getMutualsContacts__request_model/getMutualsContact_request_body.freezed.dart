// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'getMutualsContact_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetMutualsContactRequestBody _$GetMutualsContactRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _GetMutualsContactRequestBody.fromJson(json);
}

/// @nodoc
mixin _$GetMutualsContactRequestBody {
  @JsonKey(name: "to_id")
  int? get to_id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetMutualsContactRequestBodyCopyWith<GetMutualsContactRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetMutualsContactRequestBodyCopyWith<$Res> {
  factory $GetMutualsContactRequestBodyCopyWith(
          GetMutualsContactRequestBody value,
          $Res Function(GetMutualsContactRequestBody) then) =
      _$GetMutualsContactRequestBodyCopyWithImpl<$Res,
          GetMutualsContactRequestBody>;
  @useResult
  $Res call({@JsonKey(name: "to_id") int? to_id});
}

/// @nodoc
class _$GetMutualsContactRequestBodyCopyWithImpl<$Res,
        $Val extends GetMutualsContactRequestBody>
    implements $GetMutualsContactRequestBodyCopyWith<$Res> {
  _$GetMutualsContactRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to_id = freezed,
  }) {
    return _then(_value.copyWith(
      to_id: freezed == to_id
          ? _value.to_id
          : to_id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetMutualsContactRequestBodyCopyWith<$Res>
    implements $GetMutualsContactRequestBodyCopyWith<$Res> {
  factory _$$_GetMutualsContactRequestBodyCopyWith(
          _$_GetMutualsContactRequestBody value,
          $Res Function(_$_GetMutualsContactRequestBody) then) =
      __$$_GetMutualsContactRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "to_id") int? to_id});
}

/// @nodoc
class __$$_GetMutualsContactRequestBodyCopyWithImpl<$Res>
    extends _$GetMutualsContactRequestBodyCopyWithImpl<$Res,
        _$_GetMutualsContactRequestBody>
    implements _$$_GetMutualsContactRequestBodyCopyWith<$Res> {
  __$$_GetMutualsContactRequestBodyCopyWithImpl(
      _$_GetMutualsContactRequestBody _value,
      $Res Function(_$_GetMutualsContactRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to_id = freezed,
  }) {
    return _then(_$_GetMutualsContactRequestBody(
      to_id: freezed == to_id
          ? _value.to_id
          : to_id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_GetMutualsContactRequestBody extends _GetMutualsContactRequestBody {
  const _$_GetMutualsContactRequestBody(
      {@JsonKey(name: "to_id") required this.to_id})
      : super._();

  factory _$_GetMutualsContactRequestBody.fromJson(Map<String, dynamic> json) =>
      _$$_GetMutualsContactRequestBodyFromJson(json);

  @override
  @JsonKey(name: "to_id")
  final int? to_id;

  @override
  String toString() {
    return 'GetMutualsContactRequestBody(to_id: $to_id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetMutualsContactRequestBody &&
            (identical(other.to_id, to_id) || other.to_id == to_id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, to_id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetMutualsContactRequestBodyCopyWith<_$_GetMutualsContactRequestBody>
      get copyWith => __$$_GetMutualsContactRequestBodyCopyWithImpl<
          _$_GetMutualsContactRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetMutualsContactRequestBodyToJson(
      this,
    );
  }
}

abstract class _GetMutualsContactRequestBody
    extends GetMutualsContactRequestBody {
  const factory _GetMutualsContactRequestBody(
          {@JsonKey(name: "to_id") required final int? to_id}) =
      _$_GetMutualsContactRequestBody;
  const _GetMutualsContactRequestBody._() : super._();

  factory _GetMutualsContactRequestBody.fromJson(Map<String, dynamic> json) =
      _$_GetMutualsContactRequestBody.fromJson;

  @override
  @JsonKey(name: "to_id")
  int? get to_id;
  @override
  @JsonKey(ignore: true)
  _$$_GetMutualsContactRequestBodyCopyWith<_$_GetMutualsContactRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}
