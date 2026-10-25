import '../../domain/entities/student_profile.dart';
import '../../domain/repositories/student_profile_repository.dart';

/// In-memory implementation seeded with the design's sample data.
/// Replace with an API-backed repository that uses [NetworkCaller] and
/// throws `AppException` on failure.
class MockStudentProfileRepository implements StudentProfileRepository {
  StudentProfile _store = _seed;

  @override
  Future<StudentProfile> fetchProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return _store;
  }

  @override
  Future<StudentProfile> saveProfile(StudentProfile profile) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return _store = profile;
  }

  static final StudentProfile _seed = StudentProfile(
    id: 'std-543211',
    name: 'মোঃ নাইস ইসলাম',
    avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=400',
    department: 'ডিপ্লোমা ইন কম্পিউটার সায়েন্স অ্যান্ড টেকনোলজি (CST)',
    institute: 'দিনাজপুর পলিটেকনিক ইনস্টিটিউট',
    boardRoll: '543211',
    registration: '1502489231',
    session: '2020-21',
    semester: 8,
    cgpa: 3.85,
    isVerified: false,
    nocStatus: NocStatus.issued,
    nocNumber: 'DPI/ATTACH/2026/89',
    bio: 'আমি দিনাজপুর পলিটেকনিক ইনস্টিটিউটের কম্পিউটার সায়েন্স অ্যান্ড টেকনোলজির ৮ম সেমিস্টারের একজন আগ্রহী শিক্ষার্থী। আমি আধুনিক ওয়েব টেকনোলজি (HTML, Tailwind CSS, JavaScript, React) এবং ডেটাবেজ ম্যানেজমেন্ট পছন্দ করি। ৮ম সেমিস্টারের ইন্ডাস্ট্রিয়াল অ্যাটাচমেন্টের জন্য একটি মানসম্মত আইটি বা সফটওয়্যার কোম্পানিতে ইন্টার্নশিপ খুঁজছি।',
    email: 'nice.islam@example.com',
    phone: '+880 1789-123456',
    location: 'উপশহর, দিনাজপুর, বাংলাদেশ',
    skills: const [
      SkillLevel(name: 'HTML5, CSS3, Tailwind CSS', percent: 90),
      SkillLevel(
        name: 'JavaScript (ES6+) & DOM Operations',
        percent: 75,
        tone: SkillTone.success,
      ),
      SkillLevel(
        name: 'Python & Basic MySQL Database',
        percent: 70,
        tone: SkillTone.info,
      ),
      SkillLevel(
        name: 'Git & GitHub Version Control',
        percent: 80,
        tone: SkillTone.warning,
      ),
    ],
    semesterResults: const [
      SemesterResult(semester: 1, year: 2021, gpa: 3.75),
      SemesterResult(semester: 2, year: 2021, gpa: 3.80),
      SemesterResult(semester: 3, year: 2022, gpa: 3.85),
      SemesterResult(semester: 4, year: 2023, gpa: 3.90),
      SemesterResult(semester: 5, year: 2023, gpa: 3.82),
      SemesterResult(semester: 6, year: 2024, gpa: 3.95),
      SemesterResult(semester: 7, year: 2024, gpa: 3.88),
    ],
    ssc: const SscRecord(
      school: 'দিনাজপুর জিলা স্কুল',
      group: 'বিজ্ঞান বিভাগ',
      board: 'দিনাজপুর বোর্ড',
      year: 2020,
      gpa: 5.00,
    ),
    projects: const [
      Project(
        id: 'p1',
        category: 'ওয়েব অ্যাপ প্রজেক্ট',
        title: 'পলিটেকনিক রেজাল্ট ক্যালকুলেটর',
        description: 'বিটিইবি ডিপ্লোমা ইঞ্জিনিয়ারিং শিক্ষার্থীদের সেমিস্টার ভিত্তিক জিপিএ ও ওয়েটেজ হিসেব করার সহজ সিঙ্গেল পেজ অ্যাপ্লিকেশন।',
        technologies: ['JavaScript', 'Tailwind CSS', 'LocalStorage'],
        icon: ProjectIcon.calculator,
        liveUrl: 'https://example.com/demo',
        repoUrl: 'https://github.com',
      ),
      Project(
        id: 'p2',
        category: 'ই-কমার্স ডিজাইন',
        title: 'অনলাইন বই বিক্রির প্ল্যাটফর্ম',
        description: 'ডিপ্লোমা শিক্ষার্থীদের জন্য বুক ক্যাটাগরি, শপিং কার্ট এবং ফিল্টারিং সুবিধাসহ ফুল রেসপন্সিভ ওয়েব লেআউট।',
        technologies: ['HTML5', 'CSS Grid', 'JS ES6'],
        icon: ProjectIcon.shopping,
        liveUrl: 'https://example.com/demo',
        repoUrl: 'https://github.com',
      ),
    ],
    applications: [
      JobApplication(
        id: 'a1',
        company: 'Walton Hi-Tech Industries PLC',
        position: 'PLC & Automation Training Intern',
        type: ApplicationType.attachment,
        appliedAt: DateTime(2026, 10, 20),
        status: ApplicationStatus.shortlisted,
        message: 'ইন্টারভিউ মেসেজ: ২৪ অক্টোবর ল্যাব টেস্টে অংশ নিন',
      ),
      JobApplication(
        id: 'a2',
        company: 'SoftTech IT Bangladesh',
        position: 'Junior Web Developer (Diploma Freshers)',
        type: ApplicationType.job,
        appliedAt: DateTime(2026, 10, 18),
        status: ApplicationStatus.interview,
        message: 'অনলাইন ইন্টারভিউ লিংক ইমেইলে পাঠানো হয়েছে',
      ),
      JobApplication(
        id: 'a3',
        company: 'Energypac Engineering Ltd.',
        position: 'Industrial Attachment Trainee',
        type: ApplicationType.attachment,
        appliedAt: DateTime(2026, 10, 15),
        status: ApplicationStatus.pending,
        message: 'আপনার আবেদনটি এইচআর টিম রিভিউ করছে',
      ),
    ],
    certificates: const [
      Certificate(
        title: 'Web Development Fundamentals',
        issuer: 'BTEB & SEIP Training Program (2024)',
      ),
      Certificate(
        title: 'Python & Problem Solving',
        issuer: 'Coursera Specialization (2025)',
      ),
    ],
    socialLinks: const [
      SocialLink(type: SocialType.linkedin, url: 'https://linkedin.com'),
      SocialLink(type: SocialType.github, url: 'https://github.com'),
    ],
  );
}
