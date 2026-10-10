import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Controls light/dark/system theme. UI toggles call
/// `ref.read(themeModeProvider.notifier).set(...)`.
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  void set(ThemeMode mode) => state = mode;

  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

/// Controls active locale (bn / en). Defaults to Bengali since that's the
/// school's primary audience.
class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() => const Locale('bn');

  void set(Locale locale) => state = locale;

  void toggle() {
    state = state.languageCode == 'bn'
        ? const Locale('en')
        : const Locale('bn');
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);
