class TableResponse {
  final bool success;
  final String message;
  final List<TableData> data;

  TableResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TableResponse.fromJson(Map<String, dynamic> json) {
    return TableResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => TableData.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class TableData {
  final int id;
  final String tableNo;
  final int capacity;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  TableData({
    required this.id,
    required this.tableNo,
    required this.capacity,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TableData.fromJson(Map<String, dynamic> json) {
    return TableData(
      id: json['id'] ?? 0,
      tableNo: json['table_no'] ?? '',
      capacity: json['capacity'] ?? 0,
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
