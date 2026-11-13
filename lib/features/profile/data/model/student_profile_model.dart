class StudentFullProfileModel {
  final String user;
  final String name;
  final String department;
  final String avatarUrl;
  final String coverImage;
  final String? cvUrl;
  final String institute;
  final String boardRoll;
  final String registration;
  final String session;
  final bool isVerified;
  final String nocNumber;
  final int semester;
  final double cgpaScale;
  final String bio;
  final String email;
  final String phone;
  final String location;
  final List<SkillModel> skills;
  final List<SemesterResultModel> semesterResults;
  final SscModel? ssc;
  final List<ProjectModel> projects;
  final List<CertificateModel> certificates;
  final List<SocialLinkModel> socialLinks;

  StudentFullProfileModel({
    required this.name,
    required this.department,
    required this.institute,
    required this.boardRoll,
    required this.registration,
    required this.session,
    required this.semester,
    required this.cgpaScale,
    required this.bio,
    required this.email,
    required this.phone,
    required this.location,
    required this.skills,
    required this.semesterResults,
    this.ssc,
    required this.projects,
    required this.certificates,
    required this.socialLinks,
    required this.user,
    required this.avatarUrl,
    required this.coverImage,
    required this.isVerified,
    required this.nocNumber,
    this.cvUrl,
  });

  factory StudentFullProfileModel.fromJson(Map<String, dynamic> json) {
    return StudentFullProfileModel(
      name: json['name'] ?? '',
      department: json['department'] ?? '',
      institute: json['institute'] ?? '',
      boardRoll: json['boardRoll'] ?? '',
      registration: json['registration'] ?? '',
      session: json['session'] ?? '',
      semester: json['semester'] ?? 1,
      cgpaScale: (json['cgpaScale'] ?? 4.0).toDouble(),
      bio: json['bio'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      skills: (json['skills'] as List<dynamic>? ?? [])
          .map((e) => SkillModel.fromJson(e))
          .toList(),
      semesterResults: (json['semesterResults'] as List<dynamic>? ?? [])
          .map((e) => SemesterResultModel.fromJson(e))
          .toList(),
      ssc: json['ssc'] != null ? SscModel.fromJson(json['ssc']) : null,
      projects: (json['projects'] as List<dynamic>? ?? [])
          .map((e) => ProjectModel.fromJson(e))
          .toList(),
      certificates: (json['certificates'] as List<dynamic>? ?? [])
          .map((e) => CertificateModel.fromJson(e))
          .toList(),
      socialLinks: (json['socialLinks'] as List<dynamic>? ?? [])
          .map((e) => SocialLinkModel.fromJson(e))
          .toList(),
      user: json['user'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      coverImage: json['coverImage'],
      isVerified: json['isVerified'] ?? false,
      nocNumber: json['nocNumber'] ?? '',
      cvUrl: json['cvUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'department': department,
      'institute': institute,
      'boardRoll': boardRoll,
      'registration': registration,
      'session': session,
      'semester': semester,
      'cgpaScale': cgpaScale,
      'bio': bio,
      'phone': phone,
      'location': location,
      'skills': skills.map((e) => e.toJson()).toList(),
      'semesterResults': semesterResults.map((e) => e.toJson()).toList(),
      'ssc': ssc?.toJson(),
      'certificates': certificates.map((e) => e.toJson()).toList(),
      'socialLinks': socialLinks.map((e) => e.toJson()).toList(),
    };
  }
}

class SkillModel {
  final String name;
  final int percent;
  final String tone;

  SkillModel({required this.name, required this.percent, required this.tone});

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      name: json['name'] ?? '',
      percent: json['percent'] ?? 0,
      tone: json['tone'] ?? 'primary',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'percent': percent, 'tone': tone};
  }
}

class SemesterResultModel {
  final int semester;
  final int year;
  final double gpa;
  final bool passed;

  SemesterResultModel({
    required this.semester,
    required this.year,
    required this.gpa,
    required this.passed,
  });

  factory SemesterResultModel.fromJson(Map<String, dynamic> json) {
    return SemesterResultModel(
      semester: json['semester'] ?? 1,
      year: json['year'] ?? 2021,
      gpa: (json['gpa'] ?? 0.0).toDouble(),
      passed: json['passed'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {'semester': semester, 'year': year, 'gpa': gpa, 'passed': passed};
  }
}

class SscModel {
  final String school;
  final String group;
  final String board;
  final int year;
  final double gpa;

  SscModel({
    required this.school,
    required this.group,
    required this.board,
    required this.year,
    required this.gpa,
  });

  factory SscModel.fromJson(Map<String, dynamic> json) {
    return SscModel(
      school: json['school'] ?? '',
      group: json['group'] ?? '',
      board: json['board'] ?? '',
      year: json['year'] ?? 2020,
      gpa: (json['gpa'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'school': school,
      'group': group,
      'board': board,
      'year': year,
      'gpa': gpa,
    };
  }
}

class ProjectModel {
  final String category;
  final String title;
  final String description;
  final List<String> technologies;
  final String icon;
  final String liveUrl;
  final String repoUrl;

  ProjectModel({
    required this.category,
    required this.title,
    required this.description,
    required this.technologies,
    required this.icon,
    required this.liveUrl,
    required this.repoUrl,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      technologies: List<String>.from(json['technologies'] ?? []),
      icon: json['icon'] ?? 'code',
      liveUrl: json['liveUrl'] ?? '',
      repoUrl: json['repoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'title': title,
      'description': description,
      'technologies': technologies,
      'icon': icon,
      'liveUrl': liveUrl,
      'repoUrl': repoUrl,
    };
  }
}

class CertificateModel {
  final String title;
  final String issuer;

  CertificateModel({required this.title, required this.issuer});

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      title: json['title'] ?? '',
      issuer: json['issuer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'issuer': issuer};
  }
}

class SocialLinkModel {
  final String type;
  final String url;

  SocialLinkModel({required this.type, required this.url});

  factory SocialLinkModel.fromJson(Map<String, dynamic> json) {
    return SocialLinkModel(type: json['type'] ?? '', url: json['url'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'url': url};
  }
}
