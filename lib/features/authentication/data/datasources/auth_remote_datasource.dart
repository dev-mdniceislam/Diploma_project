import 'package:diploma_job/core/endpoints/endpoints.dart';
import 'package:diploma_job/core/error/exception.dart';
import 'package:diploma_job/core/gen/api_response_gen.dart';
import 'package:diploma_job/core/gen/network_caller_gen.dart';

import '../../domain/entities/auth_user.dart';
import '../models/auth_user_model.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._caller);

  final NetworkCaller _caller;

  static const _networkError = 'Network error. Please try again.';

  Future<void> sendOtp(String email) async {
    final res = await _caller.post<ApiResponseModel<dynamic>>(
      url: Endpoints.registrationSendOtp,
      body: {'email': email},
      fromJson: _anyEnvelope,
    );
    _ensureSuccess(res);
  }

  Future<AuthUserModel> register(RegisterInput input) async {
    final res = await _caller.post<ApiResponseModel<AuthUserModel>>(
      url: Endpoints.registration,
      body: {
        'role': input.role.name,
        'name': input.name,
        'email': input.email,
        'otp': input.otp,
        'password': input.password,
      },
      fromJson: _userEnvelope,
    );
    return _requireUser(res);
  }

  Future<AuthUserModel> login({
    required String email,
    required String password,
  }) async {
    final res = await _caller.post<ApiResponseModel<AuthUserModel>>(
      url: Endpoints.login,
      body: {'email': email, 'password': password},
      fromJson: _userEnvelope,
    );
    return _requireUser(res);
  }

  Future<void> requestPasswordReset(String email) async {
    final res = await _caller.post<ApiResponseModel<dynamic>>(
      url: Endpoints.forgotSendOtp,
      body: {'email': email},
      fromJson: _anyEnvelope,
    );
    _ensureSuccess(res);
  }

  Future<String> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    final res = await _caller.post<ApiResponseModel<Map<String, dynamic>>>(
      url: Endpoints.forgotVerifyOtp,
      body: {'email': email, 'otp': otp},
      fromJson: (json) =>
          ApiResponseModel.fromJson(json, (d) => d as Map<String, dynamic>),
    );
    _ensureSuccess(res);
    final token = res?.data?['resetToken'] as String?;
    if (token == null) throw const AppException(_networkError);
    return token;
  }

  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  }) async {
    final res = await _caller.post<ApiResponseModel<dynamic>>(
      url: Endpoints.newPassword,
      body: {'resetToken': resetToken, 'newPassword': newPassword},
      fromJson: _anyEnvelope,
    );
    _ensureSuccess(res);
  }

  static ApiResponseModel<dynamic> _anyEnvelope(Map<String, dynamic> json) =>
      ApiResponseModel.fromJson(json, (d) => d);

  static ApiResponseModel<AuthUserModel> _userEnvelope(
    Map<String, dynamic> json,
  ) => ApiResponseModel.fromJson(
    json,
    (d) => AuthUserModel.fromJson(d as Map<String, dynamic>),
  );

  void _ensureSuccess(ApiResponseModel<dynamic>? res) {
    if (res == null) throw const AppException(_networkError);
    if (!res.success) throw AppException(res.message);
  }

  AuthUserModel _requireUser(ApiResponseModel<AuthUserModel>? res) {
    _ensureSuccess(res);
    final user = res?.data;
    if (user == null) throw const AppException(_networkError);
    return user;
  }
}
