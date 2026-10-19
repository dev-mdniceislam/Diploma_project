import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  Endpoints._();

  static String baseUrl = dotenv.env['BASE_URL'] ?? "";

  static final String registrationSendOtp = "$baseUrl/api/v1/auth/register-otp";
  static final String registration = "$baseUrl/api/v1/auth/register";

  static final String login = "$baseUrl/api/v1/auth/login";

  static final String forgotSendOtp = "$baseUrl/api/v1/auth/forgot-password";
  static final String forgotVerifyOtp = "$baseUrl/api/v1/auth/verify-otp";
  static final String newPassword = "$baseUrl/api/v1/auth/reset-password";

}