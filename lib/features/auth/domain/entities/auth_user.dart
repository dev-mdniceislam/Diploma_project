import 'package:diploma_job/features/home_screen/domain/entities/job.dart';

import 'auth_enums.dart';

class AuthUser {
  const AuthUser({required this.name, required this.email, required this.role});

  final String name;
  final String email;
  final UserRole role;
  String get initial =>
      name.isEmpty ? '?' : String.fromCharCode(name.runes.first).toUpperCase();
}
