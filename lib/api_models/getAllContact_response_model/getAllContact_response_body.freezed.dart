// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'getAllContact_response_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetAllContact _$GetAllContactFromJson(Map<String, dynamic> json) {
  return _GetAllContact.fromJson(json);
}

/// @nodoc
mixin _$GetAllContact {
  bool? get status => throw _privateConstructorUsedError;
  List<User>? get AllContact => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetAllContactCopyWith<GetAllContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAllContactCopyWith<$Res> {
  factory $GetAllContactCopyWith(
          GetAllContact value, $Res Function(GetAllContact) then) =
      _$GetAllContactCopyWithImpl<$Res, GetAllContact>;
  @useResult
  $Res call({bool? status, List<User>? AllContact});
}

/// @nodoc
class _$GetAllContactCopyWithImpl<$Res, $Val extends GetAllContact>
    implements $GetAllContactCopyWith<$Res> {
  _$GetAllContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? AllContact = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      AllContact: freezed == AllContact
          ? _value.AllContact
          : AllContact // ignore: cast_nullable_to_non_nullable
              as List<User>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetAllContactCopyWith<$Res>
    implements $GetAllContactCopyWith<$Res> {
  factory _$$_GetAllContactCopyWith(
          _$_GetAllContact value, $Res Function(_$_GetAllContact) then) =
      __$$_GetAllContactCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? status, List<User>? AllContact});
}

/// @nodoc
class __$$_GetAllContactCopyWithImpl<$Res>
    extends _$GetAllContactCopyWithImpl<$Res, _$_GetAllContact>
    implements _$$_GetAllContactCopyWith<$Res> {
  __$$_GetAllContactCopyWithImpl(
      _$_GetAllContact _value, $Res Function(_$_GetAllContact) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? AllContact = freezed,
  }) {
    return _then(_$_GetAllContact(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      AllContact: freezed == AllContact
          ? _value._AllContact
          : AllContact // ignore: cast_nullable_to_non_nullable
              as List<User>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetAllContact extends _GetAllContact {
  const _$_GetAllContact({this.status, final List<User>? AllContact})
      : _AllContact = AllContact,
        super._();

  factory _$_GetAllContact.fromJson(Map<String, dynamic> json) =>
      _$$_GetAllContactFromJson(json);

  @override
  final bool? status;
  final List<User>? _AllContact;
  @override
  List<User>? get AllContact {
    final value = _AllContact;
    if (value == null) return null;
    if (_AllContact is EqualUnmodifiableListView) return _AllContact;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetAllContact(status: $status, AllContact: $AllContact)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetAllContact &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._AllContact, _AllContact));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_AllContact));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetAllContactCopyWith<_$_GetAllContact> get copyWith =>
      __$$_GetAllContactCopyWithImpl<_$_GetAllContact>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetAllContactToJson(
      this,
    );
  }
}

abstract class _GetAllContact extends GetAllContact {
  const factory _GetAllContact(
      {final bool? status, final List<User>? AllContact}) = _$_GetAllContact;
  const _GetAllContact._() : super._();

  factory _GetAllContact.fromJson(Map<String, dynamic> json) =
      _$_GetAllContact.fromJson;

