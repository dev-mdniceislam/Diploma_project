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
  final int semester;
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
