import 'dart:convert';

PaymentSettleResponse paymentSettleResponseFromJson(String str) =>
    PaymentSettleResponse.fromJson(json.decode(str));

String paymentSettleResponseToJson(PaymentSettleResponse data) =>
    json.encode(data.toJson());

class PaymentSettleResponse {
  final bool success;
  final String message;
  final String? checkoutUrl;
  final PaymentSettleData data;

  PaymentSettleResponse({
    required this.success,
    required this.message,
    this.checkoutUrl,
    required this.data,
  });

  factory PaymentSettleResponse.fromJson(Map<String, dynamic> json) =>
      PaymentSettleResponse(
        success: json["success"],
        message: json["message"],
        checkoutUrl: json["checkout_url"],
        data: PaymentSettleData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "checkout_url": checkoutUrl,
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
  final String status;
  final String? providerRef;
  final DateTime? expiresAt;
  final String feeAmount; // Non-nullable with safe default "0"
  final String netAmount; // Non-nullable with safe default "0"
  final DateTime createdAt;
  final DateTime updatedAt;
  final String method;
  final String? cashier;
  final List<PaymentTransaction> transactions;

  PaymentSettleData({
    required this.paymentId,
    required this.paymentMethodId,
    required this.amount,
    this.tenderedAmount,
    required this.changeAmount,
    required this.receivedAt,
    this.note,
    required this.status,
    this.providerRef,
    this.expiresAt,
    required this.feeAmount, // Made required with safe default
    required this.netAmount, // Made required with safe default
    required this.createdAt,
    required this.updatedAt,
    required this.method,
    this.cashier,
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
        status: json["status"],
        providerRef: json["provider_ref"],
        expiresAt: json["expires_at"] != null
            ? DateTime.parse(json["expires_at"])
            : null,
        feeAmount: json["fee_amount"]?.toString() ?? "0", // Safe handling
        netAmount: json["net_amount"]?.toString() ?? "0", // Safe handling
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
    "status": status,
    "provider_ref": providerRef,
    "expires_at": expiresAt?.toIso8601String(),
    "fee_amount": feeAmount,
    "net_amount": netAmount,
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
        success: json["success"] ?? false,
        message: json["message"] ?? "Unknown error",
        data: json["data"] != null
            ? List<PaymentData>.from(
                json["data"].map((x) => PaymentData.fromJson(x)),
              )
            : [],
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
  final String status;
  final String? providerRef;
  final DateTime? expiresAt;
  final String feeAmount;
  final String netAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String method;
  final String? cashier;
  final List<PaymentTransaction> transactions;

  PaymentData({
    required this.id,
    required this.paymentMethodId,
    required this.amount,
    this.tenderedAmount,
    required this.changeAmount,
    required this.receivedAt,
    this.note,
    required this.status,
    this.providerRef,
    this.expiresAt,
    required this.feeAmount,
    required this.netAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.method,
    this.cashier,
    required this.transactions,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
    id: json["id"],
    paymentMethodId: json["payment_method_id"],
    amount: json["amount"]?.toString() ?? "0",
    tenderedAmount: json["tendered_amount"]?.toString(),
    changeAmount: json["change_amount"]?.toString() ?? "0",
    receivedAt: DateTime.parse(json["received_at"]),
    note: json["note"],
    status: json["status"] ?? "unknown",
    providerRef: json["provider_ref"],
    expiresAt: json["expires_at"] != null
        ? DateTime.parse(json["expires_at"])
        : null,
    feeAmount: json["fee_amount"]?.toString() ?? "0",
    netAmount: json["net_amount"]?.toString() ?? "0",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    method: json["method"] ?? "unknown",
    cashier: json["cashier"],
    transactions: List<PaymentTransaction>.from(
      json["transactions"]?.map((x) => PaymentTransaction.fromJson(x)) ?? [],
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
    "status": status,
    "provider_ref": providerRef,
    "expires_at": expiresAt?.toIso8601String(),
    "fee_amount": feeAmount,
    "net_amount": netAmount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "method": method,
    "cashier": cashier,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class PaymentTransaction {
  final int id;
  final int? transactionId;
  final String orderNo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? tableNo;
  final String customerName;
  final String? noTable;
  final int? userId;
  final String serviceType;
  final String status;
  final String allocatedAmount;
  final String grandTotal;
  final String paidTotal;
  final String balanceDue;
  final DateTime? paidAt;
  final List<PaymentTransactionDetail> detailTransaction;

  PaymentTransaction({
    required this.id,
    this.transactionId,
    required this.orderNo,
    this.createdAt,
    this.updatedAt,
    this.tableNo,
    required this.customerName,
    this.noTable,
    this.userId,
    required this.serviceType,
    required this.status,
    required this.allocatedAmount,
    required this.grandTotal,
    required this.paidTotal,
    required this.balanceDue,
    this.paidAt,
    required this.detailTransaction,
  });

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) =>
      PaymentTransaction(
        id: json["id"] ?? json["transaction_id"],
        transactionId: json["transaction_id"],
        orderNo: json["order_no"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        tableNo: json["table_no"],
        customerName: json["customer_name"],
        noTable: json["no_table"],
        userId: json["user_id"],
        serviceType: json["service_type"],
        status: json["status"],
        allocatedAmount: json["allocated_amount"],
        grandTotal: json["grand_total"],
        paidTotal: json["paid_total"],
        balanceDue: json["balance_due"],
        paidAt: json["paid_at"] != null
            ? DateTime.parse(json["paid_at"])
            : null,
        detailTransaction: List<PaymentTransactionDetail>.from(
          json["detail_transaction"].map(
            (x) => PaymentTransactionDetail.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_id": transactionId,
    "order_no": orderNo,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "table_no": tableNo,
    "customer_name": customerName,
    "no_table": noTable,
    "user_id": userId,
    "service_type": serviceType,
    "status": status,
    "allocated_amount": allocatedAmount,
    "grand_total": grandTotal,
    "paid_total": paidTotal,
    "balance_due": balanceDue,
    "paid_at": paidAt?.toIso8601String(),
    "detail_transaction": List<dynamic>.from(
      detailTransaction.map((x) => x.toJson()),
    ),
  };
}

class PaymentTransactionDetail {
  final int id;
  final int? productId;
  final String productName;
  final int quantity;
  final String price;
  final String subtotal;
  final String? flavor;
  final String? spicyLevel;
  final String? note;

  PaymentTransactionDetail({
    required this.id,
    this.productId,
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
        price: json["price"].toString(),
        subtotal: json["subtotal"].toString(),
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
