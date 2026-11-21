import 'dart:typed_data';

import 'package:flutter/foundation.dart';

enum CircularType { attachment, job }

enum ReviewStatus { pending, shortlisted, interview }

@immutable
class Company {
  const Company({
    required this.name,
    required this.logoUrl,
    required this.tagline,
    required this.about,
  });

  final String name;
  final String logoUrl;
  final String tagline;
  final String about;
}

@immutable
class HrContact {
  const HrContact({
    required this.email,
    required this.phone,
    required this.websiteLabel,
    required this.websiteUrl,
  });

  final String email;
  final String phone;
  final String websiteLabel;
  final String websiteUrl;
}

@immutable
class RelatedCircular {
  const RelatedCircular({
    required this.id,
    required this.title,
    required this.companyName,
    required this.location,
    required this.type,
    this.semester,
  });

  final String id;
  final String title;
  final String companyName;
  final String location;
  final CircularType type;
  final int? semester;
}

@immutable
class JobCircular {
  const JobCircular({
    required this.id,
    required this.title,
    required this.company,
    required this.type,
    required this.semester,
    required this.technologies,
    required this.location,
    required this.stipend,
    required this.deadline,
    required this.publishedAt,
    required this.vacancies,
    required this.employmentType,
    required this.educationLabel,
    required this.housing,
    required this.overview,
    required this.hr,
    this.isVerifiedEmployer = false,
    this.responsibilities = const [],
    this.requirements = const [],
    this.benefits = const [],
    this.requiredDocuments = const [],
    this.related = const [],
  });

  final String id;
  final String title;
  final Company company;
  final CircularType type;
  final int semester;
  final List<String> technologies;
  final String location;
  final int stipend; // BDT / month
  final DateTime deadline;
  final DateTime publishedAt;
  final int vacancies;
  final bool isVerifiedEmployer;
  final String employmentType;
  final String educationLabel;
  final String housing;
  final String overview;
  final List<String> responsibilities;
  final List<String> requirements;
  final List<String> benefits;
  final List<String> requiredDocuments;
  final HrContact hr;
  final List<RelatedCircular> related;
}

/// The signed-in student's application to a circular.
@immutable
class MyApplication {
  const MyApplication({
    required this.appliedAt,
    required this.status,
    this.message,
  });

  final DateTime appliedAt;
  final ReviewStatus status;
  final String? message;
}

@immutable
class AttachedFile {
  const AttachedFile({required this.name, required this.sizeBytes, this.bytes});

  final String name;
  final int sizeBytes;
  final Uint8List? bytes;
}

@immutable
class ApplicationDraft {
  const ApplicationDraft({required this.cv, this.noc, this.coverNote = ''});

  final AttachedFile cv;
  final AttachedFile? noc;
  final String coverNote;
}

/// Read-model of the logged-in student shown in the apply dialog.
@immutable
class Applicant {
  const Applicant({
    required this.name,
    required this.roll,
    required this.institute,
    required this.avatarUrl,
    required this.semester,
  });

  final String name;
  final String roll;
  final String institute;
  final String avatarUrl;
  final String semester;
}

/// Circular + the current user's state on it (what the screen renders).
@immutable
class JobDetails {
  const JobDetails({
    required this.circular,
    this.isBookmarked = false,
    this.application,
  });

  final JobCircular circular;
  final bool isBookmarked;
  final MyApplication? application;

  bool get isApplied => application != null;
}

class JobPoster {
  const JobPoster({
    required this.id,
    required this.companyName,
    required this.industryCategory,
    required this.helplineNumber,
    required this.isVerified,
    required this.isBtebApproved,
    required this.about,
    required this.hrEmail,
    required this.location,
    required this.profileUrl,
    required this.website,
  });

  final String id;
  final String companyName;
  final String industryCategory;
  final String helplineNumber;
  final bool isVerified;
  final bool isBtebApproved;
  final String about;
  final String hrEmail;
  final String location;
  final String profileUrl;
  final String website;

  factory JobPoster.fromJson(Map<String, dynamic>? json) {
    final j = json ?? const <String, dynamic>{};
    return JobPoster(
      id: _str(j['id']),
      companyName: _str(j['companyName']),
      industryCategory: _str(j['industryCategory']),
      helplineNumber: _str(j['helplineNumber']),
      isVerified: _bool(j['isVerified']),
      isBtebApproved: _bool(j['isBtebApproved']),
      about: _str(j['about']),
      hrEmail: _str(j['hrEmail']),
      location: _str(j['location']),
      profileUrl: _str(j['profileUrl']),
      website: _str(j['website']),
    );
  }
}

class JobAttachmentModel {
  const JobAttachmentModel({
    required this.id,
    required this.title,
    required this.jobType,
    required this.description,
    required this.responsibilities,
    required this.requirements,
    required this.departments,
    required this.location,
    required this.stipend,
    required this.semester,
    required this.educationRequirement,
    required this.vacancies,
    required this.accommodation,
    required this.deadline,
    required this.contactEmail,
    required this.contactPhone,
    required this.website,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isApplicationOpen,
    required this.postedBy,
    this.benefits = const [],
  });

  final String id;
  final String title;
  final String jobType;
  final String description;
  final List<String> responsibilities;
  final List<String> requirements;
  final List<String> departments;
  final List<String> benefits;
  final String location;
  final int stipend;
  final String semester;
  final String educationRequirement;
  final int vacancies;
  final String accommodation;
  final DateTime? deadline;
  final String contactEmail;
  final String contactPhone;
  final String website;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isApplicationOpen;
  final JobPoster postedBy;

  factory JobAttachmentModel.fromJson(Map<String, dynamic> json) {
    return JobAttachmentModel(
      // API তে ID আসে `_id` হিসেবে
      id: _str(json['_id'] ?? json['id']),
      title: _str(json['title']),
      jobType: _str(json['jobType']),
      description: _str(json['description']),
      responsibilities: _list(json['responsibilities']),
      requirements: _list(json['requirements']),
      departments: _list(json['departments']),
      location: _str(json['location']),
      stipend: _int(json['stipend']),
      semester: _str(json['semester']),
      educationRequirement: _str(json['educationRequirement']),
      vacancies: _int(json['vacancies']),
      accommodation: _str(json['accommodation']),
      deadline: _date(json['deadline']),
      contactEmail: _str(json['contactEmail']),
      contactPhone: _str(json['contactPhone']),
      website: _str(json['website']),
      status: _str(json['status']),
      createdAt: _date(json['createdAt']),
      updatedAt: _date(json['updatedAt']),
      isApplicationOpen: _bool(json['isApplicationOpen']),
      benefits: _list(json['benefits']),
      postedBy: JobPoster.fromJson(_map(json['postedBy'])),
    );
  }
}

// ---- নিরাপদ parsing helper (একই ফাইলের নিচে রাখুন) ----

String _str(Object? v) => v?.toString() ?? '';

int _int(Object? v) {
  if (v is num) return v.toInt();
  return int.tryParse(v?.toString() ?? '') ?? 0;
}

bool _bool(Object? v) {
  if (v is bool) return v;
  return v?.toString().toLowerCase() == 'true';
}

DateTime? _date(Object? v) {
  if (v == null) return null;
  return DateTime.tryParse(v.toString());
}

List<String> _list(Object? v) {
  if (v is! List) return const [];
  return v.map((e) => e.toString()).toList();
}

Map<String, dynamic>? _map(Object? v) {
  if (v is Map) return Map<String, dynamic>.from(v);
  return null;
}
