class AuthMiddlewareModel {
  const AuthMiddlewareModel({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    this.isVerified = false,
    this.profile,
  });

  final String id;
  final String role; // "company" | "student"
  final String name;
  final String email;
  final bool isVerified;
  final String? profile;

  bool get isCompany => role == 'company';
  bool get isStudent => role == 'student';

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  factory AuthMiddlewareModel.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] as Map<String, dynamic>?) ?? json;

    // Backend এখন avatarUrl পাঠায়। পুরনো response-এ profile string থাকলে
    // সেটাকেও avatar হিসেবে নেওয়া হবে (যতদিন backend আপডেট না হয়)।
    final legacyProfile = data['profile'];

    return AuthMiddlewareModel(
      id: data['id'] as String? ?? '',
      role: data['role'] as String? ?? '',
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      isVerified: data['isVerified'] as bool? ?? false,
      profile:
          data['profile'] as String? ??
          (legacyProfile is String ? legacyProfile : null),
    );
  }
}
