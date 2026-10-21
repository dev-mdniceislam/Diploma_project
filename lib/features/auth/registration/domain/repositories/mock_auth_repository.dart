import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../core/endpoints/endpoints.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/gen/api_response_gen.dart';
import '../../../../../core/gen/network_caller_gen.dart';
import '../../../login/data/model/login_model.dart';
import '../../../login/widget/post_for_user.dart';
import '../entities/auth_enums.dart';
import '../entities/registration_data.dart';
import 'auth_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  static const _serverClientId =
      'xxxxxxxx.apps.googleusercontent.com'; // Node er same Web client ID
  static Future<void>? _googleInit;

  Future<void> _ensureGoogleInit() {
    return _googleInit ??= GoogleSignIn.instance.initialize(
      serverClientId: _serverClientId,
    );
  }

  //----------- Email verify for registration --------------
  @override
  Future<bool> verifyEamil({required String email}) async {
    try {
      final response = await NetworkCaller().post<ApiResponseModel<dynamic>>(
        url: Endpoints.registrationSendOtp,
        body: {"email": email.toLowerCase().trim()},
        fromJson: (json) =>
            ApiResponseModel<dynamic>.fromJson(json, (data) => data),
      );

      if (response == null || response.success != true) {
        throw AppException(
          response?.message ?? 'ইমেইল ভেরিফিকেশন কোড পাঠানো যায়নি।',
        );
      }
      return response.success;
    } catch (error) {
      log('=========VerifyEmail Error $error');
      if (error is AppException) rethrow;
      throw AppException(error.toString());
    }
  }

  // ---------- Register ----------
  @override
  Future<UserLoginModel> register(RegistrationData data) async {
    log("=======DAta ${data.toJson()}");
    return await AuthGlobalWidget().postForUser(
      tag: 'Registration',
      url: Endpoints.registration,
      body: data.toJson(),
      failMessage: 'রেজিস্ট্রেশন ব্যর্থ হয়েছে। দয়া করে আবার চেষ্টা করুন।',
    );
  }

  // ---------- Google ----------
  @override
  Future<UserLoginModel> signInWithGoogle({UserRole? role}) async {
    try {
      await _ensureGoogleInit();

      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;

      if (idToken == null) {
        throw const AppException('Google টোকেন পাওয়া যায়নি।');
      }

      return await AuthGlobalWidget().postForUser(
        tag: 'GoogleLogin',
        url: "", //Endpoints.googleLogin, // আপনার এন্ডপয়েন্ট এখানে বসাবেন
        body: {'idToken': idToken, if (role != null) 'role': role.name},
        failMessage: 'Google লগইন ব্যর্থ হয়েছে।',
      );
    } on GoogleSignInException catch (e) {
      log('=========GoogleLogin Error $e');
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw const AppException('Google সাইন-ইন বাতিল করা হয়েছে।');
      }
      throw AppException('Google সাইন-ইন ব্যর্থ হয়েছে।');
    } catch (error) {
      log('=========GoogleLogin Error $error');
      if (error is AppException) rethrow;
      throw AppException(error.toString());
    }
  }
}
