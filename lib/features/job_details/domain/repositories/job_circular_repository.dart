import 'package:diploma_job/features/profile/data/profile_models.dart';

import '../entities/job_circular.dart';

abstract class JobCircularRepository {
  Future<Json> fetchDetails(String id);
  Future<bool> setBookmark(String id, {required bool value});
  Future<MyApplication> submitApplication(String id, ApplicationDraft draft);
}