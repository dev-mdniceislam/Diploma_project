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