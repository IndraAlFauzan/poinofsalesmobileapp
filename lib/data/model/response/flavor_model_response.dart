// To parse this JSON data, do
//
//     final flavorsResnponse = flavorsResnponseFromJson(jsonString);

import 'dart:convert';

FlavorsModelResnponse flavorsModelResnponseFromJson(String str) =>
    FlavorsModelResnponse.fromJson(json.decode(str));

String flavorsModelResnponseToJson(FlavorsModelResnponse data) =>
    json.encode(data.toJson());

class FlavorsModelResnponse {
  bool success;
  String message;
  List<Flavor> data;

  FlavorsModelResnponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FlavorsModelResnponse.fromJson(Map<String, dynamic> json) =>
      FlavorsModelResnponse(
        success: json["success"],
        message: json["message"],
        data: List<Flavor>.from(json["data"].map((x) => Flavor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Flavor {
  int id;
  String name;

  Flavor({required this.id, required this.name});

  factory Flavor.fromJson(Map<String, dynamic> json) =>
      Flavor(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
