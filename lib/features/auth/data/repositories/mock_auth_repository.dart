import 'package:diploma_job/features/home_screen/domain/entities/job.dart';

import '../../domain/entities/auth_enums.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/entities/registration_data.dart';
import '../../domain/repositories/auth_repository.dart';

/// Mock backend — any credentials work (same as the HTML prototype).
/// Swap for an API/Firebase implementation; nothing else changes.
class MockAuthRepository implements AuthRepository {
  static const _latency = Duration(milliseconds: 600);

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
    required UserRole role,
  }) async {
    await Future<void>.delayed(_latency);
    return role == UserRole.student ? _student(email) : _company(email);
  }

  @override
  Future<AuthUser> register(RegistrationData data) async {
    await Future<void>.delayed(_latency);
    final id = 'user-${DateTime.now().millisecondsSinceEpoch}';

    if (data.role == UserRole.student) {
      return AuthUser(
        id: id,
        name: data.name,
        email: data.email,
        role: UserRole.student,
        polytechnic: data.polytechnic,
        tech: data.tech,
      );
    }
    return AuthUser(
      id: id,
      name: data.name,
      email: data.email,
      role: UserRole.company,
      organization: data.name,
    );
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return _student('sabbir.dpi@gmail.com');
  }

  @override
  Future<void> sendPasswordReset(String email) =>
      Future<void>.delayed(_latency);

  AuthUser _student(String email) => AuthUser(
        id: 'student-1',
        name: 'মোঃ সাব্বির হোসেন',
        email: email,
        role: UserRole.student,
        polytechnic: Polytechnic.dpi,
        tech: JobTech.computer,
      );

  AuthUser _company(String email) => AuthUser(
        id: 'company-1',
        name: 'ওয়ালটন হাই-টেক HR',
        email: email,
        role: UserRole.company,
        organization: 'ওয়ালটন হাই-টেক পিএলসি (Walton PLC)',
      );
}
