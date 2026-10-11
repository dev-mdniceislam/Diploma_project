import '../entities/auth_enums.dart';
import '../entities/auth_user.dart';
import '../entities/registration_data.dart';

abstract interface class AuthRepository {
  Future<AuthUser> login({
    required String email,
    required String password,
    required UserRole role,
  });

  Future<AuthUser> register(RegistrationData data);

  Future<AuthUser> signInWithGoogle();

  Future<void> sendPasswordReset(String email);
}
