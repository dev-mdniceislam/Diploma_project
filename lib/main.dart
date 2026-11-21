import 'dart:developer';

import 'package:diploma_job/core/database/local_storage.dart';
import 'package:diploma_job/core/gen/network_caller_gen.dart';
import 'package:diploma_job/features/profile/providers/profile_infra_provider.dart'
    hide networkCallerProvider;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';

Future<void> main() async {
  usePathUrlStrategy();
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  try {
    await _initApp();
  } catch (e, st) {
    log('Init failed: $e\n$st');
  } finally {
    FlutterNativeSplash.remove();
  }

  final netCaller = NetworkCaller();
  // final token = await LocalStorage().readData(key: 'token');

  runApp(
    ProviderScope(
      retry: (retryCount, error) => null,
      overrides: [
        networkCallerProvider.overrideWithValue(netCaller),
        // authTokenProvider.overrideWithValue(token),
      ],
      child: const DiplomaCareerHubApp(),
    ),
  );
}

Future<void> _initApp() async {
  await Future.wait([
    SharedPreferences.getInstance(),
    dotenv.load(fileName: ".env"),
    ScreenUtil.ensureScreenSize(),
    // SharedPreferences.getInstance(),
    // Firebase.initializeApp(),
    // LocalStorage.init(),
  ]);
}
