import 'dart:convert';

CategoryResponse categoryResponeFromJson(String str) =>
    CategoryResponse.fromJson(json.decode(str));

String categoryResponeToJson(CategoryResponse data) =>
    json.encode(data.toJson());

class CategoryResponse {
  bool success;
  String message;
  List<Category> data;

  CategoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
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
