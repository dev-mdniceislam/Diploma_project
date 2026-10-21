class UserLoginModel {
  final String id;
  final String role;
  final String name;
  final String email;
  final String token;

  UserLoginModel({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    required this.token,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      id: json['id'] ?? '',
      role: json['role'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
