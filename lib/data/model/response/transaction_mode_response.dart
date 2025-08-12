class AllTransactionModelResponse {
  bool success;
  String message;
  List<Transaction> data;

  AllTransactionModelResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AllTransactionModelResponse.fromJson(Map<String, dynamic> json) =>
      AllTransactionModelResponse(
        success: json["success"],
        message: json["message"],
        data: List<Transaction>.from(
          json["data"].map((x) => Transaction.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetByIdTransactionModelResponse {
  bool success;
  String message;
  Transaction data;

  GetByIdTransactionModelResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetByIdTransactionModelResponse.fromJson(Map<String, dynamic> json) =>
      GetByIdTransactionModelResponse(
        success: json["success"],
        message: json["message"],
        data: Transaction.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Transaction {
  int transactionId;
  DateTime createdAt;
  int userId;
  int paymentMethodId;
  int total;
  int paymentAmount;
  int changeAmount;
  String nameUser;
  String paymentMethod;
  String serviceType;
  List<TransactionDetail> details;

  Transaction({
    required this.transactionId,
    required this.createdAt,
    required this.userId,
    required this.paymentMethodId,
    required this.total,
    required this.paymentAmount,
    required this.changeAmount,
    required this.nameUser,
    required this.paymentMethod,
    required this.serviceType,
    required this.details,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    transactionId: json["transaction_id"],
    createdAt: DateTime.parse(json["created_at"]),
    userId: json["user_id"],
    paymentMethodId: json["payment_method_id"],
    total: json["total"],
    paymentAmount: json["payment_amount"],
    changeAmount: json["change_amount"],
    nameUser: json["name_user"],
    paymentMethod: json["payment_method"],
    serviceType: json["service_type"],
    details: List<TransactionDetail>.from(
      json["details"].map((x) => TransactionDetail.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "transaction_id": transactionId,
    "created_at": createdAt.toIso8601String(),
    "user_id": userId,
    "payment_method_id": paymentMethodId,
    "total": total,
    "payment_amount": paymentAmount,
    "change_amount": changeAmount,
    "name_user": nameUser,
    "payment_method": paymentMethod,
    "service_type": serviceType,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class TransactionDetail {
  int id;
  int productId;
  String nameProduct;
  int quantity;
  int? flavorId;
  String? flavor;
  int? spicyLevelId;
  String? spicyLevel;
  String? note;
  int price;
  int subtotal;

  TransactionDetail({
    required this.id,
    required this.productId,
    required this.nameProduct,
    required this.quantity,
    this.flavorId,
    this.flavor,
    this.spicyLevelId,
    this.spicyLevel,
    this.note,
    required this.price,
    required this.subtotal,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) =>
      TransactionDetail(
        id: json["id"],
        productId: json["product_id"],
        nameProduct: json["name_product"],
        quantity: json["quantity"],
        flavorId: json["flavor_id"],
        flavor: json["flavor"],
        spicyLevelId: json["spicy_level_id"],
        spicyLevel: json["spicy_level"],
        note: json["note"],
        price: json["price"],
        subtotal: json["subtotal"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "name_product": nameProduct,
    "quantity": quantity,
    "flavor_id": flavorId,
    "flavor": flavor,
    "spicy_level_id": spicyLevelId,
    "spicy_level": spicyLevel,
    "note": note,
    "price": price,
    "subtotal": subtotal,
  };
}
