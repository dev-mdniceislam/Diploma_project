import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';

Future<void> main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  try {
    await _initApp();
  } catch (e, st) {
    log('Init failed: $e\n$st');
  } finally {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }
  runApp(ProviderScope(child: const DiplomaCareerHubApp()));
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
