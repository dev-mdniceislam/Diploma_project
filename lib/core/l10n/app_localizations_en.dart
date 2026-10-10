// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Diploma Job Hub';

  @override
  String get appTagline => 'Diploma Engineer Career Portal';

  @override
  String get navHome => 'Home / Circulars';

  @override
  String get navAttachment => 'Industrial Attachment';

  @override
  String get navGuide => 'Guideline & NOC';

  @override
  String get personaStudent => 'Student';

  @override
  String get personaCompany => 'Company';

  @override
  String get personaStudentToast => 'Student mode activated. Apply with ease!';

  @override
  String get personaCompanyToast =>
      'Company mode activated. Post a new circular!';

  @override
  String get postCircular => 'Post Circular';

  @override
  String get savedCirculars => 'Saved circulars';

  @override
  String get saveCircular => 'Save';

  @override
  String get savedAdded => 'Circular added to your bookmarks!';

  @override
  String get savedRemoved => 'Circular removed from your saved list.';

  @override
  String get menu => 'Menu';

  @override
  String get heroBadge =>
      'Bangladesh\'s first dedicated diploma engineering job portal';

  @override
  String get heroTitleLine => 'For diploma engineers and students';

  @override
  String get heroTitleHighlight => 'Top jobs & industrial attachments';

  @override
  String get heroSubtitle =>
      'Start your dream tech career with 300+ renowned companies. 8th-semester industrial training and job circulars on a single platform!';

  @override
  String get searchHint =>
      'Job title or skill (ex: PLC, AutoCAD, Developer)...';

  @override
  String get allTechnologiesDept => 'All technologies / departments';

  @override
  String get filterAction => 'Filter';

  @override
  String get statJobsValue => '450+';

  @override
  String get statJobsLabel => 'Active job openings';

  @override
  String get statInternsValue => '250+';

  @override
  String get statInternsLabel => 'Industrial attachment seats';

  @override
  String get statPartnersValue => '150+';

  @override
  String get statPartnersLabel => 'Partner companies';

  @override
  String get statPolytechnicValue => '100%';

  @override
  String get statPolytechnicLabel => 'For polytechnic students';

  @override
  String get techFilterTitle => 'Filter by technology:';

  @override
  String get techAll => 'All technologies';

  @override
  String get techComputer => 'Computer';

  @override
  String get techCivil => 'Civil';

  @override
  String get techElectrical => 'Electrical';

  @override
  String get techMechanical => 'Mechanical';

  @override
  String get techArchitecture => 'Architecture';

  @override
  String get techElectronics => 'Electronics';

  @override
  String tabAll(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'All circulars ($countString)';
  }

  @override
  String tabJobs(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '💼 Jobs ($countString)';
  }

  @override
  String tabInternships(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '🎓 8th-semester attachment ($countString)';
  }

  @override
  String get sortLabel => 'Sort:';

  @override
  String get sortNewest => 'Newest first';

  @override
  String get sortDeadline => 'Application deadline';

  @override
  String get jobTypeInternship => '🎓 Industrial attachment';

  @override
  String get jobTypeFullTime => '💼 Full-time job';

  @override
  String techBadge(String tech) {
    return '$tech Technology';
  }

  @override
  String deadlineLabel(String date) {
    return 'Deadline: $date';
  }

  @override
  String get applyNow => 'Apply now';

  @override
  String get emptyTitle => 'No circulars found!';

  @override
  String get emptyMessage =>
      'Nothing in our database matches your search or filters right now. Try a different keyword.';

  @override
  String get resetFilters => 'Reset all filters';

  @override
  String get errorLoading => 'Couldn\'t load circulars.';

  @override
  String get retry => 'Try again';

  @override
  String get footerAbout =>
      'A trusted place to build a career for students of all government and private polytechnic institutes in Bangladesh.';

  @override
  String get footerPopularTech => 'Popular technologies';

  @override
  String get footerImportantLinks => 'Important links';

  @override
  String get footerNocGuide => 'NOC application guide';

  @override
  String get footerPostCircular => 'Post a company circular';

  @override
  String get footerBteb => 'BTEB official site';

  @override
  String get footerContact => 'Contact & support';

  @override
  String get footerContactHint =>
      'For polytechnic liaison and job-post support:';

  @override
  String get footerCopyright => '© 2026 Diploma Job Hub. All rights reserved.';

  @override
  String get footerTagline =>
      'Dedicated to the career growth of polytechnic students.';
}
