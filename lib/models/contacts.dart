class ContactResponse {
  int? _id;
  int? _from;
  int? _to;
  String? _type;
  String? _connectionType;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  Tocontact? _tocontact;

  ContactResponse(
      {int? id,
      int? from,
      int? to,
      String? type,
      String? connectionType,
      String? status,
      String? createdAt,
      String? updatedAt,
      Tocontact? tocontact}) {
    _id = id;
    _from = from;
    _to = to;
    _type = type;
    _connectionType = connectionType;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _tocontact = tocontact;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get from => _from;
  set from(int? from) => _from = from;
  int? get to => _to;
  set to(int? to) => _to = to;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get connectionType => _connectionType;
  set connectionType(String? connectionType) => _connectionType = connectionType;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  Tocontact? get tocontact => _tocontact;
  set tocontact(Tocontact? tocontact) => _tocontact = tocontact;

  ContactResponse.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _from = json['from'];
    _to = json['to'];
    _type = json['type'];
    _connectionType = json['connection_type'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _tocontact = json['tocontact'] != null
        ? Tocontact.fromJson(json['tocontact'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['from'] = _from;
    data['to'] = _to;
    data['type'] = _type;
    data['connection_type'] = _connectionType;
    data['status'] = _status;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['tocontact'] = _tocontact?.toJson();
    return data;
  }
}

class Tocontact {
  int? _id;
  int? _userId;
  String? _code;
  String? _name;
  String? _email;
  String? _phone;
  String? _type;
  String? _img;
  String? _qrValue;
  String? _status;
  String? _company;
  int? _transanctionId;
  String? _createdAt;
  String? _updatedAt;

  Tocontact(
      {int? id,
      int? userId,
      String? code,
      String? name,
      String? email,
      String? phone,
      String? type,
      String? img,
      String? qrValue,
      String? status,
      String? company,
      int? transanctionId,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _userId = userId;
    _code = code;
    _name = name;
    _email = email;
    _phone = phone;
    _type = type;
    _img = img;
    _qrValue = qrValue;
    _status = status;
    _company = company;
    _transanctionId = transanctionId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get code => _code;
  set code(String? code) => _code = code;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get img => _img;
  set img(String? img) => _img = img;
  String? get qrValue => _qrValue;
  set qrValue(String? qrValue) => _qrValue = qrValue;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get company => _company;
  set company(String? company) => _company = company;
  int? get transanctionId => _transanctionId;
  set transanctionId(int? transanctionId) => _transanctionId = transanctionId;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  Tocontact.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _code = json['code'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _type = json['type'];
    _img = json['img'];
    _qrValue = json['qr_value'];
    _status = json['status'];
    _company = json['company'];
    _transanctionId = json['transanction_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['code'] = _code;
    data['name'] = _name;
    data['email'] = _email;
    data['phone'] = _phone;
    data['type'] = _type;
    data['img'] = _img;
    data['qr_value'] = _qrValue;
    data['status'] = _status;
    data['company'] = _company;
    data['transanction_id'] = _transanctionId;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}
