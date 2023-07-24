import 'package:azlistview/azlistview.dart';

class AllContacts extends ISuspensionBean {
  int? _id;
  int? _userId;
  String? _name;
  String? _username;
  String? _phone;
  String? _email;
  String? _profileImage;
  String? _company;
  int? _contactMetaId;
  String? _contactMetaType;
  String? _fromContactMetaType;
  int? _personalAccess;
  String? _tagIndex;

  AllContacts(
      {int? id,
      int? userId,
      String? name,
      String? username,
      String? phone,
      String? email,
      String? profileImage,
      String? company,
      int? contactMetaId,
      String? contactMetaType,
      String? fromContactMetaType,
      int? personalAccess}) {
    _id = id;
    _userId = userId;
    _name = name;
    _username = username;
    _phone = phone;
    _email = email;
    _profileImage = profileImage;
    _company = company;
    _contactMetaId = contactMetaId;
    _contactMetaType = contactMetaType;
    _fromContactMetaType = fromContactMetaType;
    _personalAccess = personalAccess;
    _tagIndex = tagIndex;
  }
  int? get id => _id;
  set id(int? id) => _id = id;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get username => _username;
  set username(String? username) => _username = username;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;
  String? get company => _company;
  set company(String? company) => _company = company;
  int? get contactMetaId => _contactMetaId;
  set contactMetaId(int? contactMetaId) => _contactMetaId = contactMetaId;
  String? get contactMetaType => _contactMetaType;
  set contactMetaType(String? contactMetaType) => _contactMetaType = contactMetaType;
  String? get fromContactMetaType => _fromContactMetaType;
  set fromContactMetaType(String? fromContactMetaType) => _fromContactMetaType = fromContactMetaType;
  int? get personalAccess => _personalAccess;
  set personalAccess(int? personalAccess) => _personalAccess = personalAccess;

  String get tagIndex => _tagIndex!;
  set tagIndex(String tagIndex) => _tagIndex = tagIndex;

  AllContacts.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _username = json['username'];
    _phone = json['phone'];
    _email = json['email'];
    _profileImage = json['profile_image'];
    _company = json['company'];
    _contactMetaId = json['contact_meta_id'];
    _contactMetaType = json['contact_meta_type'];
    _fromContactMetaType = json['from_contact_meta_type'];
    _personalAccess = json['personal_access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['name'] = _name;
    data['username'] = _username;
    data['phone'] = _phone;
    data['email'] = _email;
    data['profile_image'] = _profileImage;
    data['company'] = _company;
    data['contact_meta_id'] = _contactMetaId;
    data['contact_meta_type'] = _contactMetaType;
    data['from_contact_meta_type'] = _fromContactMetaType;
    data['personal_access'] = _personalAccess;
    return data;
  }

  @override
  String getSuspensionTag() {
    return _tagIndex!;
  }
}
