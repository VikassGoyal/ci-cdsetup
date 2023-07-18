// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'uploadProfileImage_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UploadProfileImageRequestBody _$UploadProfileImageRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _UploadProfileImageRequestBody.fromJson(json);
}

/// @nodoc
mixin _$UploadProfileImageRequestBody {
  @JsonKey(name: 'base64data_profile')
  String get base64data_profile => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UploadProfileImageRequestBodyCopyWith<UploadProfileImageRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadProfileImageRequestBodyCopyWith<$Res> {
  factory $UploadProfileImageRequestBodyCopyWith(
          UploadProfileImageRequestBody value,
          $Res Function(UploadProfileImageRequestBody) then) =
      _$UploadProfileImageRequestBodyCopyWithImpl<$Res,
          UploadProfileImageRequestBody>;
  @useResult
  $Res call({@JsonKey(name: 'base64data_profile') String base64data_profile});
}

/// @nodoc
class _$UploadProfileImageRequestBodyCopyWithImpl<$Res,
        $Val extends UploadProfileImageRequestBody>
    implements $UploadProfileImageRequestBodyCopyWith<$Res> {
  _$UploadProfileImageRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? base64data_profile = null,
  }) {
    return _then(_value.copyWith(
      base64data_profile: null == base64data_profile
          ? _value.base64data_profile
          : base64data_profile // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UploadProfileImageRequestBodyCopyWith<$Res>
    implements $UploadProfileImageRequestBodyCopyWith<$Res> {
  factory _$$_UploadProfileImageRequestBodyCopyWith(
          _$_UploadProfileImageRequestBody value,
          $Res Function(_$_UploadProfileImageRequestBody) then) =
      __$$_UploadProfileImageRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'base64data_profile') String base64data_profile});
}

/// @nodoc
class __$$_UploadProfileImageRequestBodyCopyWithImpl<$Res>
    extends _$UploadProfileImageRequestBodyCopyWithImpl<$Res,
        _$_UploadProfileImageRequestBody>
    implements _$$_UploadProfileImageRequestBodyCopyWith<$Res> {
  __$$_UploadProfileImageRequestBodyCopyWithImpl(
      _$_UploadProfileImageRequestBody _value,
      $Res Function(_$_UploadProfileImageRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? base64data_profile = null,
  }) {
    return _then(_$_UploadProfileImageRequestBody(
      base64data_profile: null == base64data_profile
          ? _value.base64data_profile
          : base64data_profile // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_UploadProfileImageRequestBody
    implements _UploadProfileImageRequestBody {
  const _$_UploadProfileImageRequestBody(
      {@JsonKey(name: 'base64data_profile') required this.base64data_profile});

  factory _$_UploadProfileImageRequestBody.fromJson(
          Map<String, dynamic> json) =>
      _$$_UploadProfileImageRequestBodyFromJson(json);

  @override
  @JsonKey(name: 'base64data_profile')
  final String base64data_profile;

  @override
  String toString() {
    return 'UploadProfileImageRequestBody(base64data_profile: $base64data_profile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UploadProfileImageRequestBody &&
            (identical(other.base64data_profile, base64data_profile) ||
                other.base64data_profile == base64data_profile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, base64data_profile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UploadProfileImageRequestBodyCopyWith<_$_UploadProfileImageRequestBody>
      get copyWith => __$$_UploadProfileImageRequestBodyCopyWithImpl<
          _$_UploadProfileImageRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UploadProfileImageRequestBodyToJson(
      this,
    );
  }
}

abstract class _UploadProfileImageRequestBody
    implements UploadProfileImageRequestBody {
  const factory _UploadProfileImageRequestBody(
          {@JsonKey(name: 'base64data_profile')
          required final String base64data_profile}) =
      _$_UploadProfileImageRequestBody;

  factory _UploadProfileImageRequestBody.fromJson(Map<String, dynamic> json) =
      _$_UploadProfileImageRequestBody.fromJson;

  @override
  @JsonKey(name: 'base64data_profile')
  String get base64data_profile;
  @override
  @JsonKey(ignore: true)
  _$$_UploadProfileImageRequestBodyCopyWith<_$_UploadProfileImageRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}
