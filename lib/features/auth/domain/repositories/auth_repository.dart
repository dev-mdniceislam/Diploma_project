import 'package:diploma_job/features/auth/data/model/login_model.dart';

import '../entities/registration_data.dart';

abstract interface class AuthRepository {
  Future<UserLoginModel> login({
    required String email,
    required String password,
  });

  Future<UserLoginModel?> register(RegistrationData data);
  Future<UserLoginModel> signInWithGoogle();
  Future<void> sendPasswordReset(String email);
}
