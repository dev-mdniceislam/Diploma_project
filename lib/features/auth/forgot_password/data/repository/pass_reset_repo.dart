import 'dart:developer';

import 'package:diploma_job/core/endpoints/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/gen/api_response_gen.dart';
import '../../../../../core/gen/network_caller_gen.dart';
import '../model/reset_token_model.dart';

abstract class PasswordResetRepository {
  Future<bool> sendResetLink(String email);

  Future<ResetTokenModel> otpSubmit(String email, String otp);

  Future<bool> resetPassword({
    required String resetToken,
    required String newPassword,
  });
}

class PasswordResetRepositoryImpl implements PasswordResetRepository {
  const PasswordResetRepositoryImpl();

  @override
  Future<bool> sendResetLink(String email) async {
    try {
      final response = await NetworkCaller().post<ApiResponseModel<dynamic>>(
        url: Endpoints.forgotSendOtp,
        body: {"email": email.toLowerCase().trim()},
        fromJson: (json) =>
            ApiResponseModel<dynamic>.fromJson(json, (data) => data),
      );

      if (response == null ||
          response.success != true ||
          response.data == null) {
        throw AppException(response?.message ?? "Please enter a valid email");
      }
      return response.success;
    } catch (error) {
      log('=========Send reset link Error $error');
      if (error is AppException) rethrow;
      throw AppException(error.toString());
    }
  }

  @override
  Future<ResetTokenModel> otpSubmit(String email, String otp) async {
    try {
      final response = await NetworkCaller().post<ApiResponseModel>(
        url: Endpoints.forgotVerifyOtp,
        body: {'email': email, 'otp': otp},
        fromJson: (json) => ApiResponseModel<ResetTokenModel>.fromJson(
          json,
          (data) => ResetTokenModel.fromJson(json),
        ),
      );

      if (response == null || response.success != true) {
        throw AppException(response?.message ?? "Otp not match");
      }
      return response.data;
    } catch (error) {
      log('=========OtpSubmit Error $error');
      if (error is AppException) rethrow;
      throw AppException(error.toString());
    }
  }

  @override
  Future<bool> resetPassword({
    required String resetToken,
    required String newPassword,
  }) async {
    try {
      final response = await NetworkCaller().post<ApiResponseModel<dynamic>>(
        url: Endpoints.forgotVerifyOtp,
        body: {'resetToken': resetToken, 'newPassword': newPassword},
        fromJson: (json) =>
            ApiResponseModel<dynamic>.fromJson(json, (data) => data),
      );

      if (response == null || response.success != true) {
        throw AppException(
          response?.message ?? "Something went wrong. Please try again letter",
        );
      }

      return response.success;
    } catch (error) {
      log('=========New password Error $error');
      if (error is AppException) rethrow;
      throw AppException(error.toString());
    }
  }
}

final passwordResetRepositoryProvider = Provider<PasswordResetRepository>(
  (ref) => const PasswordResetRepositoryImpl(),
);
