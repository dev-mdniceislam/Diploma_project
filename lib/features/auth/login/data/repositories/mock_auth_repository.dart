import 'dart:developer';

import '../../../../../core/endpoints/endpoints.dart';
import '../../widget/post_for_user.dart';
import '../model/login_model.dart';
import 'auth_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<UserLoginModel> login({
    required String email,
    required String password,
  }) async {
    log("================================");
    return await AuthGlobalWidget().postForUser(
      tag: 'Login',
      url: Endpoints.login,
      body: {'email': email, 'password': password},
      failMessage: 'লগইন ব্যর্থ হয়েছে। দয়া করে আবার চেষ্টা করুন।',
    );
  }
}
