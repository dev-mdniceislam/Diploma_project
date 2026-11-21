typedef Json = Map<String, dynamic>;

/// API-তে jobType এর মান: 'industrial-attachment' হলে ইন্টার্নশিপ।
const kInternshipJobType = 'industrial-attachment';

enum JobTech {
  computer,
  civil,
  electrical,
  mechanical,
  architecture,
  electronics,
}

class JobListItem {
  const JobListItem({
    required this.id,
    required this.title,
    required this.companyName,
    required this.isVerified,
    required this.jobType,
    required this.location,
    required this.stipend,
    required this.deadline,
    required this.createdAt,
    this.departments = const [],
    required this.description,
  });

  final String id;
  final String title;
  final String companyName;
  final bool isVerified;
  final String jobType;
  final String location;
  final List<String> departments;
  final String description;
  final int stipend;
  final DateTime? deadline;
  final DateTime? createdAt;

  bool get isInternship => jobType == kInternshipJobType;

  factory JobListItem.fromJson(Json json) {
    final poster = _map(json['postedBy']);
    return JobListItem(
      id: _s(json['_id'] ?? json['id']),
      title: _s(json['title']),
      companyName: _s(poster['companyName']),
      isVerified: _b(poster['isVerified']),
      jobType: _s(json['jobType']),
      location: _s(json['location']),
      stipend: _i(json['stipend']),
      deadline: _d(json['deadline']),
      createdAt: _d(json['createdAt']),
      departments:
          (json['departments'] as List?)?.map((e) => e.toString()).toList() ??
          const [],
      description: _s(json['description']),
    );
  }
}

class JobPagination {
  const JobPagination({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.hasNextPage,
  });

  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final bool hasNextPage;

  factory JobPagination.fromJson(Json json) => JobPagination(
    total: _i(json['total']),
    page: _i(json['page'], fallback: 1),
    limit: _i(json['limit'], fallback: 10),
    totalPages: _i(json['totalPages'], fallback: 1),
    hasNextPage: _b(json['hasNextPage']),
  );
}

class JobListPage {
  const JobListPage({required this.jobs, required this.pagination});

  final List<JobListItem> jobs;
  final JobPagination pagination;

  factory JobListPage.fromJson(Json json) {
    final raw = (json['jobs'] as List?) ?? const [];
    return JobListPage(
      jobs: raw
          .whereType<Map>()
          .map((e) => JobListItem.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      pagination: JobPagination.fromJson(_map(json['pagination'])),
    );
  }
}

// ---- helpers ----
String _s(Object? v) => v?.toString() ?? '';

int _i(Object? v, {int fallback = 0}) {
  if (v is num) return v.toInt();
  return int.tryParse(v?.toString() ?? '') ?? fallback;
}

bool _b(Object? v) => v is bool ? v : v?.toString().toLowerCase() == 'true';

DateTime? _d(Object? v) => v == null ? null : DateTime.tryParse(v.toString());

Json _map(Object? v) =>
    v is Map ? Map<String, dynamic>.from(v) : <String, dynamic>{};
