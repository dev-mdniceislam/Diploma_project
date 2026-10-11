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

  /// No description provided for @stepAuthentication.
  ///
  /// In en, this message translates to:
  /// **'================================== Authentication ========================'**
  String get stepAuthentication;

  /// No description provided for @authBadge.
  ///
  /// In en, this message translates to:
  /// **'BTEB registered & verified platform'**
  String get authBadge;

  /// No description provided for @authHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'The right career start for diploma engineers'**
  String get authHeroTitle;

  /// No description provided for @authHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find your 8th-semester attachment and your dream job after graduation with a single account.'**
  String get authHeroSubtitle;

  /// No description provided for @authFeature1.
  ///
  /// In en, this message translates to:
  /// **'350+ attachment partners of the Bangladesh Technical Education Board'**
  String get authFeature1;

  /// No description provided for @authFeature2.
  ///
  /// In en, this message translates to:
  /// **'Submit your polytechnic CV instantly in 1 click'**
  String get authFeature2;

  /// No description provided for @authFeature3.
  ///
  /// In en, this message translates to:
  /// **'Online NOC & recommendation letter guidelines'**
  String get authFeature3;

  /// No description provided for @demoTitle.
  ///
  /// In en, this message translates to:
  /// **'Quickly test with a demo account:'**
  String get demoTitle;

  /// No description provided for @demoStudent.
  ///
  /// In en, this message translates to:
  /// **'Student demo'**
  String get demoStudent;

  /// No description provided for @demoCompany.
  ///
  /// In en, this message translates to:
  /// **'Company demo'**
  String get demoCompany;

  /// No description provided for @demoStudentToast.
  ///
  /// In en, this message translates to:
  /// **'Student demo details filled in automatically.'**
  String get demoStudentToast;

  /// No description provided for @demoCompanyToast.
  ///
  /// In en, this message translates to:
  /// **'Company demo details filled in automatically.'**
  String get demoCompanyToast;

  /// No description provided for @tabLogin.
  ///
  /// In en, this message translates to:
  /// **'Sign in (Login)'**
  String get tabLogin;

  /// No description provided for @tabRegister.
  ///
  /// In en, this message translates to:
  /// **'Create account (Register)'**
  String get tabRegister;

  /// No description provided for @roleStudent.
  ///
  /// In en, this message translates to:
  /// **'Diploma student / graduate'**
  String get roleStudent;

  /// No description provided for @roleCompany.
  ///
  /// In en, this message translates to:
  /// **'Hiring company'**
  String get roleCompany;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email address *'**
  String get fieldEmail;

  /// No description provided for @fieldPassword.
  ///
  /// In en, this message translates to:
  /// **'Password *'**
  String get fieldPassword;

  /// No description provided for @fieldConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password *'**
  String get fieldConfirmPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @loginAction.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginAction;

  /// No description provided for @registerAction.
  ///
  /// In en, this message translates to:
  /// **'Complete registration'**
  String get registerAction;

  /// No description provided for @fieldFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name *'**
  String get fieldFullName;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'ex: Md. Tanvir Ahmed'**
  String get fullNameHint;

  /// No description provided for @fieldPolytechnic.
  ///
  /// In en, this message translates to:
  /// **'Polytechnic institute *'**
  String get fieldPolytechnic;

  /// No description provided for @selectPolytechnic.
  ///
  /// In en, this message translates to:
  /// **'Select institute'**
  String get selectPolytechnic;

  /// No description provided for @fieldDepartment.
  ///
  /// In en, this message translates to:
  /// **'Technology / department *'**
  String get fieldDepartment;

  /// No description provided for @polyDpi.
  ///
  /// In en, this message translates to:
  /// **'Dhaka Polytechnic Institute (DPI)'**
  String get polyDpi;

  /// No description provided for @polyCpi.
  ///
  /// In en, this message translates to:
  /// **'Chittagong Polytechnic (CPI)'**
  String get polyCpi;

  /// No description provided for @polyRpi.
  ///
  /// In en, this message translates to:
  /// **'Rajshahi Polytechnic (RPI)'**
  String get polyRpi;

  /// No description provided for @polyBpi.
  ///
  /// In en, this message translates to:
  /// **'Bogura Polytechnic (BPI)'**
  String get polyBpi;

  /// No description provided for @polySpi.
  ///
  /// In en, this message translates to:
  /// **'Sylhet Polytechnic (SPI)'**
  String get polySpi;

  /// No description provided for @polyFci.
  ///
  /// In en, this message translates to:
  /// **'Feni Computer Institute (FCI)'**
  String get polyFci;

  /// No description provided for @polyOther.
  ///
  /// In en, this message translates to:
  /// **'Other private polytechnics'**
  String get polyOther;

  /// No description provided for @fieldCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Company / organization name *'**
  String get fieldCompanyName;

  /// No description provided for @fieldIndustry.
  ///
  /// In en, this message translates to:
  /// **'Industry type *'**
  String get fieldIndustry;

  /// No description provided for @fieldWebsite.
  ///
  /// In en, this message translates to:
  /// **'Official website URL'**
  String get fieldWebsite;

  /// No description provided for @industryIt.
  ///
  /// In en, this message translates to:
  /// **'Software & IT Solutions'**
  String get industryIt;

  /// No description provided for @industryConstruction.
  ///
  /// In en, this message translates to:
  /// **'Construction & Real Estate'**
  String get industryConstruction;

  /// No description provided for @industryManufacturing.
  ///
  /// In en, this message translates to:
  /// **'Manufacturing & Electronics'**
  String get industryManufacturing;

  /// No description provided for @industryPower.
  ///
  /// In en, this message translates to:
  /// **'Power & Energy'**
  String get industryPower;

  /// No description provided for @industryTextile.
  ///
  /// In en, this message translates to:
  /// **'Textile & Garments'**
  String get industryTextile;

  /// No description provided for @companyRoleLabel.
  ///
  /// In en, this message translates to:
  /// **'Official recruiter'**
  String get companyRoleLabel;

  /// No description provided for @pwdHintLength.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters'**
  String get pwdHintLength;

  /// No description provided for @pwdWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak password'**
  String get pwdWeak;

  /// No description provided for @pwdMedium.
  ///
  /// In en, this message translates to:
  /// **'Fair password'**
  String get pwdMedium;

  /// No description provided for @pwdStrong.
  ///
  /// In en, this message translates to:
  /// **'Very strong password!'**
  String get pwdStrong;

  /// No description provided for @socialDivider.
  ///
  /// In en, this message translates to:
  /// **'or continue with a social account'**
  String get socialDivider;

  /// No description provided for @googleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Easily sign in with Google'**
  String get googleSignIn;

  /// No description provided for @googleVerifying.
  ///
  /// In en, this message translates to:
  /// **'Verifying with your Google account...'**
  String get googleVerifying;

  /// No description provided for @googleSuccess.
  ///
  /// In en, this message translates to:
  /// **'Signed in with Google successfully!'**
  String get googleSuccess;

  /// No description provided for @errRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get errRequired;

  /// No description provided for @errInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get errInvalidEmail;

  /// No description provided for @errPasswordShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get errPasswordShort;

  /// No description provided for @errPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get errPasswordMismatch;

  /// No description provided for @errInvalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid website URL (https://...)'**
  String get errInvalidUrl;

  /// No description provided for @errPolytechnicRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select your polytechnic institute'**
  String get errPolytechnicRequired;

  /// No description provided for @loginStudentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Signed in! Welcome to the student dashboard.'**
  String get loginStudentSuccess;

  /// No description provided for @loginCompanySuccess.
  ///
  /// In en, this message translates to:
  /// **'Signed in! Welcome to the company dashboard.'**
  String get loginCompanySuccess;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get registerSuccess;

  /// No description provided for @authFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t sign you in. Please try again.'**
  String get authFailed;

  /// No description provided for @loggedOut.
  ///
  /// In en, this message translates to:
  /// **'You have been signed out.'**
  String get loggedOut;

  /// No description provided for @forgotTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get forgotTitle;

  /// No description provided for @forgotMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email and we\'ll send you a reset link.'**
  String get forgotMessage;

  /// No description provided for @forgotEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email...'**
  String get forgotEmailHint;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @sendLink.
  ///
  /// In en, this message translates to:
  /// **'Send link'**
  String get sendLink;

  /// No description provided for @resetSent.
  ///
  /// In en, this message translates to:
  /// **'Reset link sent to your email!'**
  String get resetSent;

  /// No description provided for @navLogin.
  ///
  /// In en, this message translates to:
  /// **'Login / Sign up'**
  String get navLogin;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'My dashboard'**
  String get navDashboard;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;
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
