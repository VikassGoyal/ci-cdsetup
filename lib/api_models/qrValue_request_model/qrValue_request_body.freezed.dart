// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qrValue_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QrValueRequestBody _$QrValueRequestBodyFromJson(Map<String, dynamic> json) {
  return _QrValueRequestBody.fromJson(json);
}

/// @nodoc
mixin _$QrValueRequestBody {
  @JsonKey(name: 'value')
  String? get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'qrcode')
  bool get qrcode => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  dynamic get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'viaid')
  dynamic get viaid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QrValueRequestBodyCopyWith<QrValueRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrValueRequestBodyCopyWith<$Res> {
  factory $QrValueRequestBodyCopyWith(
          QrValueRequestBody value, $Res Function(QrValueRequestBody) then) =
      _$QrValueRequestBodyCopyWithImpl<$Res, QrValueRequestBody>;
  @useResult
  $Res call(
      {@JsonKey(name: 'value') String? value,
      @JsonKey(name: 'qrcode') bool qrcode,
      @JsonKey(name: 'content') dynamic content,
      @JsonKey(name: 'viaid') dynamic viaid});
}

/// @nodoc
class _$QrValueRequestBodyCopyWithImpl<$Res, $Val extends QrValueRequestBody>
    implements $QrValueRequestBodyCopyWith<$Res> {
  _$QrValueRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? qrcode = null,
    Object? content = freezed,
    Object? viaid = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      qrcode: null == qrcode
          ? _value.qrcode
          : qrcode // ignore: cast_nullable_to_non_nullable
              as bool,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as dynamic,
      viaid: freezed == viaid
          ? _value.viaid
          : viaid // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QrValueRequestBodyCopyWith<$Res>
    implements $QrValueRequestBodyCopyWith<$Res> {
  factory _$$_QrValueRequestBodyCopyWith(_$_QrValueRequestBody value,
          $Res Function(_$_QrValueRequestBody) then) =
      __$$_QrValueRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'value') String? value,
      @JsonKey(name: 'qrcode') bool qrcode,
      @JsonKey(name: 'content') dynamic content,
      @JsonKey(name: 'viaid') dynamic viaid});
}

/// @nodoc
class __$$_QrValueRequestBodyCopyWithImpl<$Res>
    extends _$QrValueRequestBodyCopyWithImpl<$Res, _$_QrValueRequestBody>
    implements _$$_QrValueRequestBodyCopyWith<$Res> {
  __$$_QrValueRequestBodyCopyWithImpl(
      _$_QrValueRequestBody _value, $Res Function(_$_QrValueRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? qrcode = null,
    Object? content = freezed,
    Object? viaid = freezed,
  }) {
    return _then(_$_QrValueRequestBody(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      qrcode: null == qrcode
          ? _value.qrcode
          : qrcode // ignore: cast_nullable_to_non_nullable
              as bool,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as dynamic,
      viaid: freezed == viaid
          ? _value.viaid
          : viaid // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_QrValueRequestBody implements _QrValueRequestBody {
  const _$_QrValueRequestBody(
      {@JsonKey(name: 'value') required this.value,
      @JsonKey(name: 'qrcode') required this.qrcode,
      @JsonKey(name: 'content') this.content,
      @JsonKey(name: 'viaid') this.viaid});

  factory _$_QrValueRequestBody.fromJson(Map<String, dynamic> json) =>
      _$$_QrValueRequestBodyFromJson(json);

  @override
  @JsonKey(name: 'value')
  final String? value;
  @override
  @JsonKey(name: 'qrcode')
  final bool qrcode;
  @override
  @JsonKey(name: 'content')
  final dynamic content;
  @override
  @JsonKey(name: 'viaid')
  final dynamic viaid;

  @override
  String toString() {
    return 'QrValueRequestBody(value: $value, qrcode: $qrcode, content: $content, viaid: $viaid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QrValueRequestBody &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.qrcode, qrcode) || other.qrcode == qrcode) &&
            const DeepCollectionEquality().equals(other.content, content) &&
            const DeepCollectionEquality().equals(other.viaid, viaid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      value,
      qrcode,
      const DeepCollectionEquality().hash(content),
      const DeepCollectionEquality().hash(viaid));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QrValueRequestBodyCopyWith<_$_QrValueRequestBody> get copyWith =>
      __$$_QrValueRequestBodyCopyWithImpl<_$_QrValueRequestBody>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QrValueRequestBodyToJson(
      this,
    );
  }
}

abstract class _QrValueRequestBody implements QrValueRequestBody {
  const factory _QrValueRequestBody(
      {@JsonKey(name: 'value') required final String? value,
      @JsonKey(name: 'qrcode') required final bool qrcode,
      @JsonKey(name: 'content') final dynamic content,
      @JsonKey(name: 'viaid') final dynamic viaid}) = _$_QrValueRequestBody;

  factory _QrValueRequestBody.fromJson(Map<String, dynamic> json) =
      _$_QrValueRequestBody.fromJson;

  @override
  @JsonKey(name: 'value')
  String? get value;
  @override
  @JsonKey(name: 'qrcode')
  bool get qrcode;
  @override
  @JsonKey(name: 'content')
  dynamic get content;
  @override
  @JsonKey(name: 'viaid')
  dynamic get viaid;
  @override
  @JsonKey(ignore: true)
  _$$_QrValueRequestBodyCopyWith<_$_QrValueRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}
