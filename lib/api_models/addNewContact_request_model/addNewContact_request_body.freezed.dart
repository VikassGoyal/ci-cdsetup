// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'addNewContact_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddNewContactRequestBody _$AddNewContactRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _AddNewContactRequestBody.fromJson(json);
}

/// @nodoc
mixin _$AddNewContactRequestBody {
  @JsonKey(name: "per_name")
  String get personalName => throw _privateConstructorUsedError;
  @JsonKey(name: "per_num")
  String get personalNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_email')
  String get personalEmail => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_dob')
  String get personalDob => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_add')
  String get personalAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_lan')
  int? get personalLandline => throw _privateConstructorUsedError;
  @JsonKey(name: 'pro_occ')
  String get professionalOccupation => throw _privateConstructorUsedError;
  @JsonKey(name: 'pro_ind')
  String get professionalIndustry => throw _privateConstructorUsedError;
  @JsonKey(name: 'pro_com')
  String get professionalCompany => throw _privateConstructorUsedError;
  @JsonKey(name: 'pro_com_website')
  String get professionalCompanyWebsite => throw _privateConstructorUsedError;
  @JsonKey(name: 'pro_wn')
  String get professionalWorkNature => throw _privateConstructorUsedError;
  @JsonKey(name: 'pro_des')
  String get professionalDesignation => throw _privateConstructorUsedError;
  @JsonKey(name: 'pro_sch')
  String get professionalSchool => throw _privateConstructorUsedError;
  @JsonKey(name: 'pro_gra')
  String get professionalGrade => throw _privateConstructorUsedError;
  @JsonKey(name: 'fb')
  String get socialFacebook => throw _privateConstructorUsedError;
  @JsonKey(name: 'in')
  String get socialInstagram => throw _privateConstructorUsedError;
  @JsonKey(name: 'tt')
  String get socialTwitter => throw _privateConstructorUsedError;
  @JsonKey(name: 'sk')
  String get socialSkype => throw _privateConstructorUsedError;
  @JsonKey(name: 'entreprenerur_list')
  List<Map<String, dynamic>> get entreprenerur_list =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddNewContactRequestBodyCopyWith<AddNewContactRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddNewContactRequestBodyCopyWith<$Res> {
  factory $AddNewContactRequestBodyCopyWith(AddNewContactRequestBody value,
          $Res Function(AddNewContactRequestBody) then) =
      _$AddNewContactRequestBodyCopyWithImpl<$Res, AddNewContactRequestBody>;
  @useResult
  $Res call(
      {@JsonKey(name: "per_name") String personalName,
      @JsonKey(name: "per_num") String personalNumber,
      @JsonKey(name: 'per_email') String personalEmail,
      @JsonKey(name: 'per_dob') String personalDob,
      @JsonKey(name: 'per_add') String personalAddress,
      @JsonKey(name: 'per_lan') int? personalLandline,
      @JsonKey(name: 'pro_occ') String professionalOccupation,
      @JsonKey(name: 'pro_ind') String professionalIndustry,
      @JsonKey(name: 'pro_com') String professionalCompany,
      @JsonKey(name: 'pro_com_website') String professionalCompanyWebsite,
      @JsonKey(name: 'pro_wn') String professionalWorkNature,
      @JsonKey(name: 'pro_des') String professionalDesignation,
      @JsonKey(name: 'pro_sch') String professionalSchool,
      @JsonKey(name: 'pro_gra') String professionalGrade,
      @JsonKey(name: 'fb') String socialFacebook,
      @JsonKey(name: 'in') String socialInstagram,
      @JsonKey(name: 'tt') String socialTwitter,
      @JsonKey(name: 'sk') String socialSkype,
      @JsonKey(name: 'entreprenerur_list')
      List<Map<String, dynamic>> entreprenerur_list});
}

/// @nodoc
class _$AddNewContactRequestBodyCopyWithImpl<$Res,
        $Val extends AddNewContactRequestBody>
    implements $AddNewContactRequestBodyCopyWith<$Res> {
  _$AddNewContactRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? personalName = null,
    Object? personalNumber = null,
    Object? personalEmail = null,
    Object? personalDob = null,
    Object? personalAddress = null,
    Object? personalLandline = freezed,
    Object? professionalOccupation = null,
    Object? professionalIndustry = null,
    Object? professionalCompany = null,
    Object? professionalCompanyWebsite = null,
    Object? professionalWorkNature = null,
    Object? professionalDesignation = null,
    Object? professionalSchool = null,
    Object? professionalGrade = null,
    Object? socialFacebook = null,
    Object? socialInstagram = null,
    Object? socialTwitter = null,
    Object? socialSkype = null,
    Object? entreprenerur_list = null,
  }) {
    return _then(_value.copyWith(
      personalName: null == personalName
          ? _value.personalName
          : personalName // ignore: cast_nullable_to_non_nullable
              as String,
      personalNumber: null == personalNumber
          ? _value.personalNumber
          : personalNumber // ignore: cast_nullable_to_non_nullable
              as String,
      personalEmail: null == personalEmail
          ? _value.personalEmail
          : personalEmail // ignore: cast_nullable_to_non_nullable
              as String,
      personalDob: null == personalDob
          ? _value.personalDob
          : personalDob // ignore: cast_nullable_to_non_nullable
              as String,
      personalAddress: null == personalAddress
          ? _value.personalAddress
          : personalAddress // ignore: cast_nullable_to_non_nullable
              as String,
      personalLandline: freezed == personalLandline
          ? _value.personalLandline
          : personalLandline // ignore: cast_nullable_to_non_nullable
              as int?,
      professionalOccupation: null == professionalOccupation
          ? _value.professionalOccupation
          : professionalOccupation // ignore: cast_nullable_to_non_nullable
              as String,
      professionalIndustry: null == professionalIndustry
          ? _value.professionalIndustry
          : professionalIndustry // ignore: cast_nullable_to_non_nullable
              as String,
      professionalCompany: null == professionalCompany
          ? _value.professionalCompany
          : professionalCompany // ignore: cast_nullable_to_non_nullable
              as String,
      professionalCompanyWebsite: null == professionalCompanyWebsite
          ? _value.professionalCompanyWebsite
          : professionalCompanyWebsite // ignore: cast_nullable_to_non_nullable
              as String,
      professionalWorkNature: null == professionalWorkNature
          ? _value.professionalWorkNature
          : professionalWorkNature // ignore: cast_nullable_to_non_nullable
              as String,
      professionalDesignation: null == professionalDesignation
          ? _value.professionalDesignation
          : professionalDesignation // ignore: cast_nullable_to_non_nullable
              as String,
      professionalSchool: null == professionalSchool
          ? _value.professionalSchool
          : professionalSchool // ignore: cast_nullable_to_non_nullable
              as String,
      professionalGrade: null == professionalGrade
          ? _value.professionalGrade
          : professionalGrade // ignore: cast_nullable_to_non_nullable
              as String,
      socialFacebook: null == socialFacebook
          ? _value.socialFacebook
          : socialFacebook // ignore: cast_nullable_to_non_nullable
              as String,
      socialInstagram: null == socialInstagram
          ? _value.socialInstagram
          : socialInstagram // ignore: cast_nullable_to_non_nullable
              as String,
      socialTwitter: null == socialTwitter
          ? _value.socialTwitter
          : socialTwitter // ignore: cast_nullable_to_non_nullable
              as String,
      socialSkype: null == socialSkype
          ? _value.socialSkype
          : socialSkype // ignore: cast_nullable_to_non_nullable
              as String,
      entreprenerur_list: null == entreprenerur_list
          ? _value.entreprenerur_list
          : entreprenerur_list // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddNewContactRequestBodyCopyWith<$Res>
    implements $AddNewContactRequestBodyCopyWith<$Res> {
  factory _$$_AddNewContactRequestBodyCopyWith(
          _$_AddNewContactRequestBody value,
          $Res Function(_$_AddNewContactRequestBody) then) =
      __$$_AddNewContactRequestBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "per_name") String personalName,
      @JsonKey(name: "per_num") String personalNumber,
      @JsonKey(name: 'per_email') String personalEmail,
      @JsonKey(name: 'per_dob') String personalDob,
      @JsonKey(name: 'per_add') String personalAddress,
      @JsonKey(name: 'per_lan') int? personalLandline,
      @JsonKey(name: 'pro_occ') String professionalOccupation,
      @JsonKey(name: 'pro_ind') String professionalIndustry,
      @JsonKey(name: 'pro_com') String professionalCompany,
      @JsonKey(name: 'pro_com_website') String professionalCompanyWebsite,
      @JsonKey(name: 'pro_wn') String professionalWorkNature,
      @JsonKey(name: 'pro_des') String professionalDesignation,
      @JsonKey(name: 'pro_sch') String professionalSchool,
      @JsonKey(name: 'pro_gra') String professionalGrade,
      @JsonKey(name: 'fb') String socialFacebook,
      @JsonKey(name: 'in') String socialInstagram,
      @JsonKey(name: 'tt') String socialTwitter,
      @JsonKey(name: 'sk') String socialSkype,
      @JsonKey(name: 'entreprenerur_list')
      List<Map<String, dynamic>> entreprenerur_list});
}

