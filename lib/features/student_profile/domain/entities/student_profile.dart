import 'package:flutter/foundation.dart';

enum NocStatus { issued, pending, rejected }

enum ApplicationType { attachment, job }

enum ApplicationStatus { shortlisted, interview, pending }

enum SkillTone { primary, success, info, warning }

enum ProjectIcon { calculator, shopping, code }

enum SocialType { linkedin, github }

@immutable
class SkillLevel {
  const SkillLevel({
    required this.name,
    required this.percent,
    this.tone = SkillTone.primary,
  });

  final String name;
  final int percent; // 0..100
  final SkillTone tone;
}

@immutable
class SemesterResult {
  const SemesterResult({
    required this.semester,
    required this.year,
    required this.gpa,
    this.passed = true,
  });

  final int semester;
  final int year;
  final double gpa;
  final bool passed;
}

@immutable
class SscRecord {
  const SscRecord({
    required this.school,
    required this.group,
    required this.board,
    required this.year,
    required this.gpa,
  });

  final String school;
  final String group;
  final String board;
  final int year;
  final double gpa;
}

@immutable
class Project {
  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    this.category,
    this.icon = ProjectIcon.code,
    this.liveUrl,
    this.repoUrl,
  });

  final String id;
  final String title;
  final String description;
  final List<String> technologies;
  final String? category; // null => "New project" badge in the UI
  final ProjectIcon icon;
  final String? liveUrl;
  final String? repoUrl;
}

@immutable
class JobApplication {
  const JobApplication({
    required this.id,
    required this.company,
    required this.position,
    required this.type,
    required this.appliedAt,
    required this.status,
    this.message,
  });

  final String id;
  final String company;
  final String position;
  final ApplicationType type;
  final DateTime appliedAt;
  final ApplicationStatus status;
  final String? message;
}

@immutable
class Certificate {
  const Certificate({required this.title, required this.issuer});

  final String title;
  final String issuer;
}

@immutable
class SocialLink {
  const SocialLink({required this.type, required this.url});

  final SocialType type;
  final String url;
}

@immutable
class StudentProfile {
  const StudentProfile({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.department,
    required this.institute,
    required this.boardRoll,
    required this.registration,
    required this.session,
    required this.semester,
    required this.cgpa,
    required this.nocStatus,
    required this.nocNumber,
    required this.bio,
    required this.email,
    required this.phone,
    required this.location,
    this.cgpaScale = 4.0,
    this.isVerified = false,
    this.cvUrl,
    this.skills = const [],
    this.semesterResults = const [],
    this.ssc,
    this.projects = const [],
    this.applications = const [],
    this.certificates = const [],
    this.socialLinks = const [],
  });

  final String id;
  final String name;
  final String avatarUrl;
  final String department;
  final String institute;
  final String boardRoll;
  final String registration;
  final String session;
  final int semester;
  final double cgpa;
  final double cgpaScale;
  final bool isVerified;
  final NocStatus nocStatus;
  final String nocNumber;
  final String bio;
  final String email;
  final String phone;
  final String location;
  final String? cvUrl;
  final List<SkillLevel> skills;
  final List<SemesterResult> semesterResults;
  final SscRecord? ssc;
  final List<Project> projects;
  final List<JobApplication> applications;
  final List<Certificate> certificates;
  final List<SocialLink> socialLinks;

  StudentProfile copyWith({
    String? name,
    String? department,
    String? institute,
    String? bio,
    String? email,
    String? phone,
    String? cvUrl,
    List<Project>? projects,
  }) {
    return StudentProfile(
      id: id,
      name: name ?? this.name,
      avatarUrl: avatarUrl,
      department: department ?? this.department,
      institute: institute ?? this.institute,
      boardRoll: boardRoll,
      registration: registration,
      session: session,
      semester: semester,
      cgpa: cgpa,
      cgpaScale: cgpaScale,
      isVerified: isVerified,
      nocStatus: nocStatus,
      nocNumber: nocNumber,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location,
      cvUrl: cvUrl ?? this.cvUrl,
      skills: skills,
      semesterResults: semesterResults,
      ssc: ssc,
      projects: projects ?? this.projects,
      applications: applications,
      certificates: certificates,
      socialLinks: socialLinks,
    );
  }
}
