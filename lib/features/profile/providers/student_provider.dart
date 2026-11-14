import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/student_profile_model.dart';
import '../data/profile_models.dart';
import 'profile_infra_provider.dart';

class StudentProfileNotifier extends AsyncNotifier<StudentFullProfileModel> {
  late Json _json;

  @override
  Future<StudentFullProfileModel> build() async {
    _json = await ref.read(profileRepositoryProvider).fetchStudentJson();
    return StudentFullProfileModel.fromJson(_json);
  }

  void _patch(Json changes) {
    _json = {..._json, ...changes};
    state = AsyncData(StudentFullProfileModel.fromJson(_json));
  }

  /// keys: name, polytechnic, technology, phone, email, bio
  void updateInfo(Json v) => _patch(v);

  void updateCv(String url) => _patch({'cvUrl': url});

  void addProject(Map<String, String> v) => _patch({
    'projects': [
      {
        'title': v['title'],
        'description': v['description'],
        'tags': splitTags(v['tech'] ?? ''),
      },
      ...(_json['projects'] as List? ?? const []),
    ],
  });
}

final studentProfileProvider =
    AsyncNotifierProvider<StudentProfileNotifier, StudentFullProfileModel>(
      StudentProfileNotifier.new,
    );
