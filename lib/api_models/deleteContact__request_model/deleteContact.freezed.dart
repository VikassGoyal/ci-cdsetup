// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deleteContact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeleteContactdRequestBody _$DeleteContactdRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _DeleteContactdRequestBody.fromJson(json);
}

/// @nodoc
mixin _$DeleteContactdRequestBody {
  @JsonKey(name: "id")
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeleteContactdRequestBodyCopyWith<DeleteContactdRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteContactdRequestBodyCopyWith<$Res> {
  factory $DeleteContactdRequestBodyCopyWith(DeleteContactdRequestBody value,
          $Res Function(DeleteContactdRequestBody) then) =
      _$DeleteContactdRequestBodyCopyWithImpl<$Res, DeleteContactdRequestBody>;
  @useResult
  $Res call({@JsonKey(name: "id") String? id});
}

/// @nodoc
class _$DeleteContactdRequestBodyCopyWithImpl<$Res,
        $Val extends DeleteContactdRequestBody>
    implements $DeleteContactdRequestBodyCopyWith<$Res> {
  _$DeleteContactdRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeleteContactdRequestBodyCopyWith<$Res>
    implements $DeleteContactdRequestBodyCopyWith<$Res> {
  factory _$$_DeleteContactdRequestBodyCopyWith(
          _$_DeleteContactdRequestBody value,
          $Res Function(_$_DeleteContactdRequestBody) then) =
      __$$_DeleteContactdRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "id") String? id});
}

/// @nodoc
class __$$_DeleteContactdRequestBodyCopyWithImpl<$Res>
    extends _$DeleteContactdRequestBodyCopyWithImpl<$Res,
        _$_DeleteContactdRequestBody>
    implements _$$_DeleteContactdRequestBodyCopyWith<$Res> {
  __$$_DeleteContactdRequestBodyCopyWithImpl(
      _$_DeleteContactdRequestBody _value,
      $Res Function(_$_DeleteContactdRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_$_DeleteContactdRequestBody(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_DeleteContactdRequestBody extends _DeleteContactdRequestBody {
  const _$_DeleteContactdRequestBody({@JsonKey(name: "id") required this.id})
      : super._();

  factory _$_DeleteContactdRequestBody.fromJson(Map<String, dynamic> json) =>
      _$$_DeleteContactdRequestBodyFromJson(json);

  @override
  @JsonKey(name: "id")
  final String? id;

  @override
  String toString() {
    return 'DeleteContactdRequestBody(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeleteContactdRequestBody &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeleteContactdRequestBodyCopyWith<_$_DeleteContactdRequestBody>
      get copyWith => __$$_DeleteContactdRequestBodyCopyWithImpl<
          _$_DeleteContactdRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeleteContactdRequestBodyToJson(
      this,
    );
  }
}

abstract class _DeleteContactdRequestBody extends DeleteContactdRequestBody {
  const factory _DeleteContactdRequestBody(
          {@JsonKey(name: "id") required final String? id}) =
      _$_DeleteContactdRequestBody;
  const _DeleteContactdRequestBody._() : super._();

  factory _DeleteContactdRequestBody.fromJson(Map<String, dynamic> json) =
      _$_DeleteContactdRequestBody.fromJson;

  @override
  @JsonKey(name: "id")
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$_DeleteContactdRequestBodyCopyWith<_$_DeleteContactdRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}
