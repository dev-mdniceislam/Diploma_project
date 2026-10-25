import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/student_profile_repository_impl.dart';
import '../../domain/entities/student_profile.dart';
import '../../domain/repositories/student_profile_repository.dart';

// ── Repository ──────────────────────────────────────────────────────────────
final studentProfileRepositoryProvider = Provider<StudentProfileRepository>(
  (ref) => MockStudentProfileRepository(),
);

// ── Profile (async state + mutations) ───────────────────────────────────────
final studentProfileProvider =
    AsyncNotifierProvider<StudentProfileNotifier, StudentProfile>(
  StudentProfileNotifier.new,
);

class StudentProfileNotifier extends AsyncNotifier<StudentProfile> {
  StudentProfileRepository get _repo =>
      ref.read(studentProfileRepositoryProvider);

  @override
  Future<StudentProfile> build() => _repo.fetchProfile();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_repo.fetchProfile);
  }

  Future<void> updateBasicInfo({
    required String name,
    required String institute,
    required String department,
    required String phone,
    required String email,
    required String bio,
  }) {
    return _save(
      (p) => p.copyWith(
        name: name,
        institute: institute,
        department: department,
        phone: phone,
        email: email,
        bio: bio,
      ),
    );
  }

  Future<void> updateCvLink(String url) => _save((p) => p.copyWith(cvUrl: url));

  Future<void> addProject({
    required String title,
    required List<String> technologies,
    required String description,
  }) {
    return _save(
      (p) => p.copyWith(
        projects: [
          Project(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            title: title,
            description: description,
            technologies: technologies,
          ),
          ...p.projects,
        ],
      ),
    );
  }

  /// Persists first, then publishes — the UI never shows unsaved data.
  /// Repository errors (AppException) propagate to the caller.
  Future<void> _save(StudentProfile Function(StudentProfile) transform) async {
    final current = state.value;
    if (current == null) return;
    final saved = await _repo.saveProfile(transform(current));
    state = AsyncData(saved);
  }
}

// ── Selected tab ────────────────────────────────────────────────────────────
enum ProfileTab { overview, academic, projects, applications, certifications }

class ProfileTabNotifier extends Notifier<ProfileTab> {
  @override
  ProfileTab build() => ProfileTab.overview;

  void select(ProfileTab tab) => state = tab;
}

final profileTabProvider = NotifierProvider<ProfileTabNotifier, ProfileTab>(
  ProfileTabNotifier.new,
);

// ── Applications filter ─────────────────────────────────────────────────────
enum ApplicationFilter {
  all(null),
  shortlisted(ApplicationStatus.shortlisted),
  pending(ApplicationStatus.pending),
  interview(ApplicationStatus.interview);

  const ApplicationFilter(this.status);
  final ApplicationStatus? status;
}

class ApplicationFilterNotifier extends Notifier<ApplicationFilter> {
  @override
  ApplicationFilter build() => ApplicationFilter.all;

  void select(ApplicationFilter filter) => state = filter;
}

final applicationFilterProvider =
    NotifierProvider<ApplicationFilterNotifier, ApplicationFilter>(
  ApplicationFilterNotifier.new,
);

final filteredApplicationsProvider = Provider<List<JobApplication>>((ref) {
  final all = ref.watch(
        studentProfileProvider.select((v) => v.value?.applications),
      ) ??
      const <JobApplication>[];
  final status = ref.watch(applicationFilterProvider).status;
  return status == null
      ? all
      : all.where((a) => a.status == status).toList(growable: false);
});
