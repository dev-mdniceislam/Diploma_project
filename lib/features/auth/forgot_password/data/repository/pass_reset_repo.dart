import 'dart:developer';

import 'package:diploma_job/core/endpoints/endpoints.dart';
import 'package:diploma_job/core/gen/api_response_gen.dart';
import 'package:diploma_job/core/gen/network_caller_gen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/error/exception.dart';

/// API contract for the OTP based password-reset flow.
abstract class PasswordResetRepository {
  /// POST {email} -> backend mails a 6-digit OTP.
  Future<bool> sendOtp(String email);

  /// POST {email, otp} -> returns the resetToken.
  Future<String> verifyOtp({required String email, required String otp});

  /// POST {"resetToken": ..., "newPassword": ...}
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  });
}

class PasswordResetRepositoryImpl implements PasswordResetRepository {
  const PasswordResetRepositoryImpl();

  static const _fallbackError = 'Something went wrong. Please try again.';

  /// Shared POST + error handling for the 3 endpoints.
  Future<ApiResponseModel<dynamic>> _post({
    required String url,
    required Map<String, dynamic> body,
    required String tag,
  }) async {
    try {
      final response = await NetworkCaller().post(
        url: url,
        body: body,
        fromJson: (json) => ApiResponseModel.fromJson(json, (data) => data),
      );

      if (response == null || response.success != true) {
        throw AppException(response?.message ?? _fallbackError);
      }
      return response;
    } catch (error) {
      log('=============$tag error $error');
      if (error is AppException) rethrow;
      throw AppException(error.toString());
    }
  }

  @override
  Future<bool> sendOtp(String email) async {
    final response = await _post(
      url: Endpoints.forgotSendOtp,
      body: {'email': email},
      tag: 'Forgot send otp',
    );
    return response.success;
  }

  @override
  Future<String> verifyOtp({required String email, required String otp}) async {
    final response = await _post(
      url: Endpoints.forgotVerifyOtp,
      body: {'email': email, 'otp': otp},
      tag: 'Forgot verify otp',
    );

    final data = response.data;
    final token = data is Map ? data['resetToken'] : null;
    if (token is! String || token.isEmpty) {
      throw AppException(
        response.message.isNotEmpty ? response.message : _fallbackError,
      );
    }
    return token;
  }

  @override
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  }) async {
    await _post(
      url: Endpoints.newPassword,
      body: {'resetToken': resetToken, 'newPassword': newPassword},
      tag: 'Reset password',
    );
  }
}

final passwordResetRepositoryProvider = Provider<PasswordResetRepository>(
  (ref) => const PasswordResetRepositoryImpl(),
);
