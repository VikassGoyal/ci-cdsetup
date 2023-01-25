class ImageUploadRequest {
  bool? _isUploaded;
  String? _imageUrl;
  String? _base64data;

  ImageUploadRequest({bool? isUploaded, String? imageUrl, String? base64data}) {
    _isUploaded = isUploaded;
    _imageUrl = imageUrl;
    _base64data = base64data;
  }

  bool? get isUploaded => _isUploaded;
  set isUploaded(bool? isUploaded) => _isUploaded = isUploaded;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;
  String? get base64data => _base64data;
  set base64data(String? base64data) => _base64data = base64data;

  ImageUploadRequest.fromJson(Map<String, dynamic> json) {
    _isUploaded = json['isUploaded'];
    _imageUrl = json['imageUrl'];
    _base64data = json['base64data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isUploaded'] = _isUploaded;
    data['imageUrl'] = _imageUrl;
    data['base64data'] = _base64data;
    return data;
  }
}
