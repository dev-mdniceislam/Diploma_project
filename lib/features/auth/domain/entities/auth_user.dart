import 'package:diploma_job/features/home_screen/domain/entities/job.dart';

import 'auth_enums.dart';

class AuthUser {
  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.polytechnic,
    this.tech,
    this.organization,
  });

  final String id;
  final String name;
  final String email;
  final UserRole role;

  // student
  final Polytechnic? polytechnic;
  final JobTech? tech;

  // company
  final String? organization;

  String get initial =>
      name.isEmpty ? '?' : String.fromCharCode(name.runes.first).toUpperCase();
}
