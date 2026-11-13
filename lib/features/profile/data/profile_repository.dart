import 'package:diploma_job/core/endpoints/endpoints.dart';
import 'package:diploma_job/features/profile/data/model/student_profile_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/gen/api_response_gen.dart';
import '../../../core/gen/network_caller_gen.dart';
import 'profile_demo.dart';
import 'profile_models.dart';

/// true  -> student/company sections are filled with sample data (see profile_demo.dart)
/// false -> only what the API sends is shown (sections without data hide themselves)
const bool kUseDemoProfileData = true;

class ProfileRepository {
  ProfileRepository(this._net, this._token);

  final NetworkCaller _net;
  final String? _token;

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_token != null) 'Authorization': 'Bearer $_token',
  };

  Future<StudentFullProfileModel> fetchStudentJson(ProfileUser u) async {
    try {
      final res = await _net.get<ApiResponseModel<StudentFullProfileModel>>(
        url: Endpoints.studentProfileGet,
        headers: _headers,
        fromJson: (json) => ApiResponseModel.fromJson(
          json,
          (d) => StudentFullProfileModel.fromJson(d as Map<String, dynamic>),
        ),
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
      throw AppException('প্রোফাইল লোড করতে সমস্যা হয়েছে');
    }
  }

  Future<bool> updateStudentProfile({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final res = await _net.patch<ApiResponseModel<dynamic>>(
        url: Endpoints.studentProfileUpdate(userId),
        headers: _headers,
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
}
