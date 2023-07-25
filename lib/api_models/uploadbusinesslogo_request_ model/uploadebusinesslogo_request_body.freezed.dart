// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'uploadebusinesslogo_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UploadbusinesslogoRequestBody _$UploadbusinesslogoRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _UploadbusinesslogoRequestBody.fromJson(json);
}

/// @nodoc
mixin _$UploadbusinesslogoRequestBody {
  @JsonKey(name: 'base64data_logo')
  dynamic get base64data_logo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UploadbusinesslogoRequestBodyCopyWith<UploadbusinesslogoRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadbusinesslogoRequestBodyCopyWith<$Res> {
  factory $UploadbusinesslogoRequestBodyCopyWith(
          UploadbusinesslogoRequestBody value,
          $Res Function(UploadbusinesslogoRequestBody) then) =
      _$UploadbusinesslogoRequestBodyCopyWithImpl<$Res,
          UploadbusinesslogoRequestBody>;
  @useResult
  $Res call({@JsonKey(name: 'base64data_logo') dynamic base64data_logo});
}

/// @nodoc
class _$UploadbusinesslogoRequestBodyCopyWithImpl<$Res,
        $Val extends UploadbusinesslogoRequestBody>
    implements $UploadbusinesslogoRequestBodyCopyWith<$Res> {
  _$UploadbusinesslogoRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? base64data_logo = freezed,
  }) {
    return _then(_value.copyWith(
      base64data_logo: freezed == base64data_logo
          ? _value.base64data_logo
          : base64data_logo // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UploadbusinesslogoRequestBodyCopyWith<$Res>
    implements $UploadbusinesslogoRequestBodyCopyWith<$Res> {
  factory _$$_UploadbusinesslogoRequestBodyCopyWith(
          _$_UploadbusinesslogoRequestBody value,
          $Res Function(_$_UploadbusinesslogoRequestBody) then) =
      __$$_UploadbusinesslogoRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'base64data_logo') dynamic base64data_logo});
}

/// @nodoc
class __$$_UploadbusinesslogoRequestBodyCopyWithImpl<$Res>
    extends _$UploadbusinesslogoRequestBodyCopyWithImpl<$Res,
        _$_UploadbusinesslogoRequestBody>
    implements _$$_UploadbusinesslogoRequestBodyCopyWith<$Res> {
  __$$_UploadbusinesslogoRequestBodyCopyWithImpl(
      _$_UploadbusinesslogoRequestBody _value,
      $Res Function(_$_UploadbusinesslogoRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? base64data_logo = freezed,
  }) {
    return _then(_$_UploadbusinesslogoRequestBody(
      base64data_logo: freezed == base64data_logo
          ? _value.base64data_logo
          : base64data_logo // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_UploadbusinesslogoRequestBody
    implements _UploadbusinesslogoRequestBody {
  const _$_UploadbusinesslogoRequestBody(
      {@JsonKey(name: 'base64data_logo') required this.base64data_logo});

  factory _$_UploadbusinesslogoRequestBody.fromJson(
          Map<String, dynamic> json) =>
      _$$_UploadbusinesslogoRequestBodyFromJson(json);

  @override
  @JsonKey(name: 'base64data_logo')
  final dynamic base64data_logo;

  @override
  String toString() {
    return 'UploadbusinesslogoRequestBody(base64data_logo: $base64data_logo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UploadbusinesslogoRequestBody &&
            const DeepCollectionEquality()
                .equals(other.base64data_logo, base64data_logo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(base64data_logo));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UploadbusinesslogoRequestBodyCopyWith<_$_UploadbusinesslogoRequestBody>
      get copyWith => __$$_UploadbusinesslogoRequestBodyCopyWithImpl<
          _$_UploadbusinesslogoRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UploadbusinesslogoRequestBodyToJson(
      this,
    );
  }
}

abstract class _UploadbusinesslogoRequestBody
    implements UploadbusinesslogoRequestBody {
  const factory _UploadbusinesslogoRequestBody(
          {@JsonKey(name: 'base64data_logo')
          required final dynamic base64data_logo}) =
      _$_UploadbusinesslogoRequestBody;

  factory _UploadbusinesslogoRequestBody.fromJson(Map<String, dynamic> json) =
      _$_UploadbusinesslogoRequestBody.fromJson;

  @override
  @JsonKey(name: 'base64data_logo')
  dynamic get base64data_logo;
  @override
  @JsonKey(ignore: true)
  _$$_UploadbusinesslogoRequestBodyCopyWith<_$_UploadbusinesslogoRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}
