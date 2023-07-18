// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'getProfileDetails_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetProfileDetailsRequestBody _$GetProfileDetailsRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _GetProfileDetailsRequestBody.fromJson(json);
}

/// @nodoc
mixin _$GetProfileDetailsRequestBody {
  @JsonKey(name: 'phone')
  String get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetProfileDetailsRequestBodyCopyWith<GetProfileDetailsRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetProfileDetailsRequestBodyCopyWith<$Res> {
  factory $GetProfileDetailsRequestBodyCopyWith(
          GetProfileDetailsRequestBody value,
          $Res Function(GetProfileDetailsRequestBody) then) =
      _$GetProfileDetailsRequestBodyCopyWithImpl<$Res,
          GetProfileDetailsRequestBody>;
  @useResult
  $Res call({@JsonKey(name: 'phone') String phone});
}

/// @nodoc
class _$GetProfileDetailsRequestBodyCopyWithImpl<$Res,
        $Val extends GetProfileDetailsRequestBody>
    implements $GetProfileDetailsRequestBodyCopyWith<$Res> {
  _$GetProfileDetailsRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
  }) {
    return _then(_value.copyWith(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetProfileDetailsRequestBodyCopyWith<$Res>
    implements $GetProfileDetailsRequestBodyCopyWith<$Res> {
  factory _$$_GetProfileDetailsRequestBodyCopyWith(
          _$_GetProfileDetailsRequestBody value,
          $Res Function(_$_GetProfileDetailsRequestBody) then) =
      __$$_GetProfileDetailsRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'phone') String phone});
}

/// @nodoc
class __$$_GetProfileDetailsRequestBodyCopyWithImpl<$Res>
    extends _$GetProfileDetailsRequestBodyCopyWithImpl<$Res,
        _$_GetProfileDetailsRequestBody>
    implements _$$_GetProfileDetailsRequestBodyCopyWith<$Res> {
  __$$_GetProfileDetailsRequestBodyCopyWithImpl(
      _$_GetProfileDetailsRequestBody _value,
      $Res Function(_$_GetProfileDetailsRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
  }) {
    return _then(_$_GetProfileDetailsRequestBody(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_GetProfileDetailsRequestBody extends _GetProfileDetailsRequestBody {
  const _$_GetProfileDetailsRequestBody(
      {@JsonKey(name: 'phone') required this.phone})
      : super._();

  factory _$_GetProfileDetailsRequestBody.fromJson(Map<String, dynamic> json) =>
      _$$_GetProfileDetailsRequestBodyFromJson(json);

  @override
  @JsonKey(name: 'phone')
  final String phone;

  @override
  String toString() {
    return 'GetProfileDetailsRequestBody(phone: $phone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetProfileDetailsRequestBody &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetProfileDetailsRequestBodyCopyWith<_$_GetProfileDetailsRequestBody>
      get copyWith => __$$_GetProfileDetailsRequestBodyCopyWithImpl<
          _$_GetProfileDetailsRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetProfileDetailsRequestBodyToJson(
      this,
    );
  }
}

abstract class _GetProfileDetailsRequestBody
    extends GetProfileDetailsRequestBody {
  const factory _GetProfileDetailsRequestBody(
          {@JsonKey(name: 'phone') required final String phone}) =
      _$_GetProfileDetailsRequestBody;
  const _GetProfileDetailsRequestBody._() : super._();

  factory _GetProfileDetailsRequestBody.fromJson(Map<String, dynamic> json) =
      _$_GetProfileDetailsRequestBody.fromJson;

  @override
  @JsonKey(name: 'phone')
  String get phone;
  @override
  @JsonKey(ignore: true)
  _$$_GetProfileDetailsRequestBodyCopyWith<_$_GetProfileDetailsRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}
