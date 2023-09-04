import 'package:freezed_annotation/freezed_annotation.dart';

part 'getAllContact_response_body.freezed.dart';
part 'getAllContact_response_body.g.dart';


@freezed
class GetAllContact with _$GetAllContact {
  const GetAllContact._();

  const factory GetAllContact({
    
    bool? status,
    List<User>? AllContact,

  }) = _GetAllContact;

  factory GetAllContact.fromJson(Map<String, dynamic> json) => _$GetAllContactFromJson(json);
}


     @freezed
class User with _$User {
  const User._();

  const factory User({
   @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'name') String? name,
   @JsonKey(name: 'username') String? username,
   @JsonKey(name: 'phone') String? phone,
   @JsonKey(name: 'email') String? email,
  @JsonKey(name: ' profileImage')  String? profileImage,
    @JsonKey(name: 'id') int? id,
   @JsonKey(name: 'company') String? company,
   @JsonKey(name: 'contactMetaId') String? contactMetaId,
  @JsonKey(name: 'contactMetaType')  String? contactMetaType,
   @JsonKey(name: ' fromContactMetaType') String? fromContactMetaType,
   @JsonKey(name: ' personalAccess') int? personalAccess,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
   