import '../entities/job.dart';

abstract class JobRepository {
  Future<JobListPage> fetchJobs({int page = 1, int limit = 10});
}
