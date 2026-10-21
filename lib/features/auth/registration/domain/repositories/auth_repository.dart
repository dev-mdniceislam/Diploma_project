import '../../../login/data/model/login_model.dart';
import '../entities/registration_data.dart';

abstract interface class RegisterRepository {
  Future<UserLoginModel?> register(RegistrationData data);
  Future<bool> verifyEamil({required String email});
  Future<UserLoginModel> signInWithGoogle();
}
