// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'changepassword_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChangePasswordRequestBody _$ChangePasswordRequestBodyFromJson(Map<String, dynamic> json) {
  return _ChangePasswordRequestBody.fromJson(json);
}

/// @nodoc
mixin _$ChangePasswordRequestBody {
  @JsonKey(name: 'oldpassword')
  String get oldpassword => throw _privateConstructorUsedError;
  @JsonKey(name: 'newpassword')
  String get newpassword => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChangePasswordRequestBodyCopyWith<ChangePasswordRequestBody> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePasswordRequestBodyCopyWith<$Res> {
  factory $ChangePasswordRequestBodyCopyWith(
          ChangePasswordRequestBody value, $Res Function(ChangePasswordRequestBody) then) =
      _$ChangePasswordRequestBodyCopyWithImpl<$Res, ChangePasswordRequestBody>;
  @useResult
  $Res call({@JsonKey(name: 'oldpassword') String oldpassword, @JsonKey(name: 'newpassword') String newpassword});
}

/// @nodoc
class _$ChangePasswordRequestBodyCopyWithImpl<$Res, $Val extends ChangePasswordRequestBody>
    implements $ChangePasswordRequestBodyCopyWith<$Res> {
  _$ChangePasswordRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldpassword = null,
    Object? newpassword = null,
  }) {
    return _then(_value.copyWith(
      oldpassword: null == oldpassword
          ? _value.oldpassword
          : oldpassword // ignore: cast_nullable_to_non_nullable
              as String,
      newpassword: null == newpassword
          ? _value.newpassword
          : newpassword // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChangePasswordRequestBodyCopyWith<$Res> implements $ChangePasswordRequestBodyCopyWith<$Res> {
  factory _$$_ChangePasswordRequestBodyCopyWith(
          _$_ChangePasswordRequestBody value, $Res Function(_$_ChangePasswordRequestBody) then) =
      __$$_ChangePasswordRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'oldpassword') String oldpassword, @JsonKey(name: 'newpassword') String newpassword});
}

/// @nodoc
class __$$_ChangePasswordRequestBodyCopyWithImpl<$Res>
    extends _$ChangePasswordRequestBodyCopyWithImpl<$Res, _$_ChangePasswordRequestBody>
    implements _$$_ChangePasswordRequestBodyCopyWith<$Res> {
  __$$_ChangePasswordRequestBodyCopyWithImpl(
      _$_ChangePasswordRequestBody _value, $Res Function(_$_ChangePasswordRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldpassword = null,
    Object? newpassword = null,
  }) {
    return _then(_$_ChangePasswordRequestBody(
      oldpassword: null == oldpassword
          ? _value.oldpassword
          : oldpassword // ignore: cast_nullable_to_non_nullable
              as String,
      newpassword: null == newpassword
          ? _value.newpassword
          : newpassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_ChangePasswordRequestBody extends _ChangePasswordRequestBody {
  const _$_ChangePasswordRequestBody(
      {@JsonKey(name: 'oldpassword') required this.oldpassword,
      @JsonKey(name: 'newpassword') required this.newpassword})
      : super._();

  factory _$_ChangePasswordRequestBody.fromJson(Map<String, dynamic> json) =>
      _$$_ChangePasswordRequestBodyFromJson(json);

  @override
  @JsonKey(name: 'oldpassword')
  final String oldpassword;
  @override
  @JsonKey(name: 'newpassword')
  final String newpassword;

  @override
  String toString() {
    return 'ChangePasswordRequestBody(oldpassword: $oldpassword, newpassword: $newpassword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangePasswordRequestBody &&
            (identical(other.oldpassword, oldpassword) || other.oldpassword == oldpassword) &&
            (identical(other.newpassword, newpassword) || other.newpassword == newpassword));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, oldpassword, newpassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChangePasswordRequestBodyCopyWith<_$_ChangePasswordRequestBody> get copyWith =>
      __$$_ChangePasswordRequestBodyCopyWithImpl<_$_ChangePasswordRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChangePasswordRequestBodyToJson(
      this,
    );
  }
}

abstract class _ChangePasswordRequestBody extends ChangePasswordRequestBody {
  const factory _ChangePasswordRequestBody(
      {@JsonKey(name: 'oldpassword') required final String oldpassword,
      @JsonKey(name: 'newpassword') required final String newpassword}) = _$_ChangePasswordRequestBody;
  const _ChangePasswordRequestBody._() : super._();

  factory _ChangePasswordRequestBody.fromJson(Map<String, dynamic> json) = _$_ChangePasswordRequestBody.fromJson;

  @override
  @JsonKey(name: 'oldpassword')
  String get oldpassword;
  @override
  @JsonKey(name: 'newpassword')
  String get newpassword;
  @override
  @JsonKey(ignore: true)
  _$$_ChangePasswordRequestBodyCopyWith<_$_ChangePasswordRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}
