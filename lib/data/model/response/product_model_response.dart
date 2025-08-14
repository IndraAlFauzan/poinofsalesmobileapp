import 'dart:convert';

ProductModelResponse productResponeFromJson(String str) =>
    ProductModelResponse.fromJson(json.decode(str));

String productResponeToJson(ProductModelResponse data) =>
    json.encode(data.toJson());

class ProductModelResponse {
  bool success;
  String message;
  List<Product> data;

  ProductModelResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProductModelResponse.fromJson(Map<String, dynamic> json) =>
      ProductModelResponse(
        success: json["success"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Product {
  int id;
  int categoryId;
  String name;
  double price;
  int stock;
  String? photoUrl; // Changed to nullable
  String category;

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.stock,
    this.photoUrl, // Changed to optional
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    price: json["price"].toDouble(),
    stock: json["stock"],
    photoUrl: json["photo_url"], // Will be null if API returns null
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "price": price,
    "stock": stock,
    "photo_url": photoUrl,
    "category": category,
  };
}
