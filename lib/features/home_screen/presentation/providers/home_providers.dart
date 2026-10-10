import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_job_repository.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/job_filter.dart';
import '../../domain/repositories/job_repository.dart';

// ── Data ────────────────────────────────────────────────────────────────────
final jobRepositoryProvider = Provider<JobRepository>(
  (ref) => MockJobRepository(),
);

final jobsProvider = FutureProvider<List<Job>>(
  (ref) => ref.watch(jobRepositoryProvider).getJobs(),
);

// ── Filter state ────────────────────────────────────────────────────────────
class JobFilterNotifier extends Notifier<JobFilter> {
  @override
  JobFilter build() => const JobFilter();

  void setQuery(String value) => state = state.copyWith(query: value);
  void setTech(JobTech? value) => state = state.copyWith(tech: () => value);
  void setType(JobTypeFilter value) => state = state.copyWith(type: value);
  void setSort(JobSort value) => state = state.copyWith(sort: value);
  void reset() => state = const JobFilter();
}

final jobFilterProvider = NotifierProvider<JobFilterNotifier, JobFilter>(
  JobFilterNotifier.new,
);

// ── Derived ─────────────────────────────────────────────────────────────────
final filteredJobsProvider = Provider<AsyncValue<List<Job>>>((ref) {
  final filter = ref.watch(jobFilterProvider);
  return ref.watch(jobsProvider).whenData(filter.apply);
});

final jobCountsProvider = Provider<JobCounts>((ref) {
  final filter = ref.watch(jobFilterProvider);
  final jobs = ref.watch(jobsProvider).value ?? const <Job>[];
  return filter.countsFor(jobs);
});

// ── Saved / bookmarked ──────────────────────────────────────────────────────
/// In-memory for now. To persist (the HTML used localStorage) load/save the set
/// with shared_preferences inside this notifier.
class SavedJobsNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  /// Returns `true` if the job was added, `false` if it was removed.
  bool toggle(String id) {
    final next = {...state};
    final added = next.add(id);
    if (!added) next.remove(id);
    state = next;
    return added;
  }
}

final savedJobsProvider = NotifierProvider<SavedJobsNotifier, Set<String>>(
  SavedJobsNotifier.new,
);

// ── Persona (student / company) ─────────────────────────────────────────────
enum Persona { student, company }

class PersonaNotifier extends Notifier<Persona> {
  @override
  Persona build() => Persona.student;

  void set(Persona value) => state = value;
}

final personaProvider = NotifierProvider<PersonaNotifier, Persona>(
  PersonaNotifier.new,
);
