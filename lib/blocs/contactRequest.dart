class NotificationResponse {
  int? _id;
  String? _name;
  String? _phone;
  String? _email;
  String? _profileImage;
  String? _fromContactId;
  String? _requestedBy;
  String? _status;
  String? _type;
  String? _createdAt;

  NotificationResponse(
      {int? id,
      String? name,
      String? phone,
      String? email,
      String? profileImage,
      String? fromContactId,
      String? requestedBy,
      String? status,
      String? type,
      String? createdAt}) {
    _id = id;
    _name = name;
    _phone = phone;
    _email = email;
    _profileImage = profileImage;
    _fromContactId = fromContactId;
    _requestedBy = requestedBy;
    _status = status;
    _type = type;
    _createdAt = createdAt;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;
  String? get fromContactId => _fromContactId;
  set fromContactId(String? fromContactId) => _fromContactId = fromContactId;
  String? get requestedBy => _requestedBy;
  set requestedBy(String? requestedBy) => _requestedBy = requestedBy;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
    _profileImage = json['profile_image'];
    _fromContactId = json['from_contact_id'];
    _requestedBy = json['requested_by'];
    _status = json['status'];
    _type = json['type'];
    _createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['phone'] = _phone;
    data['email'] = _email;
    data['profile_image'] = _profileImage;
    data['from_contact_id'] = _fromContactId;
    data['requested_by'] = _requestedBy;
    data['status'] = _status;
    data['type'] = _type;
    data['created_at'] = _createdAt;
    return data;
  }
}
