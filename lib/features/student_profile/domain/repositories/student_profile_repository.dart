import '../entities/student_profile.dart';

/// Contract for the data source. Swap the mock for a REST implementation
/// (NetworkCaller) without touching providers or UI.
abstract interface class StudentProfileRepository {
  Future<StudentProfile> fetchProfile();
  Future<StudentProfile> saveProfile(StudentProfile profile);
}
