import '../entities/job.dart';

abstract interface class JobRepository {
  Future<List<Job>> getJobs();
}
