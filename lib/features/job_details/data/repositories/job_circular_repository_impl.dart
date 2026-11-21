import 'dart:developer';

import 'package:diploma_job/core/database/local_storage.dart';
import 'package:diploma_job/core/endpoints/endpoints.dart';
import 'package:diploma_job/core/error/exception.dart';
import 'package:diploma_job/core/gen/api_response_gen.dart';
import 'package:diploma_job/core/gen/network_caller_gen.dart';
import 'package:diploma_job/features/profile/data/profile_models.dart';

import '../../domain/entities/job_circular.dart';
import '../../domain/repositories/job_circular_repository.dart';

class JobCircularRepositoryImpl implements JobCircularRepository {
  JobCircularRepositoryImpl(this._net);

  final NetworkCaller _net;

  Future<Map<String, String>> _headers() async {
    final token = await LocalStorage().readData(key: 'token');
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<Json> fetchDetails(String id) async {
    try {
      final res = await _net.get<ApiResponseModel<Json>>(
        url: Endpoints.getJobbyId("6af9e2043e36c1d1e2c0ff11"),
        headers: await _headers(),
        fromJson: (json) => ApiResponseModel.fromJson(json, (d) => d as Json),
      );

      log("===================Dataaa ${res}");

      if (res == null) {
        throw const AppException('Unable to connect to the server');
      }

      final data = res.data;
      if (!res.success || data == null) {
        throw AppException(
          res.message.isNotEmpty ? res.message : 'Job not found',
        );
      }
      log("===================Dataaa ${data}");
      return data;
    } on AppException {
      rethrow;
    } catch (e, st) {
      log('fetchDetails failed for $id', error: e, stackTrace: st);
      throw const AppException('Failed to load job');
    }
  }

  // TODO: replace with real endpoint. Returns the new bookmark value.
  @override
  Future<bool> setBookmark(String id, {required bool value}) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return value;
  }

  // TODO: replace with real endpoint.
  @override
  Future<MyApplication> submitApplication(
    String id,
    ApplicationDraft draft,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return MyApplication(
      appliedAt: DateTime.now(),
      status: ReviewStatus.pending,
      message: 'আপনার আবেদনপত্র এইচআর টিম পর্যালোচনা করছে',
    );
  }
}
