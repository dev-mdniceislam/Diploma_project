import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/company_profile_model.dart';
import '../data/profile_models.dart';
import 'profile_infra_provider.dart';

class CompanyProfileNotifier extends AsyncNotifier<CompanyProfileModel> {
  late Json _json;

  @override
  Future<CompanyProfileModel> build() async {
    _json = await ref.read(profileRepositoryProvider).fetchCompanyJson();
    return CompanyProfileModel.fromJson(_json);
  }

  void _patch(Json changes) {
    _json = {..._json, ...changes};
    state = AsyncData(CompanyProfileModel.fromJson(_json));
  }

  /// keys: companyName, industryCategory, hrEmail, helplineNumber, about, location, website
  void updateInfo(Json v) => _patch(v);
}

final companyProfileProvider =
    AsyncNotifierProvider<CompanyProfileNotifier, CompanyProfileModel>(
      CompanyProfileNotifier.new,
    );
