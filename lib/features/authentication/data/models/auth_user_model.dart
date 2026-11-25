import '../../domain/entities/auth_user.dart';

class AuthUserModel {
  const AuthUserModel({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    required this.token,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => AuthUserModel(
        id: json['id'] as String,
        role: UserRole.values.byName(json['role'] as String),
        name: json['name'] as String,
        email: json['email'] as String,
        token: json['token'] as String,
      );

  final String id;
  final UserRole role;
  final String name;
  final String email;
  final String token;

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role.name,
        'name': name,
        'email': email,
        'token': token,
      };

  AuthUser toEntity() => AuthUser(
        id: id,
        role: role,
        name: name,
        email: email,
        token: token,
      );
}
