import 'package:diploma_job/core/gen/network_caller_gen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../profile/providers/student_provider.dart';
import '../../data/repositories/job_circular_repository_impl.dart';
import '../../domain/entities/job_circular.dart';
import '../../domain/repositories/job_circular_repository.dart';

// Override this in ProviderScope(overrides: [...]) at app startup.

final jobCircularRepositoryProvider = Provider<JobCircularRepository>((ref) {
  return JobCircularRepositoryImpl(ref.watch(networkCallerProvider));
});

// Read: one job, keyed by id.
final jobDetailsProvider = FutureProvider.autoDispose
    .family<JobAttachmentModel, String>((ref, id) async {
      final json = await ref
          .watch(jobCircularRepositoryProvider)
          .fetchDetails(id);
      return JobAttachmentModel.fromJson(json);
    });

// ---------- User state (bookmark + applied) ----------

class JobUserState {
  const JobUserState({
    this.bookmarked = const <String>{},
    this.applied = const <String>{},
  });

  final Set<String> bookmarked;
  final Set<String> applied;

  bool isBookmarked(String id) => bookmarked.contains(id);
  bool isApplied(String id) => applied.contains(id);

  JobUserState copyWith({Set<String>? bookmarked, Set<String>? applied}) {
    return JobUserState(
      bookmarked: bookmarked ?? this.bookmarked,
      applied: applied ?? this.applied,
    );
  }
}

class JobUserStateNotifier extends AsyncNotifier<JobUserState> {
  @override
  Future<JobUserState> build() async {
    // TODO: backend endpoint পেলে এখানে bookmark ও applied ids load করো।
    return const JobUserState();
  }

  JobCircularRepository get _repo => ref.read(jobCircularRepositoryProvider);

  /// নতুন bookmark অবস্থা return করে।
  Future<bool> toggleBookmark(String id) async {
    final current = state.value ?? const JobUserState();

    final saved = await _repo.setBookmark(id, value: !current.isBookmarked(id));

    final next = Set<String>.of(current.bookmarked);
    saved ? next.add(id) : next.remove(id);

    state = AsyncData(current.copyWith(bookmarked: next));
    return saved;
  }

  /// Application submit করে এবং সফল হলে local state update করে।
  Future<MyApplication> submitApplication(
    String id,
    ApplicationDraft draft,
  ) async {
    final current = state.value ?? const JobUserState();

    final application = await _repo.submitApplication(id, draft);

    state = AsyncData(current.copyWith(applied: {...current.applied, id}));
    return application;
  }
}

final jobUserStateProvider =
    AsyncNotifierProvider<JobUserStateNotifier, JobUserState>(
      JobUserStateNotifier.new,
    );

// Logged-in student → apply dialog summary.
final applicantProvider = Provider<Applicant?>((ref) {
  final p = ref.watch(studentProfileProvider).value;
  if (p == null) return null;
  return Applicant(
    name: p.name,
    roll: p.boardRoll,
    institute: p.institute,
    avatarUrl: p.avatarUrl,
    semester: p.semester.toString(),
  );
});
