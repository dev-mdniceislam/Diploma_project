import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/endpoints/endpoints.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/gen/api_response_gen.dart';
import '../../../../core/gen/network_caller_gen.dart';
import '../../data/model/login_model.dart';
import '../entities/auth_enums.dart';
import '../entities/registration_data.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const _serverClientId =
      'xxxxxxxx.apps.googleusercontent.com'; // Node er same Web client ID
  static Future<void>? _googleInit;

  Future<void> _ensureGoogleInit() {
    return _googleInit ??= GoogleSignIn.instance.initialize(
      serverClientId: _serverClientId,
    );
  }

  // ---------- Login ----------
  @override
  Future<UserLoginModel> login({
    required String email,
    required String password,
  }) async {
    log("================================");
    return await _postForUser(
      tag: 'Login',
      url: Endpoints.login,
      body: {'email': email, 'password': password},
      failMessage: 'লগইন ব্যর্থ হয়েছে। দয়া করে আবার চেষ্টা করুন।',
    );
  }

  // ---------- Register ----------
  @override
  Future<UserLoginModel> register(RegistrationData data) async {
    return await _postForUser(
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

      return await _postForUser(
        tag: 'GoogleLogin',
        url: "",//Endpoints.googleLogin, // আপনার এন্ডপয়েন্ট এখানে বসাবেন
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

  // ---------- Password reset ----------
  @override
  Future<void> sendPasswordReset(String email) async {
    try {
      final response = await NetworkCaller().post<ApiResponseModel<dynamic>>(
        url: Endpoints.forgotSendOtp,
        body: {'email': email},
        fromJson: (json) =>
        ApiResponseModel<dynamic>.fromJson(json, (data) => data),
      );

      if (response == null || response.success != true) {
        throw AppException(
          response?.message ?? 'পাসওয়ার্ড রিসেট ইমেইল পাঠানো যায়নি।',
        );
      }
    } catch (error) {
      log('=========PasswordReset Error $error');
      if (error is AppException) rethrow;
      throw AppException(error.toString());
    }
  }

  // ---------- Common helper (Returns non-nullable UserLoginModel) ----------
  Future<UserLoginModel> _postForUser({
    required String tag,
    required String url,
    required Map<String, dynamic> body,
    required String failMessage,
  }) async {
    try {
      final response = await NetworkCaller()
          .post<ApiResponseModel<UserLoginModel>>(
        url: url,
        body: body,
        fromJson: (json) => ApiResponseModel<UserLoginModel>.fromJson(
          json,
              (data) => UserLoginModel.fromJson(data as Map<String, dynamic>),
        ),
      );

      if (response == null || response.success != true || response.data == null) {
        throw AppException(response?.message ?? failMessage);
      }
      return response.data!;
    } catch (error) {
      log('=========$tag Error $error');
      if (error is AppException) rethrow;
      throw AppException(error.toString());
    }
  }
}