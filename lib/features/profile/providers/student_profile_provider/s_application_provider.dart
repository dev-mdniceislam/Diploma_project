import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/student_profile_model.dart';
import '../profile_infra_provider.dart';

final studentApplicationsProvider =
FutureProvider.autoDispose<List<StudentApplicationModel>>((ref) {
  return ref.watch(profileRepositoryProvider).fetchStudentApplications();
});