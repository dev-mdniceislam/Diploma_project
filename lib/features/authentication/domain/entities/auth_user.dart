enum UserRole { student, company }

class AuthUser {
  const AuthUser({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    required this.token,
  });

  final String id;
  final UserRole role;
  final String name;
  final String email;
  final String token;
}

class RegisterInput {
  const RegisterInput({
    required this.role,
    required this.name,
    required this.email,
    required this.otp,
    required this.password,
  });

  final UserRole role;
  final String name;
  final String email;
  final String otp;
  final String password;
}
