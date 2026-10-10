import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shared_prefs_provider.dart';

class LocaleNotifier extends Notifier<Locale> {
  static const _key = 'locale';

  @override
  Locale build() {
    final code = ref.read(sharedPreferencesProvider).getString(_key) ?? 'bn';
    return Locale(code);
  }

  void setLocale(Locale locale) {
    state = locale;
    ref.read(sharedPreferencesProvider).setString(_key, locale.languageCode);
  }

  void toggle() => setLocale(
        state.languageCode == 'bn' ? const Locale('en') : const Locale('bn'),
      );
}

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);
