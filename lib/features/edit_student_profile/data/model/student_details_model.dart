import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TechnicalSkill {
  final String title;
  final double percentage;

  const TechnicalSkill({required this.title, required this.percentage});

  TechnicalSkill copyWith({String? title, double? percentage}) {
    return TechnicalSkill(
      title: title ?? this.title,
      percentage: percentage ?? this.percentage,
    );
  }
}

class StudentProfileState {
  final String bio;
  final String email;
  final String phone;
  final String address;
  final String boardRoll;
  final String registrationNo;
  final String session;
  final String nocLetterNo;
  final List<TechnicalSkill> skills;

  const StudentProfileState({
    required this.bio,
    required this.email,
    required this.phone,
    required this.address,
    required this.boardRoll,
    required this.registrationNo,
    required this.session,
    required this.nocLetterNo,
    required this.skills,
  });

  StudentProfileState copyWith({
    String? bio,
    String? email,
    String? phone,
    String? address,
    String? boardRoll,
    String? registrationNo,
    String? session,
    String? nocLetterNo,
    List<TechnicalSkill>? skills,
  }) {
    return StudentProfileState(
      bio: bio ?? this.bio,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      boardRoll: boardRoll ?? this.boardRoll,
      registrationNo: registrationNo ?? this.registrationNo,
      session: session ?? this.session,
      nocLetterNo: nocLetterNo ?? this.nocLetterNo,
      skills: skills ?? this.skills,
    );
  }
}

class StudentProfileNotifier extends StateNotifier<StudentProfileState> {
  StudentProfileNotifier()
    : super(
        const StudentProfileState(
          bio: 'আমি দিনাজপুর পলিটেকনিক ইনস্টিটিউটের কম্পিউটার সায়েন্স অ্যান্ড টেকনোলজির ৮ ম সেমিস্টারের একজন আগ্রহী শিক্ষার্থী। আমি আধুনিক ওয়েব প্রযুক্তি (HTML, Tailwind CSS, JavaScript, React) এবং ডেটাবেজ ম্যানেজমেন্ট পছন্দ করি। ৮ ম সেমিস্টারের ইন্ডাস্ট্রিয়াল অ্যাটাচমেন্টের জন্য একটি মানসম্মত আইটি বা সফটওয়্যার কোম্পানিতে ইন্টার্নশিপ খুঁজছি।',
          email: 'nice.islam@example.com',
          phone: '+880 1789-123456',
          address: 'উপশহর, দিনাজপুর, বাংলাদেশ',
          boardRoll: '543211',
          registrationNo: '1502489231',
          session: '2020-21',
          nocLetterNo: 'DPI/ATTACH/2026/89',
          skills: [
            TechnicalSkill(
              title: 'HTML5, CSS3, Tailwind CSS',
              percentage: 0.90,
            ),
            TechnicalSkill(
              title: 'JavaScript (ES6+) & DOM Operations',
              percentage: 0.75,
            ),
            TechnicalSkill(
              title: 'Python & Basic MySQL Database',
              percentage: 0.70,
            ),
            TechnicalSkill(
              title: 'Git & GitHub Version Control',
              percentage: 0.80,
            ),
          ],
        ),
      );

  void updateProfile({
    String? bio,
    String? email,
    String? phone,
    String? address,
    String? boardRoll,
    String? registrationNo,
    String? session,
    String? nocLetterNo,
  }) {
    state = state.copyWith(
      bio: bio,
      email: email,
      phone: phone,
      address: address,
      boardRoll: boardRoll,
      registrationNo: registrationNo,
      session: session,
      nocLetterNo: nocLetterNo,
    );
  }

  void updateSkillPercentage(int index, double newPercentage) {
    final updatedSkills = List<TechnicalSkill>.from(state.skills);
    updatedSkills[index] = updatedSkills[index].copyWith(
      percentage: newPercentage,
    );
    state = state.copyWith(skills: updatedSkills);
  }
}

final studentProfileEditProvider =
    StateNotifierProvider<StudentProfileNotifier, StudentProfileState>((ref) {
      return StudentProfileNotifier();
    });
