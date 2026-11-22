import 'dart:developer';

import 'package:diploma_job/core/database/local_storage.dart';
import 'package:diploma_job/core/endpoints/endpoints.dart';
import 'package:diploma_job/core/gen/api_response_gen.dart';
import 'package:diploma_job/core/gen/network_caller_gen.dart';
import 'package:diploma_job/features/splash/data/model/profile_get_me_model.dart';

class ProfileGetMeRepository {
  ProfileGetMeRepository(this._net);

  final NetworkCaller _net;

  /// Token না থাকলে বা server 401/failure দিলে null ফেরত দেবে।
  Future<AuthMiddlewareModel?> fetchMe() async {
    try {
      final token = await LocalStorage().readData(key: "token");
      if (token == null || token.isEmpty) {
        return null;
      }

      final response = await _net.get(
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

      if (response == null || response.success != true) return null;
      return response.data;
    } catch (error, stack) {
      log("=========================[fetchMe] ERROR $error", stackTrace: stack);
      return null;
    }
  }
}