/// @nodoc
class __$$_AddNewContactRequestBodyCopyWithImpl<$Res>
    extends _$AddNewContactRequestBodyCopyWithImpl<$Res,
        _$_AddNewContactRequestBody>
    implements _$$_AddNewContactRequestBodyCopyWith<$Res> {
  __$$_AddNewContactRequestBodyCopyWithImpl(_$_AddNewContactRequestBody _value,
      $Res Function(_$_AddNewContactRequestBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? personalName = null,
    Object? personalNumber = null,
    Object? personalEmail = null,
    Object? personalDob = null,
    Object? personalAddress = null,
    Object? personalLandline = freezed,
    Object? professionalOccupation = null,
    Object? professionalIndustry = null,
    Object? professionalCompany = null,
    Object? professionalCompanyWebsite = null,
    Object? professionalWorkNature = null,
    Object? professionalDesignation = null,
    Object? professionalSchool = null,
    Object? professionalGrade = null,
    Object? socialFacebook = null,
    Object? socialInstagram = null,
    Object? socialTwitter = null,
    Object? socialSkype = null,
    Object? entreprenerur_list = null,
  }) {
    return _then(_$_AddNewContactRequestBody(
      personalName: null == personalName
          ? _value.personalName
          : personalName // ignore: cast_nullable_to_non_nullable
              as String,
      personalNumber: null == personalNumber
          ? _value.personalNumber
          : personalNumber // ignore: cast_nullable_to_non_nullable
              as String,
      personalEmail: null == personalEmail
          ? _value.personalEmail
          : personalEmail // ignore: cast_nullable_to_non_nullable
              as String,
      personalDob: null == personalDob
          ? _value.personalDob
          : personalDob // ignore: cast_nullable_to_non_nullable
              as String,
      personalAddress: null == personalAddress
          ? _value.personalAddress
          : personalAddress // ignore: cast_nullable_to_non_nullable
              as String,
      personalLandline: freezed == personalLandline
          ? _value.personalLandline
          : personalLandline // ignore: cast_nullable_to_non_nullable
              as int?,
      professionalOccupation: null == professionalOccupation
          ? _value.professionalOccupation
          : professionalOccupation // ignore: cast_nullable_to_non_nullable
              as String,
      professionalIndustry: null == professionalIndustry
          ? _value.professionalIndustry
          : professionalIndustry // ignore: cast_nullable_to_non_nullable
              as String,
      professionalCompany: null == professionalCompany
          ? _value.professionalCompany
          : professionalCompany // ignore: cast_nullable_to_non_nullable
              as String,
      professionalCompanyWebsite: null == professionalCompanyWebsite
          ? _value.professionalCompanyWebsite
          : professionalCompanyWebsite // ignore: cast_nullable_to_non_nullable
              as String,
      professionalWorkNature: null == professionalWorkNature
          ? _value.professionalWorkNature
          : professionalWorkNature // ignore: cast_nullable_to_non_nullable
              as String,
      professionalDesignation: null == professionalDesignation
          ? _value.professionalDesignation
          : professionalDesignation // ignore: cast_nullable_to_non_nullable
              as String,
      professionalSchool: null == professionalSchool
          ? _value.professionalSchool
          : professionalSchool // ignore: cast_nullable_to_non_nullable
              as String,
      professionalGrade: null == professionalGrade
          ? _value.professionalGrade
          : professionalGrade // ignore: cast_nullable_to_non_nullable
              as String,
      socialFacebook: null == socialFacebook
          ? _value.socialFacebook
          : socialFacebook // ignore: cast_nullable_to_non_nullable
              as String,
      socialInstagram: null == socialInstagram
          ? _value.socialInstagram
          : socialInstagram // ignore: cast_nullable_to_non_nullable
              as String,
      socialTwitter: null == socialTwitter
          ? _value.socialTwitter
          : socialTwitter // ignore: cast_nullable_to_non_nullable
              as String,
      socialSkype: null == socialSkype
          ? _value.socialSkype
          : socialSkype // ignore: cast_nullable_to_non_nullable
              as String,
      entreprenerur_list: null == entreprenerur_list
          ? _value._entreprenerur_list
          : entreprenerur_list // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_AddNewContactRequestBody extends _AddNewContactRequestBody {
  const _$_AddNewContactRequestBody(
      {@JsonKey(name: "per_name") required this.personalName,
      @JsonKey(name: "per_num") required this.personalNumber,
      @JsonKey(name: 'per_email') required this.personalEmail,
      @JsonKey(name: 'per_dob') required this.personalDob,
      @JsonKey(name: 'per_add') required this.personalAddress,
      @JsonKey(name: 'per_lan') this.personalLandline,
      @JsonKey(name: 'pro_occ') required this.professionalOccupation,
      @JsonKey(name: 'pro_ind') required this.professionalIndustry,
      @JsonKey(name: 'pro_com') required this.professionalCompany,
      @JsonKey(name: 'pro_com_website')
      required this.professionalCompanyWebsite,
      @JsonKey(name: 'pro_wn') required this.professionalWorkNature,
      @JsonKey(name: 'pro_des') required this.professionalDesignation,
      @JsonKey(name: 'pro_sch') required this.professionalSchool,
      @JsonKey(name: 'pro_gra') required this.professionalGrade,
      @JsonKey(name: 'fb') required this.socialFacebook,
      @JsonKey(name: 'in') required this.socialInstagram,
      @JsonKey(name: 'tt') required this.socialTwitter,
      @JsonKey(name: 'sk') required this.socialSkype,
      @JsonKey(name: 'entreprenerur_list')
      required final List<Map<String, dynamic>> entreprenerur_list})
      : _entreprenerur_list = entreprenerur_list,
        super._();

  factory _$_AddNewContactRequestBody.fromJson(Map<String, dynamic> json) =>
      _$$_AddNewContactRequestBodyFromJson(json);

  @override
  @JsonKey(name: "per_name")
  final String personalName;
  @override
  @JsonKey(name: "per_num")
  final String personalNumber;
  @override
  @JsonKey(name: 'per_email')
  final String personalEmail;
  @override
  @JsonKey(name: 'per_dob')
  final String personalDob;
  @override
  @JsonKey(name: 'per_add')
  final String personalAddress;
  @override
  @JsonKey(name: 'per_lan')
  final int? personalLandline;
  @override
  @JsonKey(name: 'pro_occ')
  final String professionalOccupation;
  @override
  @JsonKey(name: 'pro_ind')
  final String professionalIndustry;
  @override
  @JsonKey(name: 'pro_com')
  final String professionalCompany;
  @override
  @JsonKey(name: 'pro_com_website')
  final String professionalCompanyWebsite;
  @override
  @JsonKey(name: 'pro_wn')
  final String professionalWorkNature;
  @override
  @JsonKey(name: 'pro_des')
  final String professionalDesignation;
  @override
  @JsonKey(name: 'pro_sch')
  final String professionalSchool;
  @override
  @JsonKey(name: 'pro_gra')
  final String professionalGrade;
  @override
  @JsonKey(name: 'fb')
  final String socialFacebook;
  @override
  @JsonKey(name: 'in')
  final String socialInstagram;
  @override
  @JsonKey(name: 'tt')
  final String socialTwitter;
  @override
  @JsonKey(name: 'sk')
  final String socialSkype;
  final List<Map<String, dynamic>> _entreprenerur_list;
  @override
  @JsonKey(name: 'entreprenerur_list')
  List<Map<String, dynamic>> get entreprenerur_list {
    if (_entreprenerur_list is EqualUnmodifiableListView)
      return _entreprenerur_list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entreprenerur_list);
  }

  @override
  String toString() {
    return 'AddNewContactRequestBody(personalName: $personalName, personalNumber: $personalNumber, personalEmail: $personalEmail, personalDob: $personalDob, personalAddress: $personalAddress, personalLandline: $personalLandline, professionalOccupation: $professionalOccupation, professionalIndustry: $professionalIndustry, professionalCompany: $professionalCompany, professionalCompanyWebsite: $professionalCompanyWebsite, professionalWorkNature: $professionalWorkNature, professionalDesignation: $professionalDesignation, professionalSchool: $professionalSchool, professionalGrade: $professionalGrade, socialFacebook: $socialFacebook, socialInstagram: $socialInstagram, socialTwitter: $socialTwitter, socialSkype: $socialSkype, entreprenerur_list: $entreprenerur_list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddNewContactRequestBody &&
            (identical(other.personalName, personalName) ||
                other.personalName == personalName) &&
            (identical(other.personalNumber, personalNumber) ||
                other.personalNumber == personalNumber) &&
            (identical(other.personalEmail, personalEmail) ||
                other.personalEmail == personalEmail) &&
            (identical(other.personalDob, personalDob) ||
                other.personalDob == personalDob) &&
            (identical(other.personalAddress, personalAddress) ||
                other.personalAddress == personalAddress) &&
            (identical(other.personalLandline, personalLandline) ||
                other.personalLandline == personalLandline) &&
            (identical(other.professionalOccupation, professionalOccupation) ||
                other.professionalOccupation == professionalOccupation) &&
            (identical(other.professionalIndustry, professionalIndustry) ||
                other.professionalIndustry == professionalIndustry) &&
            (identical(other.professionalCompany, professionalCompany) ||
                other.professionalCompany == professionalCompany) &&
            (identical(other.professionalCompanyWebsite,
                    professionalCompanyWebsite) ||
                other.professionalCompanyWebsite ==
                    professionalCompanyWebsite) &&
            (identical(other.professionalWorkNature, professionalWorkNature) ||
                other.professionalWorkNature == professionalWorkNature) &&
            (identical(
                    other.professionalDesignation, professionalDesignation) ||
                other.professionalDesignation == professionalDesignation) &&
            (identical(other.professionalSchool, professionalSchool) ||
                other.professionalSchool == professionalSchool) &&
            (identical(other.professionalGrade, professionalGrade) ||
                other.professionalGrade == professionalGrade) &&
            (identical(other.socialFacebook, socialFacebook) ||
                other.socialFacebook == socialFacebook) &&
            (identical(other.socialInstagram, socialInstagram) ||
                other.socialInstagram == socialInstagram) &&
            (identical(other.socialTwitter, socialTwitter) ||
                other.socialTwitter == socialTwitter) &&
            (identical(other.socialSkype, socialSkype) ||
                other.socialSkype == socialSkype) &&
            const DeepCollectionEquality()
                .equals(other._entreprenerur_list, _entreprenerur_list));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        personalName,
        personalNumber,
        personalEmail,
        personalDob,
        personalAddress,
        personalLandline,
        professionalOccupation,
        professionalIndustry,
        professionalCompany,
        professionalCompanyWebsite,
        professionalWorkNature,
        professionalDesignation,
        professionalSchool,
        professionalGrade,
        socialFacebook,
        socialInstagram,
        socialTwitter,
        socialSkype,
        const DeepCollectionEquality().hash(_entreprenerur_list)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddNewContactRequestBodyCopyWith<_$_AddNewContactRequestBody>
      get copyWith => __$$_AddNewContactRequestBodyCopyWithImpl<
          _$_AddNewContactRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddNewContactRequestBodyToJson(
      this,
    );
  }
}

abstract class _AddNewContactRequestBody extends AddNewContactRequestBody {
  const factory _AddNewContactRequestBody(
      {@JsonKey(name: "per_name") required final String personalName,
      @JsonKey(name: "per_num") required final String personalNumber,
      @JsonKey(name: 'per_email') required final String personalEmail,
      @JsonKey(name: 'per_dob') required final String personalDob,
      @JsonKey(name: 'per_add') required final String personalAddress,
      @JsonKey(name: 'per_lan') final int? personalLandline,
      @JsonKey(name: 'pro_occ') required final String professionalOccupation,
      @JsonKey(name: 'pro_ind') required final String professionalIndustry,
      @JsonKey(name: 'pro_com') required final String professionalCompany,
      @JsonKey(name: 'pro_com_website')
      required final String professionalCompanyWebsite,
      @JsonKey(name: 'pro_wn') required final String professionalWorkNature,
      @JsonKey(name: 'pro_des') required final String professionalDesignation,
      @JsonKey(name: 'pro_sch') required final String professionalSchool,
      @JsonKey(name: 'pro_gra') required final String professionalGrade,
      @JsonKey(name: 'fb') required final String socialFacebook,
      @JsonKey(name: 'in') required final String socialInstagram,
      @JsonKey(name: 'tt') required final String socialTwitter,
      @JsonKey(name: 'sk') required final String socialSkype,
      @JsonKey(name: 'entreprenerur_list')
      required final List<Map<String, dynamic>>
          entreprenerur_list}) = _$_AddNewContactRequestBody;
  const _AddNewContactRequestBody._() : super._();

  factory _AddNewContactRequestBody.fromJson(Map<String, dynamic> json) =
      _$_AddNewContactRequestBody.fromJson;

  @override
  @JsonKey(name: "per_name")
  String get personalName;
  @override
  @JsonKey(name: "per_num")
  String get personalNumber;
  @override
  @JsonKey(name: 'per_email')
  String get personalEmail;
  @override
  @JsonKey(name: 'per_dob')
  String get personalDob;
  @override
  @JsonKey(name: 'per_add')
  String get personalAddress;
  @override
  @JsonKey(name: 'per_lan')
  int? get personalLandline;
  @override
  @JsonKey(name: 'pro_occ')
  String get professionalOccupation;
  @override
  @JsonKey(name: 'pro_ind')
  String get professionalIndustry;
  @override
  @JsonKey(name: 'pro_com')
  String get professionalCompany;
  @override
  @JsonKey(name: 'pro_com_website')
  String get professionalCompanyWebsite;
  @override
  @JsonKey(name: 'pro_wn')
  String get professionalWorkNature;
  @override
  @JsonKey(name: 'pro_des')
  String get professionalDesignation;
  @override
  @JsonKey(name: 'pro_sch')
  String get professionalSchool;
  @override
  @JsonKey(name: 'pro_gra')
  String get professionalGrade;
  @override
  @JsonKey(name: 'fb')
  String get socialFacebook;
  @override
  @JsonKey(name: 'in')
  String get socialInstagram;
  @override
  @JsonKey(name: 'tt')
  String get socialTwitter;
  @override
  @JsonKey(name: 'sk')
  String get socialSkype;
  @override
  @JsonKey(name: 'entreprenerur_list')
  List<Map<String, dynamic>> get entreprenerur_list;
  @override
  @JsonKey(ignore: true)
  _$$_AddNewContactRequestBodyCopyWith<_$_AddNewContactRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}
