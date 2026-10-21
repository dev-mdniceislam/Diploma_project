import 'auth_enums.dart';

class RegistrationData {
  const RegistrationData({
    required this.role,
    required this.name,
    required this.email,
    required this.password,
    required this.otp,
  });

  final UserRole role;
  final String name;
  final String email;
  final String otp;
  final String password;

  Map<String, dynamic> toJson() => {
    'role': role.name,
    'name': name,
    'email': email,
    'otp': otp,
    'password': password,
  };
}
