import 'dart:convert';

LoginModelResponse loginModelResponseFromJson(String str) =>
    LoginModelResponse.fromJson(json.decode(str));

String loginModelResponseToJson(LoginModelResponse data) =>
    json.encode(data.toJson());

class LoginModelResponse {
  bool success;
  String message;
  Data data;

  LoginModelResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginModelResponse.fromJson(Map<String, dynamic> json) =>
      LoginModelResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String accessToken;
  String tokenType;
  int expiresIn;
  int userId;
  String user;

  Data({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.userId,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    userId: json["user_id"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "user_id": userId,
    "user": user,
  };
}
