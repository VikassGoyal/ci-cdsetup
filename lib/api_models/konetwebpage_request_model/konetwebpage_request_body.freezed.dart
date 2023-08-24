// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'konetwebpage_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KonetwebpageRequestBody _$KonetwebpageRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _KonetwebpageRequestBody.fromJson(json);
}

/// @nodoc
mixin _$KonetwebpageRequestBody {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KonetwebpageRequestBodyCopyWith<KonetwebpageRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KonetwebpageRequestBodyCopyWith<$Res> {
  factory $KonetwebpageRequestBodyCopyWith(KonetwebpageRequestBody value,
          $Res Function(KonetwebpageRequestBody) then) =
      _$KonetwebpageRequestBodyCopyWithImpl<$Res, KonetwebpageRequestBody>;
  @useResult
  $Res call({@JsonKey(name: 'id') String id});
}

/// @nodoc
class _$KonetwebpageRequestBodyCopyWithImpl<$Res,
        $Val extends KonetwebpageRequestBody>
    implements $KonetwebpageRequestBodyCopyWith<$Res> {
  _$KonetwebpageRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_KonetwebpageRequestBodyCopyWith<$Res>
    implements $KonetwebpageRequestBodyCopyWith<$Res> {
  factory _$$_KonetwebpageRequestBodyCopyWith(_$_KonetwebpageRequestBody value,
          $Res Function(_$_KonetwebpageRequestBody) then) =
      __$$_KonetwebpageRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'id') String id});
}

/// @nodoc
class __$$_KonetwebpageRequestBodyCopyWithImpl<$Res>
    extends _$KonetwebpageRequestBodyCopyWithImpl<$Res,
        _$_KonetwebpageRequestBody>
    implements _$$_KonetwebpageRequestBodyCopyWith<$Res> {
  __$$_KonetwebpageRequestBodyCopyWithImpl(_$_KonetwebpageRequestBody _value,
      $Res Function(_$_KonetwebpageRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$_KonetwebpageRequestBody(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_KonetwebpageRequestBody extends _KonetwebpageRequestBody {
  const _$_KonetwebpageRequestBody({@JsonKey(name: 'id') required this.id})
      : super._();

  factory _$_KonetwebpageRequestBody.fromJson(Map<String, dynamic> json) =>
      _$$_KonetwebpageRequestBodyFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;

  @override
  String toString() {
    return 'KonetwebpageRequestBody(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_KonetwebpageRequestBody &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_KonetwebpageRequestBodyCopyWith<_$_KonetwebpageRequestBody>
      get copyWith =>
          __$$_KonetwebpageRequestBodyCopyWithImpl<_$_KonetwebpageRequestBody>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_KonetwebpageRequestBodyToJson(
      this,
    );
  }
}

abstract class _KonetwebpageRequestBody extends KonetwebpageRequestBody {
  const factory _KonetwebpageRequestBody(
          {@JsonKey(name: 'id') required final String id}) =
      _$_KonetwebpageRequestBody;
  const _KonetwebpageRequestBody._() : super._();

  factory _KonetwebpageRequestBody.fromJson(Map<String, dynamic> json) =
      _$_KonetwebpageRequestBody.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_KonetwebpageRequestBodyCopyWith<_$_KonetwebpageRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}
