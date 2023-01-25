class DeviceContactData {
  final String? phones;
  final String? givenName;

  DeviceContactData(this.givenName, this.phones);

  DeviceContactData.fromJson(Map<String, dynamic> json)
      : givenName = json['givenName'],
        phones = json['phones'];

  Map<String, dynamic> toJson() => {
        'givenName': givenName,
        'phones': phones,
      };
}
