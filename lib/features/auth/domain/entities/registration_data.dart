import 'auth_enums.dart';

class RegistrationData {
  const RegistrationData({
    required this.role,
    required this.name,
    required this.email,
    required this.password,
  });

  final UserRole role;
  final String name;
  final String email;
  final String password;

  Map<String, dynamic> toJson() => {
    'role': role.name,
    'name': name,
    'email': email,
    'password': password,
  };

  factory RegistrationData.fromJson(Map<String, dynamic> json) =>
      RegistrationData(
        role: UserRole.values.firstWhere(
          (e) => e.name == json['role'],
          orElse: () => UserRole.student,
        ),
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        password: json['password'] as String? ?? '',
      );
}
