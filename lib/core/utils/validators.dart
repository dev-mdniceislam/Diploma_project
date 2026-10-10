// import '../../l10n/app_localizations.dart';
//
// class Validators {
//   Validators._();
//
//   static String? required(AppLocalizations l10n, String? v) =>
//       (v == null || v.trim().isEmpty) ? l10n.requiredField : null;
//
//   /// Bangladeshi mobile: 01[3-9]XXXXXXXX, optional +88 / 88 prefix.
//   static String? phone(AppLocalizations l10n, String? v) {
//     if (v == null || v.trim().isEmpty) return l10n.requiredField;
//     final ok = RegExp(r'^(?:\+?88)?01[3-9]\d{8}$').hasMatch(v.trim());
//     return ok ? null : l10n.invalidPhone;
//   }
//
//   static String? cgpa(AppLocalizations l10n, String? v) {
//     if (v == null || v.trim().isEmpty) return l10n.requiredField;
//     final n = double.tryParse(v.trim());
//     return (n == null || n < 0 || n > 4) ? l10n.invalidCgpa : null;
//   }
//
//   static String? email(AppLocalizations l10n, String? v) {
//     if (v == null || v.trim().isEmpty) return l10n.requiredField;
//     final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
//     return ok ? null : l10n.invalidEmail;
//   }
//
//   static String? positiveInt(AppLocalizations l10n, String? v) {
//     if (v == null || v.trim().isEmpty) return l10n.requiredField;
//     final n = int.tryParse(v.trim());
//     return (n == null || n <= 0) ? l10n.invalidNumber : null;
//   }
//
//   static String? minLength(AppLocalizations l10n, String? v, int min) {
//     if (v == null || v.trim().isEmpty) return l10n.requiredField;
//     return v.trim().length < min ? l10n.descTooShort : null;
//   }
// }
