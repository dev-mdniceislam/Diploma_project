import 'package:diploma_job/features/profile/providers/profile_infra_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/company_profile_model.dart';

final companyPostingsProvider =
    FutureProvider.autoDispose<List<IndustrialJobModel>>((ref) async {
      final repo = ref.watch(
        profileRepositoryProvider,
      ); // আপনার existing repository
      return repo.fetchCompanyPostings();
    });
