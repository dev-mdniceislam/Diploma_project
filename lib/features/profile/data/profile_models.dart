
typedef Json = Map<String, dynamic>;
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

enum ApplyStatus {
  pending,
  shortlisted,
  interview;

  static ApplyStatus parse(Object? v) =>
      values.firstWhere((e) => e.name == '$v', orElse: () => pending);
}
