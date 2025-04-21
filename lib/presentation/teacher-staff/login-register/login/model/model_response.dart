class LoginResponse {
  final String token;
  final User user;

  LoginResponse({required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? '',
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String userName;
  final String role;

  User({required this.id, required this.userName, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(), // 👈 pastikan dikonversi ke String
      userName: json['user_name'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
