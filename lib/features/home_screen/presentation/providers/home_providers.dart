import 'package:diploma_job/core/gen/network_caller_gen.dart';
import 'package:diploma_job/features/home_screen/data/repositories/mock_job_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/job.dart';
import '../../domain/entities/job_filter.dart';
import '../../domain/repositories/job_repository.dart';

/// API প্রতি পেজে কতগুলো job আনবে।
const kJobsPerPage = 9;

// ── Data ────────────────────────────────────────────────────────────────────
final jobRepositoryProvider = Provider<JobRepository>(
  (ref) => ApiJobRepository(ref.watch(networkCallerProvider)),
);

class JobPageNotifier extends Notifier<int> {
  @override
  int build() => 1;

  void goTo(int page) {
    if (page >= 1) state = page;
  }

  void next() => state = state + 1;

  void previous() {
    if (state > 1) state = state - 1;
  }

  void reset() => state = 1;
}

final jobPageProvider = NotifierProvider<JobPageNotifier, int>(
  JobPageNotifier.new,
);

/// বর্তমান পেজের job list। পেজ বদলালে সরাসরি নতুন পেজ fetch হয়।
final jobsProvider = FutureProvider.autoDispose<JobListPage>((ref) {
  final page = ref.watch(jobPageProvider);
  return ref
      .watch(jobRepositoryProvider)
      .fetchJobs(page: page, limit: kJobsPerPage);
});

// ── Filter state ────────────────────────────────────────────────────────────
class JobFilterNotifier extends Notifier<JobFilter> {
  @override
  JobFilter build() => const JobFilter();

  void setQuery(String value) {
    state = state.copyWith(query: value);
    ref.read(jobPageProvider.notifier).reset();
  }

  void setTech(String? value) {
    state = state.copyWith(tech: () => value);
    ref.read(jobPageProvider.notifier).reset();
  }

  void setType(JobTypeFilter value) {
    state = state.copyWith(type: value);
    ref.read(jobPageProvider.notifier).reset();
  }

  void setSort(JobSort value) {
    state = state.copyWith(sort: value);
    ref.read(jobPageProvider.notifier).reset();
  }

  void reset() {
    state = const JobFilter();
    ref.read(jobPageProvider.notifier).reset();
  }
}

final jobFilterProvider = NotifierProvider<JobFilterNotifier, JobFilter>(
  JobFilterNotifier.new,
);

// ── Counts ──────────────────────────────────────────────────────────────────
/// "সব" এর count = API-র মোট সংখ্যা। job / internship count শুধু বর্তমান পেজের।
final jobCountsProvider = Provider<JobCounts>((ref) {
  final data = ref.watch(jobsProvider).value;
  final jobs = data?.jobs ?? const <JobListItem>[];
  final internships = jobs.where((j) => j.isInternship).length;
  return JobCounts(
    all: data?.pagination.total ?? jobs.length,
    jobs: jobs.length - internships,
    internships: internships,
  );
});

// ── Saved / bookmarked ──────────────────────────────────────────────────────
class SavedJobsNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

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

// ── Persona ─────────────────────────────────────────────────────────────────
enum Persona { student, company }

class PersonaNotifier extends Notifier<Persona> {
  @override
  Persona build() => Persona.student;

  void set(Persona value) => state = value;
}

final personaProvider = NotifierProvider<PersonaNotifier, Persona>(
  PersonaNotifier.new,
);
