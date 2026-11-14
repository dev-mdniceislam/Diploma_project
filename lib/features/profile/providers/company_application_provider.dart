import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/company_profile_model.dart';
import 'profile_infra_provider.dart';

final companyApplicantsProvider =
FutureProvider.autoDispose<List<CompanyApplicantsModel>>((ref) {
  return ref.watch(profileRepositoryProvider).fetchCompanyApplicants();
});