  @override
  bool? get status;
  @override
  List<User>? get AllContact;
  @override
  @JsonKey(ignore: true)
  _$$_GetAllContactCopyWith<_$_GetAllContact> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: 'userId')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone')
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: ' profileImage')
  String? get profileImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'company')
  String? get company => throw _privateConstructorUsedError;
  @JsonKey(name: 'contactMetaId')
  String? get contactMetaId => throw _privateConstructorUsedError;
  @JsonKey(name: 'contactMetaType')
  String? get contactMetaType => throw _privateConstructorUsedError;
  @JsonKey(name: ' fromContactMetaType')
  String? get fromContactMetaType => throw _privateConstructorUsedError;
  @JsonKey(name: ' personalAccess')
  int? get personalAccess => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'username') String? username,
      @JsonKey(name: 'phone') String? phone,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: ' profileImage') String? profileImage,
      @JsonKey(name: 'id') int? id,
      @JsonKey(name: 'company') String? company,
      @JsonKey(name: 'contactMetaId') String? contactMetaId,
      @JsonKey(name: 'contactMetaType') String? contactMetaType,
      @JsonKey(name: ' fromContactMetaType') String? fromContactMetaType,
      @JsonKey(name: ' personalAccess') int? personalAccess});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? name = freezed,
    Object? username = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? profileImage = freezed,
    Object? id = freezed,
    Object? company = freezed,
    Object? contactMetaId = freezed,
    Object? contactMetaType = freezed,
    Object? fromContactMetaType = freezed,
    Object? personalAccess = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      contactMetaId: freezed == contactMetaId
          ? _value.contactMetaId
          : contactMetaId // ignore: cast_nullable_to_non_nullable
              as String?,
      contactMetaType: freezed == contactMetaType
          ? _value.contactMetaType
          : contactMetaType // ignore: cast_nullable_to_non_nullable
              as String?,
      fromContactMetaType: freezed == fromContactMetaType
          ? _value.fromContactMetaType
          : fromContactMetaType // ignore: cast_nullable_to_non_nullable
              as String?,
      personalAccess: freezed == personalAccess
          ? _value.personalAccess
          : personalAccess // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'username') String? username,
      @JsonKey(name: 'phone') String? phone,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: ' profileImage') String? profileImage,
      @JsonKey(name: 'id') int? id,
      @JsonKey(name: 'company') String? company,
      @JsonKey(name: 'contactMetaId') String? contactMetaId,
      @JsonKey(name: 'contactMetaType') String? contactMetaType,
      @JsonKey(name: ' fromContactMetaType') String? fromContactMetaType,
      @JsonKey(name: ' personalAccess') int? personalAccess});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? name = freezed,
    Object? username = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? profileImage = freezed,
    Object? id = freezed,
    Object? company = freezed,
    Object? contactMetaId = freezed,
    Object? contactMetaType = freezed,
    Object? fromContactMetaType = freezed,
    Object? personalAccess = freezed,
  }) {
    return _then(_$_User(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      contactMetaId: freezed == contactMetaId
          ? _value.contactMetaId
          : contactMetaId // ignore: cast_nullable_to_non_nullable
              as String?,
      contactMetaType: freezed == contactMetaType
          ? _value.contactMetaType
          : contactMetaType // ignore: cast_nullable_to_non_nullable
              as String?,
      fromContactMetaType: freezed == fromContactMetaType
          ? _value.fromContactMetaType
          : fromContactMetaType // ignore: cast_nullable_to_non_nullable
              as String?,
      personalAccess: freezed == personalAccess
          ? _value.personalAccess
          : personalAccess // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User extends _User {
  const _$_User(
      {@JsonKey(name: 'userId') this.userId,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'username') this.username,
      @JsonKey(name: 'phone') this.phone,
      @JsonKey(name: 'email') this.email,
      @JsonKey(name: ' profileImage') this.profileImage,
      @JsonKey(name: 'id') this.id,
      @JsonKey(name: 'company') this.company,
      @JsonKey(name: 'contactMetaId') this.contactMetaId,
      @JsonKey(name: 'contactMetaType') this.contactMetaType,
      @JsonKey(name: ' fromContactMetaType') this.fromContactMetaType,
      @JsonKey(name: ' personalAccess') this.personalAccess})
      : super._();

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  @JsonKey(name: 'userId')
  final String? userId;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'username')
  final String? username;
  @override
  @JsonKey(name: 'phone')
  final String? phone;
  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: ' profileImage')
  final String? profileImage;
  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'company')
  final String? company;
  @override
  @JsonKey(name: 'contactMetaId')
  final String? contactMetaId;
  @override
  @JsonKey(name: 'contactMetaType')
  final String? contactMetaType;
  @override
  @JsonKey(name: ' fromContactMetaType')
  final String? fromContactMetaType;
  @override
  @JsonKey(name: ' personalAccess')
  final int? personalAccess;

  @override
  String toString() {
    return 'User(userId: $userId, name: $name, username: $username, phone: $phone, email: $email, profileImage: $profileImage, id: $id, company: $company, contactMetaId: $contactMetaId, contactMetaType: $contactMetaType, fromContactMetaType: $fromContactMetaType, personalAccess: $personalAccess)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.contactMetaId, contactMetaId) ||
                other.contactMetaId == contactMetaId) &&
            (identical(other.contactMetaType, contactMetaType) ||
                other.contactMetaType == contactMetaType) &&
            (identical(other.fromContactMetaType, fromContactMetaType) ||
                other.fromContactMetaType == fromContactMetaType) &&
            (identical(other.personalAccess, personalAccess) ||
                other.personalAccess == personalAccess));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      name,
      username,
      phone,
      email,
      profileImage,
      id,
      company,
      contactMetaId,
      contactMetaType,
      fromContactMetaType,
      personalAccess);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User extends User {
  const factory _User(
      {@JsonKey(name: 'userId') final String? userId,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'username') final String? username,
      @JsonKey(name: 'phone') final String? phone,
      @JsonKey(name: 'email') final String? email,
      @JsonKey(name: ' profileImage') final String? profileImage,
      @JsonKey(name: 'id') final int? id,
      @JsonKey(name: 'company') final String? company,
      @JsonKey(name: 'contactMetaId') final String? contactMetaId,
      @JsonKey(name: 'contactMetaType') final String? contactMetaType,
      @JsonKey(name: ' fromContactMetaType') final String? fromContactMetaType,
      @JsonKey(name: ' personalAccess') final int? personalAccess}) = _$_User;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  @JsonKey(name: 'userId')
  String? get userId;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'username')
  String? get username;
  @override
  @JsonKey(name: 'phone')
  String? get phone;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: ' profileImage')
  String? get profileImage;
  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(name: 'company')
  String? get company;
  @override
  @JsonKey(name: 'contactMetaId')
  String? get contactMetaId;
  @override
  @JsonKey(name: 'contactMetaType')
  String? get contactMetaType;
  @override
  @JsonKey(name: ' fromContactMetaType')
  String? get fromContactMetaType;
  @override
  @JsonKey(name: ' personalAccess')
  int? get personalAccess;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
