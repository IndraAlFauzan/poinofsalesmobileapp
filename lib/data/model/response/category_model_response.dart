import 'dart:convert';

CategoryModelResponse categoryResponeFromJson(String str) =>
    CategoryModelResponse.fromJson(json.decode(str));

String categoryResponeToJson(CategoryModelResponse data) =>
    json.encode(data.toJson());

class CategoryModelResponse {
  bool success;
  String message;
  List<Category> data;

  CategoryModelResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoryModelResponse.fromJson(Map<String, dynamic> json) =>
      CategoryModelResponse(
        success: json["success"],
        message: json["message"],
        data: List<Category>.from(
          json["data"].map((x) => Category.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Category {
  int id;
  String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
