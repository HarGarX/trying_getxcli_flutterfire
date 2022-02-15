import 'dart:convert';

class WightModel {
  final String wight;
  final String dateTime;
  WightModel({
    required this.wight,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'wight': wight,
      'dateTime': dateTime,
    };
  }

  factory WightModel.fromMap(Map<String, dynamic> map) {
    return WightModel(
      wight: map['wight'] ?? '',
      dateTime: map['dateTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WightModel.fromJson(String source) =>
      WightModel.fromMap(json.decode(source));
}
