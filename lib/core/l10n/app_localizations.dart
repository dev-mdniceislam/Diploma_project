import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Diploma Job Hub'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Diploma Engineer Career Portal'**
  String get appTagline;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home / Circulars'**
  String get navHome;

  /// No description provided for @navAttachment.
  ///
  /// In en, this message translates to:
  /// **'Industrial Attachment'**
  String get navAttachment;

  /// No description provided for @navGuide.
  ///
  /// In en, this message translates to:
  /// **'Guideline & NOC'**
  String get navGuide;

  /// No description provided for @personaStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get personaStudent;

  /// No description provided for @personaCompany.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get personaCompany;

  /// No description provided for @personaStudentToast.
  ///
  /// In en, this message translates to:
  /// **'Student mode activated. Apply with ease!'**
  String get personaStudentToast;

  /// No description provided for @personaCompanyToast.
  ///
  /// In en, this message translates to:
  /// **'Company mode activated. Post a new circular!'**
  String get personaCompanyToast;

  /// No description provided for @postCircular.
  ///
  /// In en, this message translates to:
  /// **'Post Circular'**
  String get postCircular;

  /// No description provided for @savedCirculars.
  ///
  /// In en, this message translates to:
  /// **'Saved circulars'**
  String get savedCirculars;

  /// No description provided for @saveCircular.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveCircular;

  /// No description provided for @savedAdded.
  ///
  /// In en, this message translates to:
  /// **'Circular added to your bookmarks!'**
  String get savedAdded;

  /// No description provided for @savedRemoved.
  ///
  /// In en, this message translates to:
  /// **'Circular removed from your saved list.'**
  String get savedRemoved;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @heroBadge.
  ///
  /// In en, this message translates to:
  /// **'Bangladesh\'s first dedicated diploma engineering job portal'**
  String get heroBadge;

  /// No description provided for @heroTitleLine.
  ///
  /// In en, this message translates to:
  /// **'For diploma engineers and students'**
  String get heroTitleLine;

  /// No description provided for @heroTitleHighlight.
  ///
  /// In en, this message translates to:
  /// **'Top jobs & industrial attachments'**
  String get heroTitleHighlight;

  /// No description provided for @heroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start your dream tech career with 300+ renowned companies. 8th-semester industrial training and job circulars on a single platform!'**
  String get heroSubtitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Job title or skill (ex: PLC, AutoCAD, Developer)...'**
  String get searchHint;

  /// No description provided for @allTechnologiesDept.
  ///
  /// In en, this message translates to:
  /// **'All technologies / departments'**
  String get allTechnologiesDept;

  /// No description provided for @filterAction.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterAction;

  /// No description provided for @statJobsValue.
  ///
  /// In en, this message translates to:
  /// **'450+'**
  String get statJobsValue;

  /// No description provided for @statJobsLabel.
  ///
  /// In en, this message translates to:
  /// **'Active job openings'**
  String get statJobsLabel;

  /// No description provided for @statInternsValue.
  ///
  /// In en, this message translates to:
  /// **'250+'**
  String get statInternsValue;

  /// No description provided for @statInternsLabel.
  ///
  /// In en, this message translates to:
  /// **'Industrial attachment seats'**
  String get statInternsLabel;

  /// No description provided for @statPartnersValue.
  ///
  /// In en, this message translates to:
  /// **'150+'**
  String get statPartnersValue;

  /// No description provided for @statPartnersLabel.
  ///
  /// In en, this message translates to:
  /// **'Partner companies'**
  String get statPartnersLabel;

  /// No description provided for @statPolytechnicValue.
  ///
  /// In en, this message translates to:
  /// **'100%'**
  String get statPolytechnicValue;

  /// No description provided for @statPolytechnicLabel.
  ///
  /// In en, this message translates to:
  /// **'For polytechnic students'**
  String get statPolytechnicLabel;

  /// No description provided for @techFilterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter by technology:'**
  String get techFilterTitle;

  /// No description provided for @techAll.
  ///
  /// In en, this message translates to:
  /// **'All technologies'**
  String get techAll;

  /// No description provided for @techComputer.
  ///
  /// In en, this message translates to:
  /// **'Computer'**
  String get techComputer;

  /// No description provided for @techCivil.
  ///
  /// In en, this message translates to:
  /// **'Civil'**
  String get techCivil;

  /// No description provided for @techElectrical.
  ///
  /// In en, this message translates to:
  /// **'Electrical'**
  String get techElectrical;

  /// No description provided for @techMechanical.
  ///
  /// In en, this message translates to:
  /// **'Mechanical'**
  String get techMechanical;

  /// No description provided for @techArchitecture.
  ///
  /// In en, this message translates to:
  /// **'Architecture'**
  String get techArchitecture;

  /// No description provided for @techElectronics.
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get techElectronics;

  /// No description provided for @tabAll.
  ///
  /// In en, this message translates to:
  /// **'All circulars ({count})'**
  String tabAll(int count);

  /// No description provided for @tabJobs.
  ///
  /// In en, this message translates to:
  /// **'💼 Jobs ({count})'**
  String tabJobs(int count);

  /// No description provided for @tabInternships.
  ///
  /// In en, this message translates to:
  /// **'🎓 8th-semester attachment ({count})'**
  String tabInternships(int count);

  /// No description provided for @sortLabel.
  ///
  /// In en, this message translates to:
  /// **'Sort:'**
  String get sortLabel;

  /// No description provided for @sortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest first'**
  String get sortNewest;

  /// No description provided for @sortDeadline.
  ///
  /// In en, this message translates to:
  /// **'Application deadline'**
  String get sortDeadline;

  /// No description provided for @jobTypeInternship.
  ///
  /// In en, this message translates to:
  /// **'🎓 Industrial attachment'**
  String get jobTypeInternship;

  /// No description provided for @jobTypeFullTime.
  ///
  /// In en, this message translates to:
  /// **'💼 Full-time job'**
  String get jobTypeFullTime;

  /// No description provided for @techBadge.
  ///
  /// In en, this message translates to:
  /// **'{tech} Technology'**
  String techBadge(String tech);

  /// No description provided for @deadlineLabel.
  ///
  /// In en, this message translates to:
  /// **'Deadline: {date}'**
  String deadlineLabel(String date);

  /// No description provided for @applyNow.
  ///
  /// In en, this message translates to:
  /// **'Apply now'**
  String get applyNow;

  /// No description provided for @emptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No circulars found!'**
  String get emptyTitle;

  /// No description provided for @emptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing in our database matches your search or filters right now. Try a different keyword.'**
  String get emptyMessage;

  /// No description provided for @resetFilters.
  ///
  /// In en, this message translates to:
  /// **'Reset all filters'**
  String get resetFilters;

  /// No description provided for @errorLoading.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load circulars.'**
  String get errorLoading;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @footerAbout.
  ///
  /// In en, this message translates to:
  /// **'A trusted place to build a career for students of all government and private polytechnic institutes in Bangladesh.'**
  String get footerAbout;

  /// No description provided for @footerPopularTech.
  ///
  /// In en, this message translates to:
  /// **'Popular technologies'**
  String get footerPopularTech;

  /// No description provided for @footerImportantLinks.
  ///
  /// In en, this message translates to:
  /// **'Important links'**
  String get footerImportantLinks;

  /// No description provided for @footerNocGuide.
  ///
  /// In en, this message translates to:
  /// **'NOC application guide'**
  String get footerNocGuide;

  /// No description provided for @footerPostCircular.
  ///
  /// In en, this message translates to:
  /// **'Post a company circular'**
  String get footerPostCircular;

  /// No description provided for @footerBteb.
  ///
  /// In en, this message translates to:
  /// **'BTEB official site'**
  String get footerBteb;

  /// No description provided for @footerContact.
  ///
  /// In en, this message translates to:
  /// **'Contact & support'**
  String get footerContact;

  /// No description provided for @footerContactHint.
  ///
  /// In en, this message translates to:
  /// **'For polytechnic liaison and job-post support:'**
  String get footerContactHint;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Diploma Job Hub. All rights reserved.'**
  String get footerCopyright;

  /// No description provided for @footerTagline.
  ///
  /// In en, this message translates to:
  /// **'Dedicated to the career growth of polytechnic students.'**
  String get footerTagline;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
