import 'package:flutter/cupertino.dart';

class FontFamily {
  FontFamily._();

  /// Font family: myFont
  static const String english = 'englishFont';
  static const String bangla = 'bengaliFont';

  static String family(BuildContext context) {
    return Localizations.localeOf(context).countryCode == "en"
        ? english
        : bangla;
  }
}
