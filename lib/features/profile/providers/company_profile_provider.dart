import 'package:diploma_job/features/profile/data/model/company_profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../profile_core.dart';
import '../data/profile_models.dart';
import 'profile_infra_provider.dart' hide profileRepositoryProvider;

class CompanyProfileNotifier extends AsyncNotifier<CompanyProfileModel> {
  late Json _json;

  @override
  Future<CompanyProfileModel> build() async {
    final user = await ref.watch(profileUserProvider.future);
    _json = await ref.read(profileRepositoryProvider).fetchCompanyJson(user);
    return CompanyProfileModel.fromJson(_json);
  }

  void _patch(Json changes) {
    _json = {..._json, ...changes};
    state = AsyncData(CompanyProfile.fromJson(_json));
  }

  /// keys: name, industry, hrEmail, hrPhone, about
  void updateInfo(Json v) => _patch(v);

  /// keys: type, title, tech, seats, salary, deadline, location, benefits
  void addPosting(Map<String, String> v) => _patch({
    'postings': [
      {
        'id': DateTime.now().microsecondsSinceEpoch.toString(),
        'type': v['type'],
        'title': v['title'],
        'tech': v['tech'],
        'seats': int.tryParse(v['seats'] ?? '') ?? 0,
        'salary': v['salary'],
        'deadline': v['deadline'],
        'location': v['location'],
        'tags': splitTags(v['benefits'] ?? ''),
        'applicants': 0,
      },
      ...(_json['postings'] as List? ?? const []),
    ],
  });

  void shortlist(String id) => _updateApplicant(id, {'status': 'shortlisted'});

  void scheduleInterview(String id, String at, String place) =>
      _updateApplicant(id, {
        'status': 'interview',
        'interviewAt': at,
        'interviewPlace': place,
      });

  void _updateApplicant(String id, Json changes) => _patch({
    'applicants': [
      for (final a in _json['applicants'] as List? ?? const [])
        if (a is Map<String, dynamic> && '${a['id']}' == id)
          {...a, ...changes}
        else
          a,
    ],
  });
}

final companyProfileProvider =
    AsyncNotifierProvider<CompanyProfileNotifier, CompanyProfileModel>(
      CompanyProfileNotifier.new,
    );
