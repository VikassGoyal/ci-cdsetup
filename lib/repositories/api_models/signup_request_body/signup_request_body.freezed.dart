// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SignupRequestBody _$SignupRequestBodyFromJson(Map<String, dynamic> json) {
  return _SignupRequestBody.fromJson(json);
}

/// @nodoc
mixin _$SignupRequestBody {
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone')
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'password')
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignupRequestBodyCopyWith<SignupRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupRequestBodyCopyWith<$Res> {
  factory $SignupRequestBodyCopyWith(
          SignupRequestBody value, $Res Function(SignupRequestBody) then) =
      _$SignupRequestBodyCopyWithImpl<$Res, SignupRequestBody>;
  @useResult
  $Res call(
      {@JsonKey(name: 'username') String username,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'phone') String phone,
      @JsonKey(name: 'password') String password});
}

/// @nodoc
class _$SignupRequestBodyCopyWithImpl<$Res, $Val extends SignupRequestBody>
    implements $SignupRequestBodyCopyWith<$Res> {
  _$SignupRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? phone = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SignupRequestBodyCopyWith<$Res>
    implements $SignupRequestBodyCopyWith<$Res> {
  factory _$$_SignupRequestBodyCopyWith(_$_SignupRequestBody value,
          $Res Function(_$_SignupRequestBody) then) =
      __$$_SignupRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'username') String username,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'phone') String phone,
      @JsonKey(name: 'password') String password});
}

/// @nodoc
class __$$_SignupRequestBodyCopyWithImpl<$Res>
    extends _$SignupRequestBodyCopyWithImpl<$Res, _$_SignupRequestBody>
    implements _$$_SignupRequestBodyCopyWith<$Res> {
  __$$_SignupRequestBodyCopyWithImpl(
      _$_SignupRequestBody _value, $Res Function(_$_SignupRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? phone = null,
    Object? password = null,
  }) {
    return _then(_$_SignupRequestBody(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_SignupRequestBody extends _SignupRequestBody {
  const _$_SignupRequestBody(
      {@JsonKey(name: 'username') required this.username,
      @JsonKey(name: 'email') required this.email,
      @JsonKey(name: 'phone') required this.phone,
      @JsonKey(name: 'password') required this.password})
      : super._();

  factory _$_SignupRequestBody.fromJson(Map<String, dynamic> json) =>
      _$$_SignupRequestBodyFromJson(json);

  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'email')
  final String email;
  @override
  @JsonKey(name: 'phone')
  final String phone;
  @override
  @JsonKey(name: 'password')
  final String password;

  @override
  String toString() {
    return 'SignupRequestBody(username: $username, email: $email, phone: $phone, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignupRequestBody &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, username, email, phone, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignupRequestBodyCopyWith<_$_SignupRequestBody> get copyWith =>
      __$$_SignupRequestBodyCopyWithImpl<_$_SignupRequestBody>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SignupRequestBodyToJson(
      this,
    );
  }
}

abstract class _SignupRequestBody extends SignupRequestBody {
  const factory _SignupRequestBody(
          {@JsonKey(name: 'username') required final String username,
          @JsonKey(name: 'email') required final String email,
          @JsonKey(name: 'phone') required final String phone,
          @JsonKey(name: 'password') required final String password}) =
      _$_SignupRequestBody;
  const _SignupRequestBody._() : super._();

  factory _SignupRequestBody.fromJson(Map<String, dynamic> json) =
      _$_SignupRequestBody.fromJson;

  @override
  @JsonKey(name: 'username')
  String get username;
  @override
  @JsonKey(name: 'email')
  String get email;
  @override
  @JsonKey(name: 'phone')
  String get phone;
  @override
  @JsonKey(name: 'password')
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_SignupRequestBodyCopyWith<_$_SignupRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}
