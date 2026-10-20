import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';

import '../core/l10n/app_localizations.dart';
import '../core/router/app_router.dart';
import '../core/theme/app_theme.dart';
import 'app_providers.dart';

import 'package:flutter/gestures.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

class DiplomaCareerHubApp extends ConsumerWidget {
  const DiplomaCareerHubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return OverlaySupport.global(
      child: MaterialApp.router(
        scrollBehavior: AppScrollBehavior(),
        title: 'DiplomaJOB',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeMode,
        locale: Locale('en'),
        supportedLocales: const [Locale('bn'), Locale('en')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: router,
      ),
    );
  }
}
