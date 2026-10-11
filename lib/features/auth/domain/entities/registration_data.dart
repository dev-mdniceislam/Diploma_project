import 'package:diploma_job/features/home_screen/domain/entities/job.dart';

import 'auth_enums.dart';

class RegistrationData {
  const RegistrationData({
    required this.role,
    required this.name,
    required this.email,
    required this.password,
    this.polytechnic,
    this.tech,
    this.industry,
    this.website,
  });

  final UserRole role;

  /// Student full name, or company name.
  final String name;
  final String email;
  final String password;
  final Polytechnic? polytechnic;
  final JobTech? tech;
  final Industry? industry;
  final String? website;
}
