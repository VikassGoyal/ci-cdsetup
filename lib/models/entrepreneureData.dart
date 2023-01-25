import 'package:conet/models/imageUploadModel.dart';

class EntrepreneurData {
  int? _id;
  int? _professionalId;
  String? _company;
  String? _website;
  String? _workNature;
  List<ImageUploadModel>? _images;

  EntrepreneurData(
      {int? id,
      int? professionalId,
      String? company,
      String? website,
      String? workNature,
      List<ImageUploadModel>? images}) {
    _company = company;
    _website = website;
    _workNature = workNature;
    _images = images;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get professionalId => _professionalId;
  set professionalId(int? professionalId) => _professionalId = professionalId;
  String? get company => _company;
  set company(String? company) => _company = company;
  String? get website => _website;
  set website(String? website) => _website = website;
  String? get workNature => _workNature;
  set workNature(String? workNature) => _workNature = workNature;
  List<ImageUploadModel>? get images => _images;
  set images(List<ImageUploadModel>? images) => _images = images;

  EntrepreneurData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _professionalId = json['professional_id'];
    _company = json['company'];
    _website = json['website'];
    _workNature = json['workNature'];
    if (json['images'] != null) {
      _images = <ImageUploadModel>[];
      json['images'].forEach((v) {
        _images?.add(ImageUploadModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['professional_id'] = _professionalId;
    data['company'] = _company;
    data['website'] = _website;
    data['workNature'] = _workNature;
    data['images'] = _images?.map((v) => v.toJson()).toList();
    return data;
  }
}
