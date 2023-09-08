import 'package:image_picker/image_picker.dart';

class ImageUploadModel {
  int? _id;
  int? _professionalId;
  bool? _isUploaded;
  String? _imageUrl;
  String? _imageAsset;
  String? _base64data;

  ImageUploadModel(
      {int? id, int? professionalId, bool? isUploaded, String? imageUrl, String? imageAsset, String? base64data}) {
    _isUploaded = isUploaded;
    _imageUrl = imageUrl;
    _imageAsset = imageAsset;
    _base64data = base64data;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get professionalId => _professionalId;
  set professionalId(int? professionalId) => _professionalId = professionalId;
  bool? get isUploaded => _isUploaded;
  set isUploaded(bool? isUploaded) => _isUploaded = isUploaded;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;
  String get imageAsset => _imageAsset!;
  set imageAsset(String imageAsset) => _imageAsset = imageAsset;
  String? get base64data => _base64data;
  set base64data(String? base64data) => _base64data = base64data;

  ImageUploadModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _professionalId = json['professional_id'];
    _isUploaded = json['isUploaded'];
    _imageUrl = json['imageUrl'];
    _imageAsset = json['imageAsset'];
    _base64data = json['base64data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['professional_id'] = _professionalId;
    data['isUploaded'] = _isUploaded;
    data['imageUrl'] = _imageUrl;
    data['imageAsset'] = _imageAsset;
    data['base64data'] = _base64data;
    return data;
  }
}
