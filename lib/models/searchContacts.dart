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
  String? _occupation;
  String? _industry;
  String? _company;
  String? _company_website;
  String? _school_university;
  String? _grade;
  String? _work_nature;
  String? _designation;
  List<String>? _keyword;
  String? _facebook;
  String? _instagram;
  String? _twitter;
  String? _skype;

  SearchContacts(
      {int? id,
      String? name,
      String? profileImage,
      String? qrValue,
      String? via,
      int? viaId,
      String? status,
      List<MutualList>? mutualList,
      int? listcount,
      bool? visible,
      String? occupation,
      String? industry,
      String? company,
      String? company_website,
      String? school_university,
      String? grade,
      String? work_nature,
      String? designation,
      List<String>? keyword,
      String? facebook,
      String? instagram,
      String? twitter,
      String? skype}) {
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
    _occupation = occupation;
    _industry = industry;
    _company = company;
    _company_website = company_website;
    _school_university = school_university;
    _grade = grade;
    _work_nature = work_nature;
    _designation = designation;
    _keyword = keyword;
    _facebook = facebook;
    _instagram = instagram;
    _twitter = twitter;
    _skype = skype;
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

  String? get occupation => _occupation;
  set occupation(String? occupation) => _occupation = occupation;

  String? get industry => _industry;
  set industry(String? industry) => _industry = industry;

  String? get company => _company;
  set company(String? company) => _company = company;

  String? get company_website => _name;
  set company_website(String? company_website) => _company_website = company_website;

  String? get school_university => _school_university;
  set school_university(String? school_university) => _school_university = school_university;

  String? get grade => _grade;
  set grade(String? grade) => _grade = grade;

  String? get work_nature => _work_nature;
  set work_nature(String? work_nature) => _work_nature = work_nature;

  String? get designation => _designation;
  set designation(String? designation) => _designation = designation;

  set keyword(List<String>? keyword) => _keyword = keyword;
  List<String>? get keyword => _keyword;

  String? get facebook => _facebook;
  set facebook(String? facebook) => _facebook = facebook;

  String? get instagram => _instagram;
  set instagram(String? instagram) => _instagram = instagram;

  String? get twitter => _twitter;
  set twitter(String? twitter) => _twitter = twitter;

  String? get skype => _skype;
  set skype(String? skype) => _skype = skype;
  SearchContacts.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _profileImage = json['profile_image'];
    _qrValue = json['qr_value'];
    _via = json['via'];
    _viaId = json['via_id'];
    _status = json['status'];
    _occupation = json['occupation'];
    _industry = json['industry'];
    _company = json['company'];
    _company_website = json['company_website'];
    _school_university = json['school_university'];
    _grade = json['grade'];
    _work_nature = json['work_nature'];
    _designation = json['designation'];
    _keyword = json["keyword"] != null ? json["keyword"].split(',') : [];
    _facebook = json['facebook'];
    _instagram = json['instagram'];
    _twitter = json['twitter'];
    _skype = json['skype'];

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
    data['occupation'] = _occupation;
    data['industry'] = _industry;
    data['company'] = _company;
    data['company_website'] = _company_website;
    data['school_university'] = _school_university;
    data['grade'] = _grade;
    data['work_nature'] = _work_nature;
    data['designation'] = _designation;
    data['keyword'] = _keyword;
    data['facebook'] = _facebook;
    data['instagram'] = _instagram;
    data['twitter'] = _twitter;
    data['skype'] = _skype;

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
