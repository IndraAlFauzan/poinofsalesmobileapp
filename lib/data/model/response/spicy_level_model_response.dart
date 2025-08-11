// To parse this JSON data, do
//
//     final spicyLevelResnponse = spicyLevelResnponseFromJson(jsonString);

import 'dart:convert';

SpicyLevelModelResponse spicyLevelModelResnponseFromJson(String str) =>
    SpicyLevelModelResponse.fromJson(json.decode(str));

String spicyLevelModelResnponseToJson(SpicyLevelModelResponse data) =>
    json.encode(data.toJson());

class SpicyLevelModelResponse {
  bool success;
  List<SpicyLevel> data;

  SpicyLevelModelResponse({required this.success, required this.data});

  factory SpicyLevelModelResponse.fromJson(Map<String, dynamic> json) =>
      SpicyLevelModelResponse(
        success: json["success"],
        data: List<SpicyLevel>.from(
          json["data"].map((x) => SpicyLevel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SpicyLevel {
  int id;
  String name;

  SpicyLevel({required this.id, required this.name});

  factory SpicyLevel.fromJson(Map<String, dynamic> json) =>
      SpicyLevel(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
