import 'job.dart';

enum JobTypeFilter { all, job, internship }

enum JobSort { newest, deadline }

class JobCounts {
  const JobCounts({this.all = 0, this.jobs = 0, this.internships = 0});
  final int all;
  final int jobs;
  final int internships;
}

/// Pure-Dart filter state + matching logic (easy to unit test).
class JobFilter {
  const JobFilter({
    this.query = '',
    this.tech,
    this.type = JobTypeFilter.all,
    this.sort = JobSort.newest,
  });

  final String query;
  final JobTech? tech; // null == all technologies
  final JobTypeFilter type;
  final JobSort sort;

  JobFilter copyWith({
    String? query,
    JobTech? Function()? tech,
    JobTypeFilter? type,
    JobSort? sort,
  }) =>
      JobFilter(
        query: query ?? this.query,
        tech: tech != null ? tech() : this.tech,
        type: type ?? this.type,
        sort: sort ?? this.sort,
      );

  bool matches(Job job, {bool ignoreType = false}) {
    final typeOk = ignoreType ||
        switch (type) {
          JobTypeFilter.all => true,
          JobTypeFilter.job => job.type == JobType.job,
          JobTypeFilter.internship => job.type == JobType.internship,
        };
    if (!typeOk) return false;
    if (tech != null && job.tech != tech) return false;

    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return job.title.toLowerCase().contains(q) ||
        job.company.toLowerCase().contains(q) ||
        job.location.toLowerCase().contains(q) ||
        job.tags.any((t) => t.toLowerCase().contains(q));
  }

  List<Job> apply(List<Job> jobs) {
    final result = jobs.where(matches).toList();
    switch (sort) {
      case JobSort.newest:
        result.sort((a, b) => b.postedAt.compareTo(a.postedAt));
      case JobSort.deadline:
        result.sort((a, b) => a.deadline.compareTo(b.deadline));
    }
    return result;
  }

  JobCounts countsFor(List<Job> jobs) {
    final base = jobs.where((j) => matches(j, ignoreType: true)).toList();
    return JobCounts(
      all: base.length,
      jobs: base.where((j) => j.type == JobType.job).length,
      internships: base.where((j) => j.type == JobType.internship).length,
    );
  }
}
