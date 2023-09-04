// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getAllContact_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetAllContact _$$_GetAllContactFromJson(Map<String, dynamic> json) =>
    _$_GetAllContact(
      status: json['status'] as bool?,
      AllContact: (json['AllContact'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GetAllContactToJson(_$_GetAllContact instance) =>
    <String, dynamic>{
      'status': instance.status,
      'AllContact': instance.AllContact,
    };

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      profileImage: json[' profileImage'] as String?,
      id: json['id'] as int?,
      company: json['company'] as String?,
      contactMetaId: json['contactMetaId'] as String?,
      contactMetaType: json['contactMetaType'] as String?,
      fromContactMetaType: json[' fromContactMetaType'] as String?,
      personalAccess: json[' personalAccess'] as int?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'username': instance.username,
      'phone': instance.phone,
      'email': instance.email,
      ' profileImage': instance.profileImage,
      'id': instance.id,
      'company': instance.company,
      'contactMetaId': instance.contactMetaId,
      'contactMetaType': instance.contactMetaType,
      ' fromContactMetaType': instance.fromContactMetaType,
      ' personalAccess': instance.personalAccess,
    };
