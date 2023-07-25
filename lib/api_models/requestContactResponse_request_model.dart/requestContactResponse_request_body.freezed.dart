// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'requestContactResponse_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RequestContactResponseRequestBody _$RequestContactResponseRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _RequestContactResponseRequestBody.fromJson(json);
}

/// @nodoc
mixin _$RequestContactResponseRequestBody {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'responseid')
  dynamic get responseid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestContactResponseRequestBodyCopyWith<RequestContactResponseRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestContactResponseRequestBodyCopyWith<$Res> {
  factory $RequestContactResponseRequestBodyCopyWith(
          RequestContactResponseRequestBody value,
          $Res Function(RequestContactResponseRequestBody) then) =
      _$RequestContactResponseRequestBodyCopyWithImpl<$Res,
          RequestContactResponseRequestBody>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'responseid') dynamic responseid});
}

/// @nodoc
class _$RequestContactResponseRequestBodyCopyWithImpl<$Res,
        $Val extends RequestContactResponseRequestBody>
    implements $RequestContactResponseRequestBodyCopyWith<$Res> {
  _$RequestContactResponseRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? responseid = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      responseid: freezed == responseid
          ? _value.responseid
          : responseid // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RequestContactResponseRequestBodyCopyWith<$Res>
    implements $RequestContactResponseRequestBodyCopyWith<$Res> {
  factory _$$_RequestContactResponseRequestBodyCopyWith(
          _$_RequestContactResponseRequestBody value,
          $Res Function(_$_RequestContactResponseRequestBody) then) =
      __$$_RequestContactResponseRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'responseid') dynamic responseid});
}

/// @nodoc
class __$$_RequestContactResponseRequestBodyCopyWithImpl<$Res>
    extends _$RequestContactResponseRequestBodyCopyWithImpl<$Res,
        _$_RequestContactResponseRequestBody>
    implements _$$_RequestContactResponseRequestBodyCopyWith<$Res> {
  __$$_RequestContactResponseRequestBodyCopyWithImpl(
      _$_RequestContactResponseRequestBody _value,
      $Res Function(_$_RequestContactResponseRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? responseid = freezed,
  }) {
    return _then(_$_RequestContactResponseRequestBody(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      responseid: freezed == responseid
          ? _value.responseid
          : responseid // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_RequestContactResponseRequestBody
    implements _RequestContactResponseRequestBody {
  const _$_RequestContactResponseRequestBody(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'responseid') required this.responseid});

  factory _$_RequestContactResponseRequestBody.fromJson(
          Map<String, dynamic> json) =>
      _$$_RequestContactResponseRequestBodyFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'responseid')
  final dynamic responseid;

  @override
  String toString() {
    return 'RequestContactResponseRequestBody(id: $id, responseid: $responseid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RequestContactResponseRequestBody &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other.responseid, responseid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(responseid));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RequestContactResponseRequestBodyCopyWith<
          _$_RequestContactResponseRequestBody>
      get copyWith => __$$_RequestContactResponseRequestBodyCopyWithImpl<
          _$_RequestContactResponseRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RequestContactResponseRequestBodyToJson(
      this,
    );
  }
}

abstract class _RequestContactResponseRequestBody
    implements RequestContactResponseRequestBody {
  const factory _RequestContactResponseRequestBody(
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'responseid') required final dynamic responseid}) =
      _$_RequestContactResponseRequestBody;

  factory _RequestContactResponseRequestBody.fromJson(
          Map<String, dynamic> json) =
      _$_RequestContactResponseRequestBody.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'responseid')
  dynamic get responseid;
  @override
  @JsonKey(ignore: true)
  _$$_RequestContactResponseRequestBodyCopyWith<
          _$_RequestContactResponseRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}
