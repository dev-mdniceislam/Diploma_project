import 'package:diploma_job/features/authentication/domain/entities/auth_user.dart';

abstract interface class AuthRepository {
  Future<void> sendOtp({required String email});
  Future<AuthUser> register(RegisterInput input, {required bool persist});
  Future<AuthUser> login({
    required String email,
    required String password,
    required bool persist,
  });

  Future<void> requestPasswordReset({required String email});
  Future<String> verifyResetOtp({required String email, required String otp});
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  });
}
