class CompanyProfileModel {
  final String user;
  final String companyName;
  final String email;
  final String industryCategory;
  final String helplineNumber;
  final String employeeCount;
  final List<String> benefits;
  final bool isVerified;
  final bool isBtebApproved;
  final List<EngineeringDomain> engineeringDomains;
  final List<CampusPartner> campusPartners;
  final String createdAt;
  final String updatedAt;
  final String about;
  final String coverImageUrl;
  final String hrEmail;
  final String location;
  final String profileUrl;
  final String website;
  final String id;

  CompanyProfileModel({
    required this.user,
    required this.companyName,
    required this.email,
    required this.industryCategory,
    required this.helplineNumber,
    required this.employeeCount,
    required this.benefits,
    required this.isVerified,
    required this.isBtebApproved,
    required this.engineeringDomains,
    required this.campusPartners,
    required this.createdAt,
    required this.updatedAt,
    required this.about,
    required this.coverImageUrl,
    required this.hrEmail,
    required this.location,
    required this.profileUrl,
    required this.website,
    required this.id,
  });

  factory CompanyProfileModel.fromJson(Map<String, dynamic> json) {
    return CompanyProfileModel(
      user: json['user'] ?? '',
      companyName: json['companyName'] ?? '',
      email: json['email'] ?? '',
      industryCategory: json['industryCategory'] ?? '',
      helplineNumber: json['helplineNumber'] ?? '',
      employeeCount: json['employeeCount'] ?? '',
      benefits: List<String>.from(json['benefits'] ?? []),
      isVerified: json['isVerified'] ?? false,
      isBtebApproved: json['isBtebApproved'] ?? false,
      engineeringDomains: (json['engineeringDomains'] as List<dynamic>? ?? [])
          .map((e) => EngineeringDomain.fromJson(e))
          .toList(),
      campusPartners: (json['campusPartners'] as List<dynamic>? ?? [])
          .map((e) => CampusPartner.fromJson(e))
          .toList(),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      about: json['about'] ?? '',
      coverImageUrl: json['coverImageUrl'] ?? '',
      hrEmail: json['hrEmail'] ?? '',
      location: json['location'] ?? '',
      profileUrl: json['profileUrl'] ?? '',
      website: json['website'] ?? '',
      id: json['id'] ?? '',
    );
  }
}

class CompanyApplicantsModel {
  final String id;
  final JobDetail job;
  final Applicant applicant;
  final String company;
  final String shortMessage;
  final String status;
  final String cv;
  final DateTime createdAt;
  final DateTime updatedAt;

