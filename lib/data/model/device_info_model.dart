import 'dart:convert';

class DeviceInfoModel {
  final String name;
  final String deviceId;
  final String? IP;
  DeviceInfoModel({required this.name, required this.deviceId , this.IP});

  Map<String, String> toMap() {
    return {
      'name': name,
      'deviceId': deviceId,
      'IP': IP.toString(),
    };
  }

  factory DeviceInfoModel.fromMap(Map<String, String> map) {
    return DeviceInfoModel(
      name: map['name'] ?? '',
      deviceId: map['deviceId'] ?? '',
      IP: map['IP'] ,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceInfoModel.fromJson(String source) => DeviceInfoModel.fromMap(json.decode(source));
}
