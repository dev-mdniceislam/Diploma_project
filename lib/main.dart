import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/providers/shared_prefs_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      // overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const DiplomaCareerHubApp(),
    ),
  );
}
