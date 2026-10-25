import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../student_profile/presentation/providers/student_profile_providers.dart';
import '../../data/repositories/job_circular_repository_impl.dart';
import '../../domain/entities/job_circular.dart';
import '../../domain/repositories/job_circular_repository.dart';

// ── Repository ──────────────────────────────────────────────────────────────
final jobCircularRepositoryProvider = Provider<JobCircularRepository>(
  (ref) => MockJobCircularRepository(),
);

// ── Read: circular + my bookmark/application state, keyed by circular id ────
final jobDetailsProvider = FutureProvider.family<JobDetails, String>(
  (ref, id) => ref.watch(jobCircularRepositoryProvider).fetchDetails(id),
);

// ── Write: user actions. Repository errors (AppException) propagate. ───────
final jobActionsProvider = Provider<JobActions>((ref) => JobActions(ref));

class JobActions {
  JobActions(this._ref);

  final Ref _ref;

  JobCircularRepository get _repo => _ref.read(jobCircularRepositoryProvider);

  /// Returns the new bookmark value.
  Future<bool> toggleBookmark(String id, {required bool current}) async {
    final next = await _repo.setBookmark(id, value: !current);
    await _reload(id);
    return next;
  }

  Future<void> apply(String id, ApplicationDraft draft) async {
    await _repo.submitApplication(id, draft);
    await _reload(id);
  }

  Future<void> _reload(String id) async {
    _ref.invalidate(jobDetailsProvider(id));
    await _ref.read(jobDetailsProvider(id).future);
  }
}

// ── Logged-in student → apply dialog summary ────────────────────────────────
final applicantProvider = Provider<Applicant?>((ref) {
  final p = ref.watch(studentProfileProvider).value;
  if (p == null) return null;
  return Applicant(
    name: p.name,
    roll: p.boardRoll,
    institute: p.institute,
    avatarUrl: p.avatarUrl,
    semester: p.semester,
  );
});
