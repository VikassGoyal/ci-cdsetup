class ContactDetail {
  int? _id;
  int? _userId;
  String? _code;
  String? _name;
  String? _email;
  String? _phone;
  String? _type;
  String? _profileImage;
  String? _img;
  String? _qrValue;
  String? _businesscardLogo;
  String? _status;
  String? _company;
  int? _transanctionId;
  String? _createdAt;
  String? _updatedAt;
  Personal? _personal;
  Professional? _professional;
  List<ProfessionalList>? _professionalList;
  Social? _social;

  ContactDetail(
      {int? id,
      int? userId,
      String? code,
      String? name,
      String? email,
      String? phone,
      String? type,
      String? profileImage,
      String? img,
      String? qrValue,
      String? businesscardLogo,
      String? status,
      String? company,
      int? transanctionId,
      String? createdAt,
      String? updatedAt,
      Personal? personal,
      Professional? professional,
      List<ProfessionalList>? professionalList,
      Social? social}) {
    _id = id;
    _userId = userId;
    _code = code;
    _name = name;
    _email = email;
    _phone = phone;
    _type = type;
    _profileImage = profileImage;
    _img = img;
    _qrValue = qrValue;
    _businesscardLogo = businesscardLogo;
    _status = status;
    _company = company;
    _transanctionId = transanctionId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _personal = personal;
    _professional = professional;
    _professionalList = professionalList;
    _social = social;
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
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;
  String? get img => _img;
  set img(String? img) => _img = img;
  String? get qrValue => _qrValue;
  set qrValue(String? qrValue) => _qrValue = qrValue;
  String? get businesscardLogo => _businesscardLogo;
  set businesscardLogo(String? businesscardLogo) =>
      _businesscardLogo = businesscardLogo;
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
  Personal? get personal => _personal;
  set personal(Personal? personal) => _personal = personal;
  Professional? get professional => _professional;
  set professional(Professional? professional) => _professional = professional;
  List<ProfessionalList>? get professionalList => _professionalList;
  set professionalList(List<ProfessionalList>? professionalList) =>
      _professionalList = professionalList;
  Social? get social => _social;
  set social(Social? social) => _social = social;

  ContactDetail.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _code = json['code'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _type = json['type'];
    _profileImage = json['profile_image'];
    _img = json['img'];
    _qrValue = json['qr_value'];
    _businesscardLogo = json['businesscard_logo'];
    _status = json['status'];
    _company = json['company'];
    _transanctionId = json['transanction_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _personal =
        json['personal'] != null ? Personal.fromJson(json['personal']) : null;
    _professional = json['professional'] != null
        ? Professional.fromJson(json['professional'])
        : null;
    if (json['professional_list'] != null) {
      _professionalList = <ProfessionalList>[];
      json['professional_list'].forEach((v) {
        _professionalList?.add(ProfessionalList.fromJson(v));
      });
    }
    _social = json['social'] != null ? Social.fromJson(json['social']) : null;
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
    data['profile_image'] = _profileImage;
    data['img'] = _img;
    data['qr_value'] = _qrValue;
    data['businesscard_logo'] = _businesscardLogo;
    data['status'] = _status;
    data['company'] = _company;
    data['transanction_id'] = _transanctionId;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['personal'] = _personal?.toJson();
    data['professional'] = _professional?.toJson();
    data['professional_list'] =
        _professionalList?.map((v) => v.toJson()).toList();
    data['social'] = _social?.toJson();
    return data;
  }
}

class Personal {
  int? _id;
  int? _contactId;
  String? _img;
  String? _number;
  String? _secondaryPhone;
  String? _email;
  String? _dOB;
  String? _address1;
  String? _address2;
  String? _address3;
  String? _city;
  String? _state;
  String? _country;
  String? _pincode;
  int? _landline;
  String? _keyword;
  String? _createdAt;
  String? _updatedAt;

  Personal(
      {int? id,
      int? contactId,
      String? img,
      String? number,
      String? secondaryPhone,
      String? email,
      String? dOB,
      String? address1,
      String? address2,
      String? address3,
      String? city,
      String? state,
      String? country,
      String? pincode,
      int? landline,
      String? keyword,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _contactId = contactId;
    _img = img;
    _number = number;
    _secondaryPhone = secondaryPhone;
    _email = email;
    _dOB = dOB;
    _address1 = address1;
    _address2 = address2;
    _address3 = address3;
    _city = city;
    _state = state;
    _country = country;
    _pincode = pincode;
    _landline = landline;
    _keyword = keyword;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get contactId => _contactId;
  set contactId(int? contactId) => _contactId = contactId;
  String? get img => _img;
  set img(String? img) => _img = img;
  String? get number => _number;
  set number(String? number) => _number = number;
  String? get secondaryPhone => _secondaryPhone;
  set secondaryPhone(String? secondaryPhone) =>
      _secondaryPhone = secondaryPhone;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get dOB => _dOB;
  set dOB(String? dOB) => _dOB = dOB;
  String? get address1 => _address1;
  set address1(String? address1) => _address1 = address1;
  String? get address2 => _address2;
  set address2(String? address2) => _address2 = address2;
  String? get address3 => _address3;
  set address3(String? address3) => _address3 = address3;
  String? get city => _city;
  set city(String? city) => _city = city;
  String? get state => _state;
  set state(String? state) => _state = state;
  String? get country => _country;
  set country(String? country) => _country = country;
  String? get pincode => _pincode;
  set pincode(String? pincode) => _pincode = pincode;
  int? get landline => _landline;
  set landline(int? landline) => _landline = landline;
  String? get keyword => _keyword;
  set keyword(String? keyword) => _keyword = keyword;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  Personal.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _contactId = json['contact_id'];
    _img = json['img'];
    _number = json['number'];
    _secondaryPhone = json['secondary_phone'];
    _email = json['email'];
    _dOB = json['d_o_b'];
    _address1 = json['address_1'];
    _address2 = json['address_2'];
    _address3 = json['address_3'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _pincode = json['pincode'];
    _landline = json['landline'];
    _keyword = json['keyword'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['contact_id'] = _contactId;
    data['img'] = _img;
    data['number'] = _number;
    data['secondary_phone'] = _secondaryPhone;
    data['email'] = _email;
    data['d_o_b'] = _dOB;
    data['address_1'] = _address1;
    data['address_2'] = _address2;
    data['address_3'] = _address3;
    data['city'] = _city;
    data['state'] = _state;
    data['country'] = _country;
    data['pincode'] = _pincode;
    data['landline'] = _landline;
    data['keyword'] = _keyword;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

class Professional {
  int? _id;
  int? _contactId;
  String? _occupation;
  String? _industry;
  String? _company;
  String? _companyWebsite;
  String? _schoolUniversity;
  String? _grade;
  String? _workNature;
  String? _designation;
  String? _createdAt;
  String? _updatedAt;

  Professional(
      {int? id,
      int? contactId,
      String? occupation,
      String? industry,
      String? company,
      String? companyWebsite,
      String? schoolUniversity,
      String? grade,
      String? workNature,
      String? designation,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _contactId = contactId;
    _occupation = occupation;
    _industry = industry;
    _company = company;
    _companyWebsite = companyWebsite;
    _schoolUniversity = schoolUniversity;
    _grade = grade;
    _workNature = workNature;
    _designation = designation;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get contactId => _contactId;
  set contactId(int? contactId) => _contactId = contactId;
  String? get occupation => _occupation;
  set occupation(String? occupation) => _occupation = occupation;
  String? get industry => _industry;
  set industry(String? industry) => _industry = industry;
  String? get company => _company;
  set company(String? company) => _company = company;
  String? get companyWebsite => _companyWebsite;
  set companyWebsite(String? companyWebsite) =>
      _companyWebsite = companyWebsite;
  String? get schoolUniversity => _schoolUniversity;
  set schoolUniversity(String? schoolUniversity) =>
      _schoolUniversity = schoolUniversity;
  String? get grade => _grade;
  set grade(String? grade) => _grade = grade;
  String? get workNature => _workNature;
  set workNature(String? workNature) => _workNature = workNature;
  String? get designation => _designation;
  set designation(String? designation) => _designation = designation;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  Professional.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _contactId = json['contact_id'];
    _occupation = json['occupation'];
    _industry = json['industry'];
    _company = json['company'];
    _companyWebsite = json['company_website'];
    _schoolUniversity = json['school_university'];
    _grade = json['grade'];
    _workNature = json['work_nature'];
    _designation = json['designation'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['contact_id'] = _contactId;
    data['occupation'] = _occupation;
    data['industry'] = _industry;
    data['company'] = _company;
    data['company_website'] = _companyWebsite;
    data['school_university'] = _schoolUniversity;
    data['grade'] = _grade;
    data['work_nature'] = _workNature;
    data['designation'] = _designation;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

class ProfessionalList {
  int? _id;
  int? _contactId;
  String? _occupation;
  String? _industry;
  String? _company;
  String? _companyWebsite;
  String? _schoolUniversity;
  String? _grade;
  String? _workNature;
  String? _designation;
  String? _createdAt;
  String? _updatedAt;
  List<BusinessImages>? _businessImages;

  ProfessionalList(
      {int? id,
      int? contactId,
      String? occupation,
      String? industry,
      String? company,
      String? companyWebsite,
      String? schoolUniversity,
      String? grade,
      String? workNature,
      String? designation,
      String? createdAt,
      String? updatedAt,
      List<BusinessImages>? businessImages}) {
    _id = id;
    _contactId = contactId;
    _occupation = occupation;
    _industry = industry;
    _company = company;
    _companyWebsite = companyWebsite;
    _schoolUniversity = schoolUniversity;
    _grade = grade;
    _workNature = workNature;
    _designation = designation;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _businessImages = businessImages;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get contactId => _contactId;
  set contactId(int? contactId) => _contactId = contactId;
  String? get occupation => _occupation;
  set occupation(String? occupation) => _occupation = occupation;
  String? get industry => _industry;
  set industry(String? industry) => _industry = industry;
  String? get company => _company;
  set company(String? company) => _company = company;
  String? get companyWebsite => _companyWebsite;
  set companyWebsite(String? companyWebsite) =>
      _companyWebsite = companyWebsite;
  String? get schoolUniversity => _schoolUniversity;
  set schoolUniversity(String? schoolUniversity) =>
      _schoolUniversity = schoolUniversity;
  String? get grade => _grade;
  set grade(String? grade) => _grade = grade;
  String? get workNature => _workNature;
  set workNature(String? workNature) => _workNature = workNature;
  String? get designation => _designation;
  set designation(String? designation) => _designation = designation;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  List<BusinessImages>? get businessImages => _businessImages;
  set businessImages(List<BusinessImages>? businessImages) =>
      _businessImages = businessImages;

  ProfessionalList.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _contactId = json['contact_id'];
    _occupation = json['occupation'];
    _industry = json['industry'];
    _company = json['company'];
    _companyWebsite = json['company_website'];
    _schoolUniversity = json['school_university'];
    _grade = json['grade'];
    _workNature = json['work_nature'];
    _designation = json['designation'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['business_images'] != null) {
      _businessImages = <BusinessImages>[];
      json['business_images'].forEach((v) {
        _businessImages?.add(BusinessImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['contact_id'] = _contactId;
    data['occupation'] = _occupation;
    data['industry'] = _industry;
    data['company'] = _company;
    data['company_website'] = _companyWebsite;
    data['school_university'] = _schoolUniversity;
    data['grade'] = _grade;
    data['work_nature'] = _workNature;
    data['designation'] = _designation;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['business_images'] = _businessImages?.map((v) => v.toJson()).toList();
    return data;
  }
}

class BusinessImages {
  int? _id;
  int? _professionalId;
  int? _contactId;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  BusinessImages(
      {int? id,
      int? professionalId,
      int? contactId,
      String? image,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _professionalId = professionalId;
    _contactId = contactId;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get professionalId => _professionalId;
  set professionalId(int? professionalId) => _professionalId = professionalId;
  int? get contactId => _contactId;
  set contactId(int? contactId) => _contactId = contactId;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  BusinessImages.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _professionalId = json['professional_id'];
    _contactId = json['contact_id'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['professional_id'] = _professionalId;
    data['contact_id'] = _contactId;
    data['image'] = _image;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

class Social {
  int? _id;
  int? _contactId;
  String? _facebook;
  String? _instagram;
  String? _twitter;
  String? _skype;
  String? _gpay;
  String? _paytm;
  String? _createdAt;
  String? _updatedAt;

  Social(
      {int? id,
      int? contactId,
      String? facebook,
      String? instagram,
      String? twitter,
      String? skype,
      String? gpay,
      String? paytm,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _contactId = contactId;
    _facebook = facebook;
    _instagram = instagram;
    _twitter = twitter;
    _skype = skype;
    _gpay = gpay;
    _paytm = paytm;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get contactId => _contactId;
  set contactId(int? contactId) => _contactId = contactId;
  String? get facebook => _facebook;
  set facebook(String? facebook) => _facebook = facebook;
  String? get instagram => _instagram;
  set instagram(String? instagram) => _instagram = instagram;
  String? get twitter => _twitter;
  set twitter(String? twitter) => _twitter = twitter;
  String? get skype => _skype;
  set skype(String? skype) => _skype = skype;
  String? get gpay => _gpay;
  set gpay(String? gpay) => _gpay = gpay;
  String? get paytm => _paytm;
  set paytm(String? paytm) => _paytm = paytm;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  Social.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _contactId = json['contact_id'];
    _facebook = json['facebook'];
    _instagram = json['instagram'];
    _twitter = json['twitter'];
    _skype = json['skype'];
    _gpay = json['gpay'];
    _paytm = json['paytm'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['contact_id'] = _contactId;
    data['facebook'] = _facebook;
    data['instagram'] = _instagram;
    data['twitter'] = _twitter;
    data['skype'] = _skype;
    data['gpay'] = _gpay;
    data['paytm'] = _paytm;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}
