import '../../domain/entities/job.dart';
import '../../domain/repositories/job_repository.dart';

/// Mock data copied from the HTML prototype.
/// Replace with an API-backed implementation later; nothing else changes.
class MockJobRepository implements JobRepository {
  @override
  Future<List<Job>> getJobs() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final now = DateTime.now();

    return [
      Job(
        id: 'job-101',
        title: 'Junior Sub-Assistant Engineer (Civil)',
        company: 'Concord Real Estate Ltd.',
        type: JobType.job,
        tech: JobTech.civil,
        location: 'উত্তরা, ঢাকা',
        salary: '২২,০০০ - ২৫,০০০ টাকা',
        deadline: DateTime(2026, 11, 15),
        postedAt: now.subtract(const Duration(days: 2)),
        tags: const ['AutoCAD', 'Site Supervision', 'Estimation'],
        description: 'প্রজেক্ট সাইটে অটোক্যাড লেআউট পর্যবেক্ষণ ও দৈনন্দিন রড-সিমেন্ট খরচের হিসাব সংরক্ষণের জন্য ডিপ্লোমা সিভিল পাশকৃত ফ্রেশারদের আহবান করা হচ্ছে।',
      ),
      Job(
        id: 'job-102',
        title: 'PLC & Automation Training Intern',
        company: 'Walton Hi-Tech Industries PLC',
        type: JobType.internship,
        tech: JobTech.electrical,
        location: 'গাজীপুর',
        salary: 'স্টাইপেন্ড: ৮,০০০ টাকা + যাতায়াত',
        deadline: DateTime(2026, 10, 30),
        postedAt: now,
        tags: const ['PLC', 'Microcontroller', '8th Semester'],
        description: '৮ম সেমিস্টারের ইলেক্ট্রিক্যাল ডিপ্লোমা শিক্ষার্থীদের জন্য ৪ মাসের ইন্ডাস্ট্রিয়াল অ্যাটাচমেন্টের সুযোগ। সফল ইন্টার্নশিপ শেষে স্থায়ী চাকরির সুযোগ রয়েছে।',
      ),
      Job(
        id: 'job-103',
        title: 'Junior Web Developer (Diploma Freshers)',
        company: 'SoftTech IT Bangladesh',
        type: JobType.job,
        tech: JobTech.computer,
        location: 'ধানমন্ডি, ঢাকা (হালকা রিমোট সুযোগ)',
        salary: '১৮,০০০ - ২৪,০০০ টাকা',
        deadline: DateTime(2026, 11, 5),
        postedAt: now.subtract(const Duration(days: 1)),
        tags: const ['JavaScript', 'HTML/CSS', 'PHP/MySQL', 'Diploma Passed'],
        description: 'কম্পিউটার টেকনোলজির ডিপ্লোমা সম্পন্নকারীদের জন্য ওয়েব ডেভেলপমেন্টের এনট্রি লেভেল পদে নিয়োগ দেওয়া হবে। বেসিক প্রোগ্রামিং জ্ঞান আবশ্যক।',
      ),
      Job(
        id: 'job-104',
        title: 'Industrial Attachment Trainee (Mechanical)',
        company: 'Energypac Engineering Ltd.',
        type: JobType.internship,
        tech: JobTech.mechanical,
        location: 'সাভার, ঢাকা',
        salary: 'স্টাইপেন্ড: ৭,৫০০ টাকা',
        deadline: DateTime(2026, 10, 28),
        postedAt: now.subtract(const Duration(days: 3)),
        tags: const ['CAD/CAM', 'Lathe Machine', '8th Semester Attachment'],
        description: 'মেকানিক্যাল ডিপ্লোমা শিক্ষার্থীদের ৮ম সেমিস্টারের প্রাতিষ্ঠানিক অ্যাটাচমেন্ট গ্রহণ করা হচ্ছে। ট্রান্সফরমার ও হেভি পাওয়ার ইকুইপমেন্ট নিয়ে কাজ করার অভিজ্ঞতা।',
      ),
      Job(
        id: 'job-105',
        title: 'Junior Architectural Draftsman',
        company: 'Urban Design & Partners',
        type: JobType.job,
        tech: JobTech.architecture,
        location: 'গুলশান, ঢাকা',
        salary: '২০,০০০ - ২৬,০০০ টাকা',
        deadline: DateTime(2026, 11, 10),
        postedAt: now.subtract(const Duration(days: 4)),
        tags: const ['3D Max', 'Revit', 'AutoCAD 2D/3D'],
        description: 'আর্কিটেকচার ডিপ্লোমা ধারীদের জন্য ৩ডি ম্যাক্স ও ক্যাড ড্রয়িং তৈরির কাজে ফুল-টাইম জুনিয়র ড্রাফটসম্যান প্রয়োজন।',
      ),
      Job(
        id: 'job-106',
        title: 'Network Operations Trainee (Internship)',
        company: 'Link3 Technologies Ltd.',
        type: JobType.internship,
        tech: JobTech.computer,
        location: 'মহাখালী, ঢাকা',
        salary: 'স্টাইপেন্ড: ৯,০০০ টাকা',
        deadline: DateTime(2026, 11, 2),
        postedAt: now.subtract(const Duration(hours: 3)),
        tags: const ['CCNA', 'MikroTik', 'Fiber Optics', '8th Semester'],
        description: 'কম্পিউটার ও ডেটা কম্যুনিকেশন টেকনোলজির ডিপ্লোমা শিক্ষার্থীদের নেটওয়ার্কিং ও রাউটিং প্র্যাকটিক্যাল শেখার আকর্ষণীয় সুযোগ।',
      ),
    ];
  }
}
