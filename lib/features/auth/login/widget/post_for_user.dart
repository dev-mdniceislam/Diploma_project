import 'dart:developer';

import '../../../../core/error/exception.dart';
import '../../../../core/gen/api_response_gen.dart';
import '../../../../core/gen/network_caller_gen.dart';
import '../data/model/login_model.dart';

class AuthGlobalWidget {
  Future<UserLoginModel> postForUser({
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

      if (response == null ||
          response.success != true ||
          response.data == null) {
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
