import '../entities/auth_enums.dart';
import '../entities/auth_user.dart';
import '../entities/registration_data.dart';
import 'auth_repository.dart';

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

    if (data.role == UserRole.student) {
      return AuthUser(
        name: data.name,
        email: data.email,
        role: UserRole.student,
      );
    }
    return AuthUser(name: data.name, email: data.email, role: UserRole.company);
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return _student('sabbir.dpi@gmail.com');
  }

  @override
  Future<void> sendPasswordReset(String email) =>
      Future<void>.delayed(_latency);

  AuthUser _student(String email) =>
      AuthUser(name: 'মোঃ সাব্বির হোসেন', email: email, role: UserRole.student);

  AuthUser _company(String email) => AuthUser(
    name: 'ওয়ালটন হাই-টেক HR',
    email: email,
    role: UserRole.company,
  );
}
