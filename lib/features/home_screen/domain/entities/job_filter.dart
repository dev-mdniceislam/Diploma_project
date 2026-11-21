import 'job.dart';

// job.dart-এর models (JobListItem, JobPagination, JobListPage) এখান থেকেও পাওয়া যাবে,
// তাই পুরনো import গুলো ভাঙবে না।
export 'job.dart';

enum JobTypeFilter { all, job, internship }

enum JobSort { newest, deadline }

class JobCounts {
  const JobCounts({this.all = 0, this.jobs = 0, this.internships = 0});

  final int all;
  final int jobs;
  final int internships;
}

/// Filter + sort state. বর্তমান পেজের উপর client-side ভাবে কাজ করে।
class JobFilter {
  const JobFilter({
    this.query = '',
    this.tech,
    this.type = JobTypeFilter.all,
    this.sort = JobSort.newest,
  });

  final String query;

  /// null মানে সব technology। API-তে আলাদা tech field নেই, তাই এটি
  /// title / company / location-এ text match হিসেবে কাজ করে।
  final String? tech;
  final JobTypeFilter type;
  final JobSort sort;

  JobFilter copyWith({
    String? query,
    String? Function()? tech,
    JobTypeFilter? type,
    JobSort? sort,
  }) => JobFilter(
    query: query ?? this.query,
    tech: tech != null ? tech() : this.tech,
    type: type ?? this.type,
    sort: sort ?? this.sort,
  );

  bool matches(JobListItem job) {
    final typeOk = switch (type) {
      JobTypeFilter.all => true,
      JobTypeFilter.job => !job.isInternship,
      JobTypeFilter.internship => job.isInternship,
    };
    if (!typeOk) return false;

    final t = tech?.trim().toLowerCase();
    if (t != null && t.isNotEmpty && !_containsText(job, t)) return false;

    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;

    return _containsText(job, q);
  }

  bool _containsText(JobListItem job, String q) =>
      job.title.toLowerCase().contains(q) ||
      job.companyName.toLowerCase().contains(q) ||
      job.location.toLowerCase().contains(q) ||
      job.location.toLowerCase().contains(q) ||
      job.departments.any((d) => d.toLowerCase().contains(q));

  List<JobListItem> apply(List<JobListItem> jobs) {
    final result = jobs.where(matches).toList();

    switch (sort) {
      case JobSort.newest:
        result.sort((a, b) => _compareDesc(a.createdAt, b.createdAt));
      case JobSort.deadline:
        result.sort((a, b) => _compareAsc(a.deadline, b.deadline));
    }
    return result;
  }
}

int _compareDesc(DateTime? a, DateTime? b) {
  if (a == null && b == null) return 0;
  if (a == null) return 1;
  if (b == null) return -1;
  return b.compareTo(a);
}

int _compareAsc(DateTime? a, DateTime? b) {
  if (a == null && b == null) return 0;
  if (a == null) return 1;
  if (b == null) return -1;
  return a.compareTo(b);
}
