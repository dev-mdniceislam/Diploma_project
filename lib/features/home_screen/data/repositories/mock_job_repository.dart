import 'package:diploma_job/core/database/local_storage.dart';
import 'package:diploma_job/core/endpoints/endpoints.dart';
import 'package:diploma_job/core/error/exception.dart';
import 'package:diploma_job/core/gen/api_response_gen.dart';
import 'package:diploma_job/core/gen/network_caller_gen.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/job.dart';
import '../../domain/repositories/job_repository.dart';

class ApiJobRepository implements JobRepository {
  ApiJobRepository(this._net);

  final NetworkCaller _net;

  Future<Map<String, String>> _headers() async {
    final token = await LocalStorage().readData(key: 'token');
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<JobListPage> fetchJobs({int page = 1, int limit = 10}) async {
    debugPrint('[JOBS] fetchJobs called, page=$page');
    try {
      final res = await _net.get<ApiResponseModel<Json>>(
        url: Endpoints.getJobForHome(page, limit),
        headers: await _headers(),
        fromJson: (json) {
          debugPrint('[JOBS] raw json: $json');
          return ApiResponseModel.fromJson(json, (d) => d as Json);
        },
      );

      if (res == null) {
        debugPrint('[JOBS] res is NULL (NetworkCaller returned null)');
        throw const AppException('Unable to connect to the server');
      }

      debugPrint(
        '[JOBS] success=${res.success} message=${res.message} '
        'dataType=${res.data.runtimeType}',
      );

      if (!res.success || res.data == null) {
        debugPrint('[JOBS] FAILED: success=${res.success}, data=${res.data}');
        throw AppException(
          res.message.isNotEmpty ? res.message : 'Jobs not found',
        );
      }

      final result = JobListPage.fromJson(res.data!);
      debugPrint('[JOBS] parsed ${result.jobs.length} jobs');
      return result;
    } on AppException catch (e) {
      debugPrint('[JOBS] AppException: ${e.message}');
      rethrow;
    } catch (e, st) {
      debugPrint('[JOBS] unexpected error: $e\n$st');
      throw AppException('Failed to load jobs: $e');
    }
  }
}
