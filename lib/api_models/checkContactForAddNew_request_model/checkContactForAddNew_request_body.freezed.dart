// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkContactForAddNew_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CheckContactForAddNewRequestBody _$CheckContactForAddNewRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _CheckContactForAddNewRequestBody.fromJson(json);
}

/// @nodoc
mixin _$CheckContactForAddNewRequestBody {
  @JsonKey(name: 'phone')
  String get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckContactForAddNewRequestBodyCopyWith<CheckContactForAddNewRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckContactForAddNewRequestBodyCopyWith<$Res> {
  factory $CheckContactForAddNewRequestBodyCopyWith(
          CheckContactForAddNewRequestBody value,
          $Res Function(CheckContactForAddNewRequestBody) then) =
      _$CheckContactForAddNewRequestBodyCopyWithImpl<$Res,
          CheckContactForAddNewRequestBody>;
  @useResult
  $Res call({@JsonKey(name: 'phone') String phone});
}

/// @nodoc
class _$CheckContactForAddNewRequestBodyCopyWithImpl<$Res,
        $Val extends CheckContactForAddNewRequestBody>
    implements $CheckContactForAddNewRequestBodyCopyWith<$Res> {
  _$CheckContactForAddNewRequestBodyCopyWithImpl(this._value, this._then);

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
abstract class _$$_CheckContactForAddNewRequestBodyCopyWith<$Res>
    implements $CheckContactForAddNewRequestBodyCopyWith<$Res> {
  factory _$$_CheckContactForAddNewRequestBodyCopyWith(
          _$_CheckContactForAddNewRequestBody value,
          $Res Function(_$_CheckContactForAddNewRequestBody) then) =
      __$$_CheckContactForAddNewRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'phone') String phone});
}

/// @nodoc
class __$$_CheckContactForAddNewRequestBodyCopyWithImpl<$Res>
    extends _$CheckContactForAddNewRequestBodyCopyWithImpl<$Res,
        _$_CheckContactForAddNewRequestBody>
    implements _$$_CheckContactForAddNewRequestBodyCopyWith<$Res> {
  __$$_CheckContactForAddNewRequestBodyCopyWithImpl(
      _$_CheckContactForAddNewRequestBody _value,
      $Res Function(_$_CheckContactForAddNewRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
  }) {
    return _then(_$_CheckContactForAddNewRequestBody(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_CheckContactForAddNewRequestBody
    extends _CheckContactForAddNewRequestBody {
  const _$_CheckContactForAddNewRequestBody(
      {@JsonKey(name: 'phone') required this.phone})
      : super._();

  factory _$_CheckContactForAddNewRequestBody.fromJson(
          Map<String, dynamic> json) =>
      _$$_CheckContactForAddNewRequestBodyFromJson(json);

  @override
  @JsonKey(name: 'phone')
  final String phone;

  @override
  String toString() {
    return 'CheckContactForAddNewRequestBody(phone: $phone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CheckContactForAddNewRequestBody &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CheckContactForAddNewRequestBodyCopyWith<
          _$_CheckContactForAddNewRequestBody>
      get copyWith => __$$_CheckContactForAddNewRequestBodyCopyWithImpl<
          _$_CheckContactForAddNewRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CheckContactForAddNewRequestBodyToJson(
      this,
    );
  }
}

abstract class _CheckContactForAddNewRequestBody
    extends CheckContactForAddNewRequestBody {
  const factory _CheckContactForAddNewRequestBody(
          {@JsonKey(name: 'phone') required final String phone}) =
      _$_CheckContactForAddNewRequestBody;
  const _CheckContactForAddNewRequestBody._() : super._();

  factory _CheckContactForAddNewRequestBody.fromJson(
      Map<String, dynamic> json) = _$_CheckContactForAddNewRequestBody.fromJson;

  @override
  @JsonKey(name: 'phone')
  String get phone;
  @override
  @JsonKey(ignore: true)
  _$$_CheckContactForAddNewRequestBodyCopyWith<
          _$_CheckContactForAddNewRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}
