
import '../model/login_model.dart';

abstract interface class LoginRepository {
  Future<UserLoginModel> login({
    required String email,
    required String password,
  });
}
