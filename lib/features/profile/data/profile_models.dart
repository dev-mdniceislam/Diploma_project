/// "a, b ,c" -> ['a', 'b', 'c']
List<String> splitTags(String s) => [
  for (final e in s.split(','))
    if (e.trim().isNotEmpty) e.trim(),
];

enum UserRole {
  student,
  company,
  unknown;

  static UserRole parse(Object? v) => switch ('$v'.toLowerCase()) {
    'student' => student,
    'company' => company,
    _ => unknown,
  };
}

enum PostType {
  job,
  attachment;

  static PostType parse(Object? v) => '$v' == 'job' ? job : attachment;
}

enum ApplyStatus {
  pending,
  shortlisted,
  interview;

  static ApplyStatus parse(Object? v) =>
      values.firstWhere((e) => e.name == '$v', orElse: () => pending);
}

/// GET profile -> { success, message, data: { id, role, name, email } }
class ProfileUser {
  final String id;
  final String role;
  final String name;
  final String email;

  ProfileUser({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
  });

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      id: json['id'] ?? '',
      role: json['role'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

// ───────────────────────────── Company ─────────────────────────────
