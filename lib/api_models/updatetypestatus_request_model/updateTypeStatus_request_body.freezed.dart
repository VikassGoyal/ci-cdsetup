// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'updateTypeStatus_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UpdateTypeStatusRequestBody _$UpdateTypeStatusRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _UpdateTypeStatusRequestBody.fromJson(json);
}

/// @nodoc
mixin _$UpdateTypeStatusRequestBody {
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateTypeStatusRequestBodyCopyWith<UpdateTypeStatusRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateTypeStatusRequestBodyCopyWith<$Res> {
  factory $UpdateTypeStatusRequestBodyCopyWith(
          UpdateTypeStatusRequestBody value,
          $Res Function(UpdateTypeStatusRequestBody) then) =
      _$UpdateTypeStatusRequestBodyCopyWithImpl<$Res,
          UpdateTypeStatusRequestBody>;
  @useResult
  $Res call({@JsonKey(name: 'id') int? id, @JsonKey(name: 'type') String type});
}

/// @nodoc
class _$UpdateTypeStatusRequestBodyCopyWithImpl<$Res,
        $Val extends UpdateTypeStatusRequestBody>
    implements $UpdateTypeStatusRequestBodyCopyWith<$Res> {
  _$UpdateTypeStatusRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UpdateTypeStatusRequestBodyCopyWith<$Res>
    implements $UpdateTypeStatusRequestBodyCopyWith<$Res> {
  factory _$$_UpdateTypeStatusRequestBodyCopyWith(
          _$_UpdateTypeStatusRequestBody value,
          $Res Function(_$_UpdateTypeStatusRequestBody) then) =
      __$$_UpdateTypeStatusRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'id') int? id, @JsonKey(name: 'type') String type});
}

/// @nodoc
class __$$_UpdateTypeStatusRequestBodyCopyWithImpl<$Res>
    extends _$UpdateTypeStatusRequestBodyCopyWithImpl<$Res,
        _$_UpdateTypeStatusRequestBody>
    implements _$$_UpdateTypeStatusRequestBodyCopyWith<$Res> {
  __$$_UpdateTypeStatusRequestBodyCopyWithImpl(
      _$_UpdateTypeStatusRequestBody _value,
      $Res Function(_$_UpdateTypeStatusRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = null,
  }) {
    return _then(_$_UpdateTypeStatusRequestBody(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_UpdateTypeStatusRequestBody implements _UpdateTypeStatusRequestBody {
  const _$_UpdateTypeStatusRequestBody(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'type') required this.type});

  factory _$_UpdateTypeStatusRequestBody.fromJson(Map<String, dynamic> json) =>
      _$$_UpdateTypeStatusRequestBodyFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'type')
  final String type;

  @override
  String toString() {
    return 'UpdateTypeStatusRequestBody(id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateTypeStatusRequestBody &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateTypeStatusRequestBodyCopyWith<_$_UpdateTypeStatusRequestBody>
      get copyWith => __$$_UpdateTypeStatusRequestBodyCopyWithImpl<
          _$_UpdateTypeStatusRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UpdateTypeStatusRequestBodyToJson(
      this,
    );
  }
}

abstract class _UpdateTypeStatusRequestBody
    implements UpdateTypeStatusRequestBody {
  const factory _UpdateTypeStatusRequestBody(
          {@JsonKey(name: 'id') required final int? id,
          @JsonKey(name: 'type') required final String type}) =
      _$_UpdateTypeStatusRequestBody;

  factory _UpdateTypeStatusRequestBody.fromJson(Map<String, dynamic> json) =
      _$_UpdateTypeStatusRequestBody.fromJson;

  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(name: 'type')
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateTypeStatusRequestBodyCopyWith<_$_UpdateTypeStatusRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}
