import 'dart:convert';
import 'dart:developer';

import 'package:diploma_job/core/database/local_storage.dart';
import 'package:diploma_job/core/endpoints/endpoints.dart';
import 'package:diploma_job/core/gen/network_caller_gen.dart';

import '../gen/api_response_gen.dart';

class AuthMiddleware {
  Future<bool> middleWare() async {
    try {
      String? token = await LocalStorage().readData(key: "token");
      var response = await NetworkCaller().get(
        url: Endpoints.me,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        fromJson: (json) => ApiResponseModel.fromJson(
          json,
          (data) => AuthMiddlewareModel.fromJson(data),
        ),
      );

      if (response == null || response.success != true) return false;
      return true;
    } catch (error) {
      log("Auth middleware error $error");
      return false;
    }
  }
}

class AuthMiddlewareModel {
  final String id;
  final String role;
  final String name;
  final String email;

  AuthMiddlewareModel({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
  });

  factory AuthMiddlewareModel.fromJson(Map<String, dynamic> json) {
    return AuthMiddlewareModel(
      id: json['id'] ?? '',
      role: json['role'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'role': role,
    'name': name,
    'email': email,
  };
}
