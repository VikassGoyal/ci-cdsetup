import 'package:conet/models/imageUploadRequest.dart';

class EntrepreneurDataRequest {
  int? _id;
  String? _company;
  String? _website;
  String? _workNature;
  List<ImageUploadRequest>? _images;

  EntrepreneurDataRequest(
      {int? id,
      int? professionalId,
      String? company,
      String? website,
      String? workNature,
      List<ImageUploadRequest>? images}) {
    _company = company;
    _website = website;
    _workNature = workNature;
    _images = images;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get company => _company;
  set company(String? company) => _company = company;
  String? get website => _website;
  set website(String? website) => _website = website;
  String? get workNature => _workNature;
  set workNature(String? workNature) => _workNature = workNature;
  List<ImageUploadRequest>? get images => _images;
  set images(List<ImageUploadRequest>? images) => _images = images;

  EntrepreneurDataRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _company = json['company'];
    _website = json['website'];
    _workNature = json['workNature'];
    if (json['images'] != null) {
      _images = <ImageUploadRequest>[];
      json['images'].forEach((v) {
        _images?.add(ImageUploadRequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['company'] = _company;
    data['website'] = _website;
    data['workNature'] = _workNature;
    data['images'] = _images?.map((v) => v.toJson()).toList();
    return data;
  }
}
