class RecentCalls {
  String? _name;
  String? _callType;
  String? _number;
  int? _timestamp;

  RecentCalls({String? name, String? callType, String? number, int? timestamp}) {
    _name = name;
    _callType = callType;
    _number = number;
    _timestamp = timestamp;
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get callType => _callType;
  set callType(String? callType) => _callType = callType;
  String? get number => _number;
  set number(String? number) => _number = number;
  int? get timestamp => _timestamp;
  set timestamp(int? timestamp) => _timestamp = timestamp;

  RecentCalls.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _callType = json['callType'];
    _number = json['number'];
    _timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['callType'] = _callType;
    data['number'] = _number;
    data['timestamp'] = _timestamp;
    return data;
  }
}