  CompanyApplicantsModel({
    required this.id,
    required this.job,
    required this.applicant,
    required this.company,
    required this.shortMessage,
    required this.status,
    required this.cv,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CompanyApplicantsModel.fromJson(Map<String, dynamic> json) {
    return CompanyApplicantsModel(
      id: json['_id'] ?? '',
      job: JobDetail.fromJson(json['job'] ?? {}),
      applicant: Applicant.fromJson(json['applicant'] ?? {}),
      company: json['company'] ?? '',
      shortMessage: json['shortMessage'] ?? '',
      status: json['status'] ?? '',
      cv: json['cv'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'job': job.toJson(),
      'applicant': applicant.toJson(),
      'company': company,
      'shortMessage': shortMessage,
      'status': status,
      'cv': cv,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class JobDetail {
  final String id;
  final String title;
  final String jobType;
  final String location;
  final DateTime deadline;
  final String status;

  JobDetail({
    required this.id,
    required this.title,
    required this.jobType,
    required this.location,
    required this.deadline,
    required this.status,
  });

  factory JobDetail.fromJson(Map<String, dynamic> json) {
    return JobDetail(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      jobType: json['jobType'] ?? '',
      location: json['location'] ?? '',
      deadline: DateTime.parse(
        json['deadline'] ?? DateTime.now().toIso8601String(),
      ),
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'jobType': jobType,
      'location': location,
      'deadline': deadline.toIso8601String(),
      'status': status,
    };
  }
}

class Applicant {
  final String id;
  final String name;
  final String avatarUrl;
  final String email;

  Applicant({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.email,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) {
    return Applicant(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'avatarUrl': avatarUrl, 'email': email};
  }
}

class EngineeringDomain {
  final String title;
  final String description;

  EngineeringDomain({required this.title, required this.description});

  factory EngineeringDomain.fromJson(Map<String, dynamic> json) {
    return EngineeringDomain(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class CampusPartner {
  final String instituteName;
  final int annualInternQuota;
  final bool isMouVerified;

  CampusPartner({
    required this.instituteName,
    required this.annualInternQuota,
    required this.isMouVerified,
  });

  factory CampusPartner.fromJson(Map<String, dynamic> json) {
    return CampusPartner(
      instituteName: json['instituteName'] ?? '',
      annualInternQuota: json['annualInternQuota'] ?? 0,
      isMouVerified: json['isMouVerified'] ?? false,
    );
  }
}

enum JobType {
  job,
  internship;

  /// "industrial-attachment", "attachment", "internship" -> internship
  /// বাকি সব (যেমন "job", "full-time") -> job
  static JobType parse(Object? v) {
    final s = '$v'.trim().toLowerCase();
    if (s.contains('attach') || s.contains('intern')) {
      return JobType.internship;
    }
    return JobType.job;
  }
}

class PostedBy {
  final String id;
  final String companyName;
  final bool isVerified;

  const PostedBy({
    required this.id,
    required this.companyName,
    required this.isVerified,
  });

  factory PostedBy.fromJson(Map<String, dynamic> json) {
    return PostedBy(
      id: '${json['id'] ?? json['_id'] ?? ''}',
      companyName: '${json['companyName'] ?? ''}',
      isVerified: json['isVerified'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'companyName': companyName, 'isVerified': isVerified};
  }
}

class IndustrialJobModel {
  final String id;
  final PostedBy? postedBy;
  final String title;
  final JobType jobType;
  final String location;
  final num stipend;
  final int? vacancies;
  final String? accommodation;
  final List<String> department;
  final DateTime? deadline;
  final String? status;
  final DateTime? createdAt;
  final bool? isApplicationOpen;
  final int? applicantCount;

  // Home card-এর জন্য। API না পাঠালে খালি থাকে।
  final String description;
  final String tech;
  final List<String> tags;

  const IndustrialJobModel({
    required this.id,
    this.postedBy,
    required this.title,
    required this.jobType,
    required this.location,
    required this.stipend,
    this.vacancies,
    this.accommodation,
    this.deadline,
    this.status,
    this.createdAt,
    this.isApplicationOpen,
    this.applicantCount,
    this.description = '',
    this.tech = '',
    this.tags = const [],
    this.department = const [],
  });

  /// Company নাম। postedBy না থাকলে খালি।
  String get company => postedBy?.companyName ?? '';

  /// Display-এর জন্য বেতন/স্টাইপেন্ড।
  String get salary => stipend > 0 ? '৳ ${stipend.toInt()}' : '';

  factory IndustrialJobModel.fromJson(Map<String, dynamic> json) {
    final postedByJson = json['postedBy'];

    return IndustrialJobModel(
      id: '${json['_id'] ?? json['id'] ?? ''}',
      postedBy: postedByJson is Map<String, dynamic>
          ? PostedBy.fromJson(postedByJson)
          : null,
      title: '${json['title'] ?? ''}',
      jobType: JobType.parse(json['jobType']),
      location: '${json['location'] ?? ''}',
      stipend: json['stipend'] is num ? json['stipend'] as num : 0,
      vacancies: (json['vacancies'] as num?)?.toInt(),
      accommodation: json['accommodation']?.toString(),
      deadline: _date(json['deadline']),
      status: json['status']?.toString(),
      createdAt: _date(json['createdAt']),
      isApplicationOpen: json['isApplicationOpen'] as bool?,
      applicantCount: (json['applicantCount'] as num?)?.toInt(),
      description: '${json['description'] ?? ''}',
      tech: '${json['tech'] ?? json['technology'] ?? ''}',
      tags: (json['tags'] as List<dynamic>? ?? const [])
          .map((e) => '$e')
          .toList(),
      department: (json['departments'] as List<dynamic>? ?? const [])
          .map((e) => '$e')
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'postedBy': postedBy?.toJson(),
      'title': title,
      'jobType': jobType.name,
      'location': location,
      'stipend': stipend,
      'vacancies': vacancies,
      'accommodation': accommodation,
      'deadline': deadline?.toIso8601String(),
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'isApplicationOpen': isApplicationOpen,
      'applicantCount': applicantCount,
      'description': description,
      'tech': tech,
      'tags': tags,
      'department': department,
    };
  }
}

DateTime? _date(Object? v) => v == null ? null : DateTime.tryParse('$v');

// class Posting {
//   final String id;
//   final String title;
//   final JobType jobType;
//   final String location;
//   final num stipend;
//   final int vacancies;
//   final String accommodation;
//   final DateTime deadline;
//   final String status;
//   final DateTime createdAt;
//   final bool isApplicationOpen;
//   final int applicantCount;
//
//   Posting({
//     required this.id,
//     required this.title,
//     required this.jobType,
//     required this.location,
//     required this.stipend,
//     required this.vacancies,
//     required this.accommodation,
//     required this.deadline,
//     required this.status,
//     required this.createdAt,
//     required this.isApplicationOpen,
//     required this.applicantCount,
//   });
//
//   factory Posting.fromJson(Map<String, dynamic> json) {
//     return Posting(
//       id: json['_id'] ?? '',
//       title: json['title'] ?? '',
//       jobType: JobType.parse(json['jobType']),
//       location: json['location'] ?? '',
//       stipend: json['stipend'] ?? 0,
//       vacancies: json['vacancies'] ?? 0,
//       accommodation: json['accommodation'] ?? '',
//       deadline: DateTime.parse(
//         json['deadline'] ?? DateTime.now().toIso8601String(),
//       ),
//       status: json['status'] ?? '',
//       createdAt: DateTime.parse(
//         json['createdAt'] ?? DateTime.now().toIso8601String(),
//       ),
//       isApplicationOpen: json['isApplicationOpen'] ?? false,
//       applicantCount: json['applicantCount'] ?? 0,
//     );
//   }
// }
