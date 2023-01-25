class SearchContacts {
  int? _id;
  String? _name;
  String? _profileImage;
  String? _qrValue;
  String? _via;
  int? _viaId;
  String? _status;
  List<MutualList>? _mutualList;
  int? _listcount;
  bool? _visible;

  SearchContacts({
    int? id,
    String? name,
    String? profileImage,
    String? qrValue,
    String? via,
    int? viaId,
    String? status,
    List<MutualList>? mutualList,
    int? listcount,
    bool? visible,
  }) {
    _id = id;
    _name = name;
    _profileImage = profileImage;
    _qrValue = qrValue;
    _via = via;
    _viaId = viaId;
    _status = status;
    _mutualList = mutualList;
    _listcount = listcount;
    _visible = visible;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;
  String? get qrValue => _qrValue;
  set qrValue(String? qrValue) => _qrValue = qrValue;
  String? get via => _via;
  set via(String? via) => _via = via;
  int? get viaId => _viaId;
  set viaId(int? viaId) => _viaId = viaId;
  String? get status => _status;
  set status(String? status) => _status = status;
  List<MutualList>? get mutualList => _mutualList;
  set mutualList(List<MutualList>? mutualList) => _mutualList = mutualList;
  int? get listcount => _listcount;
  set listcount(int? listcount) => _listcount = listcount;
  bool? get visible => _visible;
  set visible(bool? visible) => _visible = visible;

  SearchContacts.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _profileImage = json['profile_image'];
    _qrValue = json['qr_value'];
    _via = json['via'];
    _viaId = json['via_id'];
    _status = json['status'];
    if (json['mutual_list'] != null) {
      _mutualList = <MutualList>[];
      json['mutual_list'].forEach((v) {
        _mutualList?.add(MutualList.fromJson(v));
      });
    }
    _listcount = json['listcount'];
    _visible = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['profile_image'] = _profileImage;
    data['qr_value'] = _qrValue;
    data['via'] = _via;
    data['via_id'] = _viaId;
    data['status'] = _status;
    data['mutual_list'] = _mutualList?.map((v) => v.toJson()).toList();
    data['listcount'] = _listcount;
    return data;
  }
}

class MutualList {
  int? _id;
  String? _name;
  String? _profileImage;
  String? _qrValue;
  String? _email;
  String? _phone;
  String? _via;
  int? _viaId;
  String? _status;
  bool? _pushed;

  MutualList(
      {int? id,
      String? name,
      String? profileImage,
      String? qrValue,
      String? email,
      String? phone,
      String? via,
      int? viaId,
      String? status,
      bool? pushed}) {
    _id = id;
    _name = name;
    _profileImage = profileImage;
    _qrValue = qrValue;
    _email = email;
    _phone = phone;
    _via = via;
    _viaId = viaId;
    _status = status;
    _pushed = pushed;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;
  String? get qrValue => _qrValue;
  set qrValue(String? qrValue) => _qrValue = qrValue;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get via => _via;
  set via(String? via) => _via = via;
  int? get viaId => _viaId;
  set viaId(int? viaId) => _viaId = viaId;
  String? get status => _status;
  set status(String? status) => _status = status;
  bool? get pushed => _pushed;
  set pushed(bool? pushed) => _pushed = pushed;

  MutualList.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _profileImage = json['profile_image'];
    _qrValue = json['qr_value'];
    _email = json['email'];
    _phone = json['phone'];
    _via = json['via'];
    _viaId = json['via_id'];
    _status = json['status'];
    _pushed = json['pushed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['profile_image'] = _profileImage;
    data['qr_value'] = _qrValue;
    data['email'] = _email;
    data['phone'] = _phone;
    data['via'] = _via;
    data['via_id'] = _viaId;
    data['status'] = _status;
    data['pushed'] = _pushed;
    return data;
  }
}
