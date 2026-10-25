import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Locale-aware number / date / digit formatting so the same widget code
/// renders "3.85" in English and "৩.৮৫" in Bangla.
extension LocalizedFormatX on BuildContext {
  String get localeTag => Localizations.localeOf(this).toLanguageTag();
  bool get isBangla => Localizations.localeOf(this).languageCode == 'bn';

  String fmtNumber(num value, {int decimals = 0}) =>
      NumberFormat.decimalPatternDigits(
        locale: localeTag,
        decimalDigits: decimals,
      ).format(value);

  String fmtPercent(int percent) =>
      NumberFormat.percentPattern(localeTag).format(percent / 100);

  String fmtDate(DateTime date) =>
      DateFormat.yMMMMd(localeTag).format(date.toLocal());

  /// Converts every ASCII digit in [value] to Bangla digits when the
  /// active locale is Bangla (no grouping, safe for years / roll / phone).
  String fmtDigits(Object? value) {
    final text = '$value';
    if (!isBangla) return text;
    const bn = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    return text.replaceAllMapped(RegExp(r'\d'), (m) => bn[int.parse(m[0]!)]);
  }
}
