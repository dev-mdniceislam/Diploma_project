import '../entities/job_circular.dart';

/// Swap the mock for a REST implementation (NetworkCaller) — throw
/// `AppException` on failure, the UI already shows its message.
abstract interface class JobCircularRepository {
  Future<JobDetails> fetchDetails(String id);
  Future<bool> setBookmark(String id, {required bool value});
  Future<MyApplication> submitApplication(String id, ApplicationDraft draft);
}
