class LoginResponse {
  bool? _status;
  String? _message;
  int? _otp;

  LoginResponse({bool? status, String? message, int? otp}) {
    _status = status;
    _message = message;
    _otp = otp;
  }

  LoginResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    data['message'] = _message;
    data['otp'] = _otp;
    return data;
  }
}
