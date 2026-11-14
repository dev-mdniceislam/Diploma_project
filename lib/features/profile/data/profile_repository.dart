import 'dart:developer';

import 'package:diploma_job/core/database/local_storage.dart';
import 'package:diploma_job/core/endpoints/endpoints.dart';
import 'package:diploma_job/features/profile/data/model/student_profile_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/gen/api_response_gen.dart';
import '../../../core/gen/network_caller_gen.dart';
import 'model/company_profile_model.dart';
import 'profile_models.dart';

class ProfileRepository {
  ProfileRepository(this._net);

  final NetworkCaller _net;

  Future<Map<String, String>> _headers() async {
    final token = await LocalStorage().readData(key: 'token');
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<Json> fetchStudentJson() async {
    try {
      final res = await _net.get<ApiResponseModel<Json>>(
        url: Endpoints.studentProfileGet,
        headers: await _headers(),
        fromJson: (json) => ApiResponseModel.fromJson(json, (d) => d as Json),
      );
      if (res == null) {
        throw const AppException('সার্ভারের সাথে যোগাযোগ করা যাচ্ছে না');
      }
      final data = res.data;
      if (!res.success || data == null) {
        throw AppException(
          res.message.isNotEmpty ? res.message : 'প্রোফাইল পাওয়া যায়নি',
        );
      }
      return data;
    } on AppException {
      rethrow;
    } catch (e) {
      throw const AppException('প্রোফাইল লোড করতে সমস্যা হয়েছে');
    }
  }

  Future<bool> updateStudentProfile({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final res = await _net.patch<ApiResponseModel<dynamic>>(
        url: Endpoints.studentProfileUpdate(userId),
        headers: await _headers(),
        body: data,
        fromJson: (j) => ApiResponseModel.fromJson(j, (d) => d),
      );
      if (res == null || !res.success) {
        throw AppException(res?.message ?? 'Update failed');
      }
      return true;
    } on AppException {
      rethrow;
    } catch (e) {
      throw const AppException('প্রোফাইল আপডেট করতে সমস্যা হয়েছে');
    }
  }

  /// Local storage থেকে role পড়ে। "student" -> student, "company" -> company, অন্যথায় null
  Future<UserRole?> fetchUserRole() async {
    final raw = await LocalStorage().readData(key: 'role');
    if (raw == null || raw.trim().isEmpty) return null;
    log("===========Raw======$raw");

    final role = UserRole.parse(raw.trim());
    return role == UserRole.unknown ? null : role;
  }

  /// Company profile raw JSON (notifier-এর জন্য)
  Future<Json> fetchCompanyJson() async {
    try {
      final res = await _net.get<ApiResponseModel<Json>>(
        url: Endpoints.companyProfileGet,
        headers: await _headers(),
        fromJson: (json) => ApiResponseModel.fromJson(json, (d) => d as Json),
      );
      if (res == null) {
        throw const AppException('সার্ভারের সাথে যোগাযোগ করা যাচ্ছে না');
      }
      final data = res.data;
      if (!res.success || data == null) {
        throw AppException(
          res.message.isNotEmpty ? res.message : 'প্রোফাইল পাওয়া যায়নি',
        );
      }
      return data;
    } on AppException {
      rethrow;
    } catch (e) {
      throw const AppException('প্রোফাইল লোড করতে সমস্যা হয়েছে');
    }
  }

  Future<List<Posting>> fetchCompanyPostings() async {
    try {
      final res = await _net.get<ApiResponseModel<List<Posting>>>(
        url: Endpoints.getCompanyPosted,
        headers: await _headers(),
        fromJson: (json) => ApiResponseModel.fromJson(
          json,
          (d) => (d as List<dynamic>)
              .map((e) => Posting.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      if (res == null) {
        throw const AppException('সার্ভারের সাথে যোগাযোগ করা যাচ্ছে না');
      }
      final data = res.data;
      if (!res.success || data == null) {
        throw AppException(
          res.message.isNotEmpty ? res.message : 'পোস্টিং পাওয়া যায়নি',
        );
      }
      return data;
    } on AppException {
      rethrow;
    } catch (e) {
      throw const AppException('পোস্টিং লোড করতে সমস্যা হয়েছে');
    }
  }

  Future<void> createPosting(Map<String, dynamic> body) async {
    try {
      final res = await _net.post<ApiResponseModel<dynamic>>(
        url: Endpoints.me, // endpoints.dart-এ যোগ করুন
        headers: await _headers(),
        body: body,
        fromJson: (j) => ApiResponseModel.fromJson(j, (d) => d),
      );
      if (res == null || !res.success) {
        throw AppException(res?.message ?? 'পোস্ট করা যায়নি');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw const AppException('পোস্ট করতে সমস্যা হয়েছে');
    }
  }

  Future<void> scheduleApplicantInterview({
    required String applicantId,
    required String at,
    required String place,
  }) async {
    try {
      final res = await _net.patch<ApiResponseModel<dynamic>>(
        url: "", // endpoints.dart-এ যোগ করুন
        headers: await _headers(),
        body: {
          'status': 'interview',
          'interviewAt': at,
          'interviewPlace': place,
        },
        fromJson: (j) => ApiResponseModel.fromJson(j, (d) => d),
      );
      if (res == null || !res.success) {
        throw AppException(res?.message ?? 'ইন্টারভিউ সেভ করা যায়নি');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw const AppException('ইন্টারভিউ সেভ করতে সমস্যা হয়েছে');
    }
  }

  Future<List<StudentApplicationModel>> fetchStudentApplications() async {
    try {
      final res = await _net
          .get<ApiResponseModel<List<StudentApplicationModel>>>(
            url: Endpoints.getStudentApplication,
            headers: await _headers(),
            fromJson: (json) => ApiResponseModel.fromJson(
              json,
              (d) => (d as List<dynamic>)
                  .map(
                    (e) => StudentApplicationModel.fromJson(
                      e as Map<String, dynamic>,
                    ),
                  )
                  .toList(),
            ),
          );
      if (res == null) {
        throw const AppException('সার্ভারের সাথে যোগাযোগ করা যাচ্ছে না');
      }
      final data = res.data;
      if (!res.success || data == null) {
        throw AppException(
          res.message.isNotEmpty ? res.message : 'আবেদন পাওয়া যায়নি',
        );
      }
      return data;
    } on AppException {
      rethrow;
    } catch (e) {
      throw const AppException('আবেদন লোড করতে সমস্যা হয়েছে');
    }
  }

  Future<List<CompanyApplicantsModel>> fetchCompanyApplicants() async {
    try {
      final res = await _net
          .get<ApiResponseModel<List<CompanyApplicantsModel>>>(
            url: Endpoints.getCompanyApplicants,
            headers: await _headers(),
            fromJson: (json) => ApiResponseModel.fromJson(
              json,
              (d) => (d as List<dynamic>)
                  .map(
                    (e) => CompanyApplicantsModel.fromJson(
                      e as Map<String, dynamic>,
                    ),
                  )
                  .toList(),
            ),
          );
      if (res == null) {
        throw const AppException('সার্ভারের সাথে যোগাযোগ করা যাচ্ছে না');
      }
      final data = res.data;
      if (!res.success || data == null) {
        throw AppException(
          res.message.isNotEmpty ? res.message : 'আবেদন পাওয়া যায়নি',
        );
      }
      return data;
    } on AppException {
      rethrow;
    } catch (e) {
      throw const AppException('আবেদন লোড করতে সমস্যা হয়েছে');
    }
  }

  Future<void> updateApplicantStatus({
    required String applicationId,
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await _net.patch<ApiResponseModel<dynamic>>(
        url: "",
        headers: await _headers(),
        body: body,
        fromJson: (j) => ApiResponseModel.fromJson(j, (d) => d),
      );
      if (res == null || !res.success) {
        throw AppException(res?.message ?? 'স্ট্যাটাস আপডেট করা যায়নি');
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw const AppException('স্ট্যাটাস আপডেট করতে সমস্যা হয়েছে');
    }
  }
}
