// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'totalCount_response_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TotalCountResponse _$TotalCountResponseFromJson(Map<String, dynamic> json) {
  return _TotalCountResponse.fromJson(json);
}

/// @nodoc
mixin _$TotalCountResponse {
  bool get status => throw _privateConstructorUsedError;
  List<TotalCountResponseData> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TotalCountResponseCopyWith<TotalCountResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TotalCountResponseCopyWith<$Res> {
  factory $TotalCountResponseCopyWith(
          TotalCountResponse value, $Res Function(TotalCountResponse) then) =
      _$TotalCountResponseCopyWithImpl<$Res, TotalCountResponse>;
  @useResult
  $Res call({bool status, List<TotalCountResponseData> data});
}

/// @nodoc
class _$TotalCountResponseCopyWithImpl<$Res, $Val extends TotalCountResponse>
    implements $TotalCountResponseCopyWith<$Res> {
  _$TotalCountResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TotalCountResponseData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TotalCountResponseCopyWith<$Res>
    implements $TotalCountResponseCopyWith<$Res> {
  factory _$$_TotalCountResponseCopyWith(_$_TotalCountResponse value,
          $Res Function(_$_TotalCountResponse) then) =
      __$$_TotalCountResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, List<TotalCountResponseData> data});
}

/// @nodoc
class __$$_TotalCountResponseCopyWithImpl<$Res>
    extends _$TotalCountResponseCopyWithImpl<$Res, _$_TotalCountResponse>
    implements _$$_TotalCountResponseCopyWith<$Res> {
  __$$_TotalCountResponseCopyWithImpl(
      _$_TotalCountResponse _value, $Res Function(_$_TotalCountResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_$_TotalCountResponse(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TotalCountResponseData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TotalCountResponse extends _TotalCountResponse {
  const _$_TotalCountResponse(
      {required this.status,
      final List<TotalCountResponseData> data = const []})
      : _data = data,
        super._();

  factory _$_TotalCountResponse.fromJson(Map<String, dynamic> json) =>
      _$$_TotalCountResponseFromJson(json);

  @override
  final bool status;
  final List<TotalCountResponseData> _data;
  @override
  @JsonKey()
  List<TotalCountResponseData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'TotalCountResponse(status: $status, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TotalCountResponse &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TotalCountResponseCopyWith<_$_TotalCountResponse> get copyWith =>
      __$$_TotalCountResponseCopyWithImpl<_$_TotalCountResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TotalCountResponseToJson(
      this,
    );
  }
}

abstract class _TotalCountResponse extends TotalCountResponse {
  const factory _TotalCountResponse(
      {required final bool status,
      final List<TotalCountResponseData> data}) = _$_TotalCountResponse;
  const _TotalCountResponse._() : super._();

  factory _TotalCountResponse.fromJson(Map<String, dynamic> json) =
      _$_TotalCountResponse.fromJson;

  @override
  bool get status;
  @override
  List<TotalCountResponseData> get data;
  @override
  @JsonKey(ignore: true)
  _$$_TotalCountResponseCopyWith<_$_TotalCountResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

TotalCountResponseData _$TotalCountResponseDataFromJson(
    Map<String, dynamic> json) {
  return _TotalCountResponseData.fromJson(json);
}

/// @nodoc
mixin _$TotalCountResponseData {
  @JsonKey(name: 'totalContact')
  int? get totalContact => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalConnection')
  int? get totalConnection => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalUsers')
  int? get totalUsers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TotalCountResponseDataCopyWith<TotalCountResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TotalCountResponseDataCopyWith<$Res> {
  factory $TotalCountResponseDataCopyWith(TotalCountResponseData value,
          $Res Function(TotalCountResponseData) then) =
      _$TotalCountResponseDataCopyWithImpl<$Res, TotalCountResponseData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'totalContact') int? totalContact,
      @JsonKey(name: 'totalConnection') int? totalConnection,
      @JsonKey(name: 'totalUsers') int? totalUsers});
}

/// @nodoc
class _$TotalCountResponseDataCopyWithImpl<$Res,
        $Val extends TotalCountResponseData>
    implements $TotalCountResponseDataCopyWith<$Res> {
  _$TotalCountResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalContact = freezed,
    Object? totalConnection = freezed,
    Object? totalUsers = freezed,
  }) {
    return _then(_value.copyWith(
      totalContact: freezed == totalContact
          ? _value.totalContact
          : totalContact // ignore: cast_nullable_to_non_nullable
              as int?,
      totalConnection: freezed == totalConnection
          ? _value.totalConnection
          : totalConnection // ignore: cast_nullable_to_non_nullable
              as int?,
      totalUsers: freezed == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TotalCountResponseDataCopyWith<$Res>
    implements $TotalCountResponseDataCopyWith<$Res> {
  factory _$$_TotalCountResponseDataCopyWith(_$_TotalCountResponseData value,
          $Res Function(_$_TotalCountResponseData) then) =
      __$$_TotalCountResponseDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'totalContact') int? totalContact,
      @JsonKey(name: 'totalConnection') int? totalConnection,
      @JsonKey(name: 'totalUsers') int? totalUsers});
}

/// @nodoc
class __$$_TotalCountResponseDataCopyWithImpl<$Res>
    extends _$TotalCountResponseDataCopyWithImpl<$Res,
        _$_TotalCountResponseData>
    implements _$$_TotalCountResponseDataCopyWith<$Res> {
  __$$_TotalCountResponseDataCopyWithImpl(_$_TotalCountResponseData _value,
      $Res Function(_$_TotalCountResponseData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalContact = freezed,
    Object? totalConnection = freezed,
    Object? totalUsers = freezed,
  }) {
    return _then(_$_TotalCountResponseData(
      totalContact: freezed == totalContact
          ? _value.totalContact
          : totalContact // ignore: cast_nullable_to_non_nullable
              as int?,
      totalConnection: freezed == totalConnection
          ? _value.totalConnection
          : totalConnection // ignore: cast_nullable_to_non_nullable
              as int?,
      totalUsers: freezed == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TotalCountResponseData extends _TotalCountResponseData {
  const _$_TotalCountResponseData(
      {@JsonKey(name: 'totalContact') this.totalContact = 0,
      @JsonKey(name: 'totalConnection') this.totalConnection = 0,
      @JsonKey(name: 'totalUsers') this.totalUsers = 0})
      : super._();

  factory _$_TotalCountResponseData.fromJson(Map<String, dynamic> json) =>
      _$$_TotalCountResponseDataFromJson(json);

  @override
  @JsonKey(name: 'totalContact')
  final int? totalContact;
  @override
  @JsonKey(name: 'totalConnection')
  final int? totalConnection;
  @override
  @JsonKey(name: 'totalUsers')
  final int? totalUsers;

  @override
  String toString() {
    return 'TotalCountResponseData(totalContact: $totalContact, totalConnection: $totalConnection, totalUsers: $totalUsers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TotalCountResponseData &&
            (identical(other.totalContact, totalContact) ||
                other.totalContact == totalContact) &&
            (identical(other.totalConnection, totalConnection) ||
                other.totalConnection == totalConnection) &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalContact, totalConnection, totalUsers);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TotalCountResponseDataCopyWith<_$_TotalCountResponseData> get copyWith =>
      __$$_TotalCountResponseDataCopyWithImpl<_$_TotalCountResponseData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TotalCountResponseDataToJson(
      this,
    );
  }
}

abstract class _TotalCountResponseData extends TotalCountResponseData {
  const factory _TotalCountResponseData(
          {@JsonKey(name: 'totalContact') final int? totalContact,
          @JsonKey(name: 'totalConnection') final int? totalConnection,
          @JsonKey(name: 'totalUsers') final int? totalUsers}) =
      _$_TotalCountResponseData;
  const _TotalCountResponseData._() : super._();

  factory _TotalCountResponseData.fromJson(Map<String, dynamic> json) =
      _$_TotalCountResponseData.fromJson;

  @override
  @JsonKey(name: 'totalContact')
  int? get totalContact;
  @override
  @JsonKey(name: 'totalConnection')
  int? get totalConnection;
  @override
  @JsonKey(name: 'totalUsers')
  int? get totalUsers;
  @override
  @JsonKey(ignore: true)
  _$$_TotalCountResponseDataCopyWith<_$_TotalCountResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}
