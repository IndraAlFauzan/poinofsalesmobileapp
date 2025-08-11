class LoginModelRequest {
  String email;
  String password;

  LoginModelRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
