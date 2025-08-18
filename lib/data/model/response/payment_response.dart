import 'dart:convert';

PaymentSettleResponse paymentSettleResponseFromJson(String str) =>
    PaymentSettleResponse.fromJson(json.decode(str));

String paymentSettleResponseToJson(PaymentSettleResponse data) =>
    json.encode(data.toJson());

class PaymentSettleResponse {
  final bool success;
  final String message;
  final PaymentSettleData data;

  PaymentSettleResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PaymentSettleResponse.fromJson(Map<String, dynamic> json) =>
      PaymentSettleResponse(
        success: json["success"],
        message: json["message"],
        data: PaymentSettleData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class PaymentSettleData {
  final int paymentId;
  final int paymentMethodId;
  final String amount;
  final String? tenderedAmount;
  final String changeAmount;
  final DateTime receivedAt;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String method;
  final String cashier;
  final List<PaymentTransaction> transactions;

  PaymentSettleData({
    required this.paymentId,
    required this.paymentMethodId,
    required this.amount,
    this.tenderedAmount,
    required this.changeAmount,
    required this.receivedAt,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.method,
    required this.cashier,
    required this.transactions,
  });

  factory PaymentSettleData.fromJson(Map<String, dynamic> json) =>
      PaymentSettleData(
        paymentId: json["id"],
        paymentMethodId: json["payment_method_id"],
        amount: json["amount"],
        tenderedAmount: json["tendered_amount"],
        changeAmount: json["change_amount"],
        receivedAt: DateTime.parse(json["received_at"]),
        note: json["note"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        method: json["method"],
        cashier: json["cashier"],
        transactions: List<PaymentTransaction>.from(
          json["transactions"].map((x) => PaymentTransaction.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "id": paymentId,
    "payment_method_id": paymentMethodId,
    "amount": amount,
    "tendered_amount": tenderedAmount,
    "change_amount": changeAmount,
    "received_at": receivedAt.toIso8601String(),
    "note": note,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "method": method,
    "cashier": cashier,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

PaymentsResponse paymentsResponseFromJson(String str) =>
    PaymentsResponse.fromJson(json.decode(str));

String paymentsResponseToJson(PaymentsResponse data) =>
    json.encode(data.toJson());

class PaymentsResponse {
  final bool success;
  final String message;
  final List<PaymentData> data;

  PaymentsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PaymentsResponse.fromJson(Map<String, dynamic> json) =>
      PaymentsResponse(
        success: json["success"],
        message: json["message"],
        data: List<PaymentData>.from(
          json["data"].map((x) => PaymentData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PaymentData {
  final int id;
  final int paymentMethodId;
  final String amount;
  final String? tenderedAmount;
  final String changeAmount;
  final DateTime receivedAt;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String method;
  final String cashier;
  final List<PaymentTransaction> transactions;

  PaymentData({
    required this.id,
    required this.paymentMethodId,
    required this.amount,
    this.tenderedAmount,
    required this.changeAmount,
    required this.receivedAt,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.method,
    required this.cashier,
    required this.transactions,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
    id: json["id"],
    paymentMethodId: json["payment_method_id"],
    amount: json["amount"],
    tenderedAmount: json["tendered_amount"],
    changeAmount: json["change_amount"],
    receivedAt: DateTime.parse(json["received_at"]),
    note: json["note"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    method: json["method"],
    cashier: json["cashier"],
    transactions: List<PaymentTransaction>.from(
      json["transactions"].map((x) => PaymentTransaction.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "payment_method_id": paymentMethodId,
    "amount": amount,
    "tendered_amount": tenderedAmount,
    "change_amount": changeAmount,
    "received_at": receivedAt.toIso8601String(),
    "note": note,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "method": method,
    "cashier": cashier,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class PaymentTransaction {
  final int id;
  final String orderNo;
  final String customerName;
  final String noTable;
  final String serviceType;
  final String status;
  final String allocatedAmount;
  final String grandTotal;
  final String paidTotal;
  final String balanceDue;
  final DateTime paidAt;
  final List<PaymentTransactionDetail> detailTransaction;

  PaymentTransaction({
    required this.id,
    required this.orderNo,
    required this.customerName,
    required this.noTable,
    required this.serviceType,
    required this.status,
    required this.allocatedAmount,
    required this.grandTotal,
    required this.paidTotal,
    required this.balanceDue,
    required this.paidAt,
    required this.detailTransaction,
  });

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) =>
      PaymentTransaction(
        id: json["id"],
        orderNo: json["order_no"],
        customerName: json["customer_name"],
        noTable: json["no_table"],
        serviceType: json["service_type"],
        status: json["status"],
        allocatedAmount: json["allocated_amount"],
        grandTotal: json["grand_total"],
        paidTotal: json["paid_total"],
        balanceDue: json["balance_due"],
        paidAt: DateTime.parse(json["paid_at"]),
        detailTransaction: List<PaymentTransactionDetail>.from(
          json["detail_transaction"].map(
            (x) => PaymentTransactionDetail.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_no": orderNo,
    "customer_name": customerName,
    "no_table": noTable,
    "service_type": serviceType,
    "status": status,
    "allocated_amount": allocatedAmount,
    "grand_total": grandTotal,
    "paid_total": paidTotal,
    "balance_due": balanceDue,
    "paid_at": paidAt.toIso8601String(),
    "detail_transaction": List<dynamic>.from(
      detailTransaction.map((x) => x.toJson()),
    ),
  };
}

class PaymentTransactionDetail {
  final int id;
  final int productId;
  final String productName;
  final int quantity;
  final int price;
  final int subtotal;
  final String? flavor;
  final String? spicyLevel;
  final String? note;

  PaymentTransactionDetail({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.subtotal,
    this.flavor,
    this.spicyLevel,
    this.note,
  });

  factory PaymentTransactionDetail.fromJson(Map<String, dynamic> json) =>
      PaymentTransactionDetail(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        price: json["price"],
        subtotal: json["subtotal"],
        flavor: json["flavor"],
        spicyLevel: json["spicy_level"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "product_name": productName,
    "quantity": quantity,
    "price": price,
    "subtotal": subtotal,
    "flavor": flavor,
    "spicy_level": spicyLevel,
    "note": note,
  };
}
