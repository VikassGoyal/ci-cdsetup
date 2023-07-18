// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgotpassword_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ForgotpasswordRequestBody _$ForgotpasswordRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _ForgotpasswordRequestBody.fromJson(json);
}

/// @nodoc
mixin _$ForgotpasswordRequestBody {
  @JsonKey(name: "email")
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForgotpasswordRequestBodyCopyWith<ForgotpasswordRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotpasswordRequestBodyCopyWith<$Res> {
  factory $ForgotpasswordRequestBodyCopyWith(ForgotpasswordRequestBody value,
          $Res Function(ForgotpasswordRequestBody) then) =
      _$ForgotpasswordRequestBodyCopyWithImpl<$Res, ForgotpasswordRequestBody>;
  @useResult
  $Res call({@JsonKey(name: "email") String email});
}

/// @nodoc
class _$ForgotpasswordRequestBodyCopyWithImpl<$Res,
        $Val extends ForgotpasswordRequestBody>
    implements $ForgotpasswordRequestBodyCopyWith<$Res> {
  _$ForgotpasswordRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ForgotpasswordRequestBodyCopyWith<$Res>
    implements $ForgotpasswordRequestBodyCopyWith<$Res> {
  factory _$$_ForgotpasswordRequestBodyCopyWith(
          _$_ForgotpasswordRequestBody value,
          $Res Function(_$_ForgotpasswordRequestBody) then) =
      __$$_ForgotpasswordRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "email") String email});
}

/// @nodoc
class __$$_ForgotpasswordRequestBodyCopyWithImpl<$Res>
    extends _$ForgotpasswordRequestBodyCopyWithImpl<$Res,
        _$_ForgotpasswordRequestBody>
    implements _$$_ForgotpasswordRequestBodyCopyWith<$Res> {
  __$$_ForgotpasswordRequestBodyCopyWithImpl(
      _$_ForgotpasswordRequestBody _value,
      $Res Function(_$_ForgotpasswordRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$_ForgotpasswordRequestBody(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_ForgotpasswordRequestBody extends _ForgotpasswordRequestBody {
  const _$_ForgotpasswordRequestBody(
      {@JsonKey(name: "email") required this.email})
      : super._();

  factory _$_ForgotpasswordRequestBody.fromJson(Map<String, dynamic> json) =>
      _$$_ForgotpasswordRequestBodyFromJson(json);

  @override
  @JsonKey(name: "email")
  final String email;

  @override
  String toString() {
    return 'ForgotpasswordRequestBody(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ForgotpasswordRequestBody &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ForgotpasswordRequestBodyCopyWith<_$_ForgotpasswordRequestBody>
      get copyWith => __$$_ForgotpasswordRequestBodyCopyWithImpl<
          _$_ForgotpasswordRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ForgotpasswordRequestBodyToJson(
      this,
    );
  }
}

abstract class _ForgotpasswordRequestBody extends ForgotpasswordRequestBody {
  const factory _ForgotpasswordRequestBody(
          {@JsonKey(name: "email") required final String email}) =
      _$_ForgotpasswordRequestBody;
  const _ForgotpasswordRequestBody._() : super._();

  factory _ForgotpasswordRequestBody.fromJson(Map<String, dynamic> json) =
      _$_ForgotpasswordRequestBody.fromJson;

  @override
  @JsonKey(name: "email")
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$_ForgotpasswordRequestBodyCopyWith<_$_ForgotpasswordRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}
