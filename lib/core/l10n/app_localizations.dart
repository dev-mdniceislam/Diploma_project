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
  /// **'Career Orbit'**
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
  /// **'Deadline: {value}'**
  String deadlineLabel(String value);

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
  /// **'Retry'**
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
  /// **'Bridging BTEB polytechnic students and factories.'**
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

  /// No description provided for @stepForgot.
  ///
  /// In en, this message translates to:
  /// **'================================== Forgot Password ========================'**
  String get stepForgot;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email and we\'ll send you a reset link.'**
  String get resetPasswordDesc;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email...'**
  String get emailHint;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a password reset link to {email}. Please check your inbox.'**
  String resetLinkSent(String email);

  /// No description provided for @setNewPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Set new password'**
  String get setNewPasswordTitle;

  /// No description provided for @setNewPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose a new password for your account.'**
  String get setNewPasswordDesc;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordButton;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your password has been reset successfully. You can now sign in.'**
  String get passwordResetSuccess;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get backToLogin;

  /// No description provided for @otpLabel.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get otpLabel;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code we sent to your email.'**
  String get otpSubtitle;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyOtp;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendOtp;

  /// No description provided for @errInvalidOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code'**
  String get errInvalidOtp;

  /// No description provided for @passwordResetSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Password updated!'**
  String get passwordResetSuccessTitle;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendCode;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code we sent to {email}.'**
  String otpSentTo(String email);

  /// No description provided for @stepProfile.
  ///
  /// In en, this message translates to:
  /// **'================================== Student Profile ========================'**
  String get stepProfile;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @nocGuide.
  ///
  /// In en, this message translates to:
  /// **'NOC Guide'**
  String get nocGuide;

  /// No description provided for @updateCv.
  ///
  /// In en, this message translates to:
  /// **'Update CV'**
  String get updateCv;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @changeCover.
  ///
  /// In en, this message translates to:
  /// **'Change banner'**
  String get changeCover;

  /// No description provided for @verifiedStudent.
  ///
  /// In en, this message translates to:
  /// **'Verified student'**
  String get verifiedStudent;

  /// No description provided for @downloadResume.
  ///
  /// In en, this message translates to:
  /// **'Download resume'**
  String get downloadResume;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @copyPublicLink.
  ///
  /// In en, this message translates to:
  /// **'Copy public link'**
  String get copyPublicLink;

  /// No description provided for @linkCopied.
  ///
  /// In en, this message translates to:
  /// **'Profile link copied to clipboard!'**
  String get linkCopied;

  /// No description provided for @cvNotUploaded.
  ///
  /// In en, this message translates to:
  /// **'No CV link has been added yet'**
  String get cvNotUploaded;

  /// No description provided for @linkOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to open the link'**
  String get linkOpenFailed;

  /// No description provided for @instituteRoll.
  ///
  /// In en, this message translates to:
  /// **'{institute} • Roll: {roll}'**
  String instituteRoll(String institute, String roll);

  /// No description provided for @semesterLabel.
  ///
  /// In en, this message translates to:
  /// **'{ordinal} Semester'**
  String semesterLabel(String ordinal);

  /// No description provided for @ordinal.
  ///
  /// In en, this message translates to:
  /// **'{n, select, 1{1st} 2{2nd} 3{3rd} 4{4th} 5{5th} 6{6th} 7{7th} 8{8th} other{{n}th}}'**
  String ordinal(String n);

  /// No description provided for @metricCurrentStatus.
  ///
  /// In en, this message translates to:
  /// **'Current status'**
  String get metricCurrentStatus;

  /// No description provided for @metricStatusValue.
  ///
  /// In en, this message translates to:
  /// **'{semester} (Attachment)'**
  String metricStatusValue(String semester);

  /// No description provided for @metricCgpa.
  ///
  /// In en, this message translates to:
  /// **'CGPA (average)'**
  String get metricCgpa;

  /// No description provided for @metricApplied.
  ///
  /// In en, this message translates to:
  /// **'Applied jobs / internships'**
  String get metricApplied;

  /// No description provided for @circularsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No circulars} =1{1 circular} other{{count} circulars}}'**
  String circularsCount(int count);

  /// No description provided for @metricNoc.
  ///
  /// In en, this message translates to:
  /// **'NOC status'**
  String get metricNoc;

  /// No description provided for @nocIssued.
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get nocIssued;

  /// No description provided for @nocPending.
  ///
  /// In en, this message translates to:
  /// **'In process'**
  String get nocPending;

  /// No description provided for @nocRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get nocRejected;

  /// No description provided for @tabOverview.
  ///
  /// In en, this message translates to:
  /// **'About & Benefits'**
  String get tabOverview;

  /// No description provided for @tabAcademic.
  ///
  /// In en, this message translates to:
  /// **'Academic'**
  String get tabAcademic;

  /// No description provided for @tabProjects.
  ///
  /// In en, this message translates to:
  /// **'Skills & projects'**
  String get tabProjects;

  /// No description provided for @tabApplications.
  ///
  /// In en, this message translates to:
  /// **'Application tracker'**
  String get tabApplications;

  /// No description provided for @tabCertifications.
  ///
  /// In en, this message translates to:
  /// **'Certificates & social'**
  String get tabCertifications;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About me (Bio)'**
  String get aboutMe;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @techProficiency.
  ///
  /// In en, this message translates to:
  /// **'Technical proficiency'**
  String get techProficiency;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact information'**
  String get contactInfo;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @currentAddress.
  ///
  /// In en, this message translates to:
  /// **'Current address'**
  String get currentAddress;

  /// No description provided for @boardInfo.
  ///
  /// In en, this message translates to:
  /// **'Technical education board'**
  String get boardInfo;

  /// No description provided for @boardRoll.
  ///
  /// In en, this message translates to:
  /// **'Board roll:'**
  String get boardRoll;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration:'**
  String get registration;

  /// No description provided for @session.
  ///
  /// In en, this message translates to:
  /// **'Session:'**
  String get session;

  /// No description provided for @nocLetterNo.
  ///
  /// In en, this message translates to:
  /// **'NOC letter no:'**
  String get nocLetterNo;

  /// No description provided for @resultBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Polytechnic result breakdown (Semester GPA)'**
  String get resultBreakdown;

  /// No description provided for @colSemester.
  ///
  /// In en, this message translates to:
  /// **'Semester'**
  String get colSemester;

  /// No description provided for @colExamYear.
  ///
  /// In en, this message translates to:
  /// **'Exam year'**
  String get colExamYear;

  /// No description provided for @colGpa.
  ///
  /// In en, this message translates to:
  /// **'GPA'**
  String get colGpa;

  /// No description provided for @colStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get colStatus;

  /// No description provided for @passed.
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get passed;

  /// No description provided for @avgCgpaRange.
  ///
  /// In en, this message translates to:
  /// **'Average CGPA ({from} – {to})'**
  String avgCgpaRange(String from, String to);

  /// No description provided for @gradeFirstClass.
  ///
  /// In en, this message translates to:
  /// **'First class honors equivalent'**
  String get gradeFirstClass;

  /// No description provided for @sscTitle.
  ///
  /// In en, this message translates to:
  /// **'Secondary School Certificate (SSC / equivalent)'**
  String get sscTitle;

  /// No description provided for @schoolName.
  ///
  /// In en, this message translates to:
  /// **'School name:'**
  String get schoolName;

  /// No description provided for @groupBoard.
  ///
  /// In en, this message translates to:
  /// **'Group & board:'**
  String get groupBoard;

  /// No description provided for @passingYearGpa.
  ///
  /// In en, this message translates to:
  /// **'Passing year & GPA:'**
  String get passingYearGpa;

  /// No description provided for @portfolioTitle.
  ///
  /// In en, this message translates to:
  /// **'Practical project portfolio'**
  String get portfolioTitle;

  /// No description provided for @portfolioSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Projects built in class and on your own'**
  String get portfolioSubtitle;

  /// No description provided for @addProject.
  ///
  /// In en, this message translates to:
  /// **'Add new project'**
  String get addProject;

  /// No description provided for @newProject.
  ///
  /// In en, this message translates to:
  /// **'New project'**
  String get newProject;

  /// No description provided for @liveDemo.
  ///
  /// In en, this message translates to:
  /// **'Live demo'**
  String get liveDemo;

  /// No description provided for @githubCode.
  ///
  /// In en, this message translates to:
  /// **'GitHub code'**
  String get githubCode;

  /// No description provided for @trackerTitle.
  ///
  /// In en, this message translates to:
  /// **'Applied circulars & internship tracker'**
  String get trackerTitle;

  /// No description provided for @trackerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Real-time status of all your submitted applications'**
  String get trackerSubtitle;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter:'**
  String get filter;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All applications'**
  String get filterAll;

  /// No description provided for @filterShortlisted.
  ///
  /// In en, this message translates to:
  /// **'Shortlisted'**
  String get filterShortlisted;

  /// No description provided for @filterPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get filterPending;

  /// No description provided for @filterInterview.
  ///
  /// In en, this message translates to:
  /// **'Interview scheduled'**
  String get filterInterview;

  /// No description provided for @noApplications.
  ///
  /// In en, this message translates to:
  /// **'No applications found'**
  String get noApplications;

  /// No description provided for @colCompany.
  ///
  /// In en, this message translates to:
  /// **'Company & position'**
  String get colCompany;

  /// No description provided for @colType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get colType;

  /// No description provided for @colAppliedDate.
  ///
  /// In en, this message translates to:
  /// **'Applied on'**
  String get colAppliedDate;

  /// No description provided for @colCurrentStatus.
  ///
  /// In en, this message translates to:
  /// **'Current status'**
  String get colCurrentStatus;

  /// No description provided for @colAction.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get colAction;

  /// No description provided for @typeAttachment.
  ///
  /// In en, this message translates to:
  /// **'8th Semester Attachment'**
  String get typeAttachment;

  /// No description provided for @typeJob.
  ///
  /// In en, this message translates to:
  /// **'Full-time job'**
  String get typeJob;

  /// No description provided for @statusShortlisted.
  ///
  /// In en, this message translates to:
  /// **'Shortlisted'**
  String get statusShortlisted;

  /// No description provided for @statusInterview.
  ///
  /// In en, this message translates to:
  /// **'Interview scheduled'**
  String get statusInterview;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Review pending'**
  String get statusPending;

  /// No description provided for @actionViewMessage.
  ///
  /// In en, this message translates to:
  /// **'View message'**
  String get actionViewMessage;

  /// No description provided for @actionDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get actionDetails;

  /// No description provided for @actionPleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait'**
  String get actionPleaseWait;

  /// No description provided for @noMessage.
  ///
  /// In en, this message translates to:
  /// **'No message yet'**
  String get noMessage;

  /// No description provided for @certificatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Training & course certificates'**
  String get certificatesTitle;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @socialTitle.
  ///
  /// In en, this message translates to:
  /// **'Social media & online portfolio links'**
  String get socialTitle;

  /// No description provided for @linkedinProfile.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn Profile'**
  String get linkedinProfile;

  /// No description provided for @githubRepos.
  ///
  /// In en, this message translates to:
  /// **'GitHub Repositories'**
  String get githubRepos;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit student profile'**
  String get editProfileTitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Student\'s full name'**
  String get fullName;

  /// No description provided for @polytechnicName.
  ///
  /// In en, this message translates to:
  /// **'Polytechnic name'**
  String get polytechnicName;

  /// No description provided for @technology.
  ///
  /// In en, this message translates to:
  /// **'Technology'**
  String get technology;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @bioLabel.
  ///
  /// In en, this message translates to:
  /// **'Short bio'**
  String get bioLabel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @invalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid link'**
  String get invalidUrl;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdated;

  /// No description provided for @cvDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Google Drive resume / CV link'**
  String get cvDialogTitle;

  /// No description provided for @cvLinkLabel.
  ///
  /// In en, this message translates to:
  /// **'Google Drive CV link'**
  String get cvLinkLabel;

  /// No description provided for @cvLinkNote.
  ///
  /// In en, this message translates to:
  /// **'Turn on \'Anyone with the link\' view permission.'**
  String get cvLinkNote;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @cvUpdated.
  ///
  /// In en, this message translates to:
  /// **'Your Google Drive CV link has been updated!'**
  String get cvUpdated;

  /// No description provided for @addProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a new project'**
  String get addProjectTitle;

  /// No description provided for @projectName.
  ///
  /// In en, this message translates to:
  /// **'Project name'**
  String get projectName;

  /// No description provided for @projectTech.
  ///
  /// In en, this message translates to:
  /// **'Technologies used (comma separated)'**
  String get projectTech;

  /// No description provided for @projectTechHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. HTML, Tailwind, JS'**
  String get projectTechHint;

  /// No description provided for @projectDesc.
  ///
  /// In en, this message translates to:
  /// **'Short description'**
  String get projectDesc;

  /// No description provided for @publish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish;

  /// No description provided for @projectAdded.
  ///
  /// In en, this message translates to:
  /// **'Project added to your portfolio!'**
  String get projectAdded;

  /// No description provided for @nocGuideTitle.
  ///
  /// In en, this message translates to:
  /// **'NOC guideline'**
  String get nocGuideTitle;

  /// No description provided for @nocGuideBody.
  ///
  /// In en, this message translates to:
  /// **'Attach the NOC letter approved by your polytechnic\'s industrial liaison office when you apply.'**
  String get nocGuideBody;

  /// No description provided for @nocVerifiedActive.
  ///
  /// In en, this message translates to:
  /// **'NOC No: {number} (Verified Active)'**
  String nocVerifiedActive(String number);

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWentWrong;

  /// No description provided for @stepJobDetails.
  ///
  /// In en, this message translates to:
  /// **'================================== Job details ========================'**
  String get stepJobDetails;

  /// No description provided for @appliedBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'You have successfully applied to this circular!'**
  String get appliedBannerTitle;

  /// No description provided for @appliedBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Applied on: {date} | Status: {status}'**
  String appliedBannerSubtitle(String date, String status);

  /// No description provided for @applicationDetails.
  ///
  /// In en, this message translates to:
  /// **'Application details'**
  String get applicationDetails;

  /// No description provided for @typeSemesterAttachment.
  ///
  /// In en, this message translates to:
  /// **'🎓 {semester} attachment'**
  String typeSemesterAttachment(String semester);

  /// No description provided for @typeFullTimeJob.
  ///
  /// In en, this message translates to:
  /// **'💼 Full-time job'**
  String get typeFullTimeJob;

  /// No description provided for @verifiedEmployer.
  ///
  /// In en, this message translates to:
  /// **'Verified employer'**
  String get verifiedEmployer;

  /// No description provided for @technologyLabel.
  ///
  /// In en, this message translates to:
  /// **'Technology: {value}'**
  String technologyLabel(String value);

  /// No description provided for @applied.
  ///
  /// In en, this message translates to:
  /// **'Application submitted'**
  String get applied;

  /// No description provided for @bookmarkTooltip.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get bookmarkTooltip;

  /// No description provided for @shareTooltip.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareTooltip;

  /// No description provided for @hlLocation.
  ///
  /// In en, this message translates to:
  /// **'Work location'**
  String get hlLocation;

  /// No description provided for @hlStipend.
  ///
  /// In en, this message translates to:
  /// **'Monthly stipend'**
  String get hlStipend;

  /// No description provided for @hlExperience.
  ///
  /// In en, this message translates to:
  /// **'Experience / semester'**
  String get hlExperience;

  /// No description provided for @hlDeadline.
  ///
  /// In en, this message translates to:
  /// **'Application deadline'**
  String get hlDeadline;

  /// No description provided for @hlVacancies.
  ///
  /// In en, this message translates to:
  /// **'Vacancies'**
  String get hlVacancies;

  /// No description provided for @stipendPerMonth.
  ///
  /// In en, this message translates to:
  /// **'৳ {amount} / month'**
  String stipendPerMonth(int amount);

  /// No description provided for @vacanciesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 seat} other{{count} seats}}'**
  String vacanciesCount(int count);

  /// No description provided for @roleOverview.
  ///
  /// In en, this message translates to:
  /// **'Role overview'**
  String get roleOverview;

  /// No description provided for @keyResponsibilities.
  ///
  /// In en, this message translates to:
  /// **'Key responsibilities'**
  String get keyResponsibilities;

  /// No description provided for @requirementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Education & technology requirements'**
  String get requirementsTitle;

  /// No description provided for @benefitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Benefits for interns & new hires'**
  String get benefitsTitle;

  /// No description provided for @requiredDocsTitle.
  ///
  /// In en, this message translates to:
  /// **'Documents required to apply'**
  String get requiredDocsTitle;

  /// No description provided for @summaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Circular summary'**
  String get summaryTitle;

  /// No description provided for @sumPublished.
  ///
  /// In en, this message translates to:
  /// **'Published on:'**
  String get sumPublished;

  /// No description provided for @sumDeadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline:'**
  String get sumDeadline;

  /// No description provided for @sumJobType.
  ///
  /// In en, this message translates to:
  /// **'Job type:'**
  String get sumJobType;

  /// No description provided for @sumEducation.
  ///
  /// In en, this message translates to:
  /// **'Education:'**
  String get sumEducation;

  /// No description provided for @sumHousing.
  ///
  /// In en, this message translates to:
  /// **'Housing:'**
  String get sumHousing;

  /// No description provided for @applyOnline.
  ///
  /// In en, this message translates to:
  /// **'Apply online now'**
  String get applyOnline;

  /// No description provided for @hrTitle.
  ///
  /// In en, this message translates to:
  /// **'HR desk & contact'**
  String get hrTitle;

  /// No description provided for @hrEmail.
  ///
  /// In en, this message translates to:
  /// **'Official HR email'**
  String get hrEmail;

  /// No description provided for @hrHelpline.
  ///
  /// In en, this message translates to:
  /// **'Helpline (9am–5pm)'**
  String get hrHelpline;

  /// No description provided for @hrWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get hrWebsite;

  /// No description provided for @relatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Related circulars'**
  String get relatedTitle;

  /// No description provided for @applyDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Apply directly to this circular'**
  String get applyDialogTitle;

  /// No description provided for @cvUploadLabel.
  ///
  /// In en, this message translates to:
  /// **'Your updated CV (PDF) *'**
  String get cvUploadLabel;

  /// No description provided for @dropOrBrowse.
  ///
  /// In en, this message translates to:
  /// **'Drop a file or'**
  String get dropOrBrowse;

  /// No description provided for @browse.
  ///
  /// In en, this message translates to:
  /// **'browse'**
  String get browse;

  /// No description provided for @maxFileSize.
  ///
  /// In en, this message translates to:
  /// **'Max file size: 5 MB (PDF)'**
  String get maxFileSize;

  /// No description provided for @removeFile.
  ///
  /// In en, this message translates to:
  /// **'Remove file'**
  String get removeFile;

  /// No description provided for @nocUploadLabel.
  ///
  /// In en, this message translates to:
  /// **'Polytechnic NOC attachment (optional)'**
  String get nocUploadLabel;

  /// No description provided for @expectedStipend.
  ///
  /// In en, this message translates to:
  /// **'Expected stipend'**
  String get expectedStipend;

  /// No description provided for @companyDecided.
  ///
  /// In en, this message translates to:
  /// **'(set by company)'**
  String get companyDecided;

  /// No description provided for @currentSemester.
  ///
  /// In en, this message translates to:
  /// **'Current semester *'**
  String get currentSemester;

  /// No description provided for @coverNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Short note to the HR desk (cover note)'**
  String get coverNoteLabel;

  /// No description provided for @coverNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Why you are a good fit and a bit about your technical projects…'**
  String get coverNoteHint;

  /// No description provided for @confirmApplication.
  ///
  /// In en, this message translates to:
  /// **'Confirm application'**
  String get confirmApplication;

  /// No description provided for @cvRequired.
  ///
  /// In en, this message translates to:
  /// **'Please attach your CV (PDF)'**
  String get cvRequired;

  /// No description provided for @fileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'File is larger than 5 MB'**
  String get fileTooLarge;

  /// No description provided for @applicantNameRoll.
  ///
  /// In en, this message translates to:
  /// **'{name} (Roll: {roll})'**
  String applicantNameRoll(String name, String roll);

  /// No description provided for @applicationSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Your application was submitted to the {company} HR desk!'**
  String applicationSubmitted(String company);

  /// No description provided for @alreadyApplied.
  ///
  /// In en, this message translates to:
  /// **'You have already applied!'**
  String get alreadyApplied;

  /// No description provided for @bookmarkSaved.
  ///
  /// In en, this message translates to:
  /// **'Circular saved to your bookmarks'**
  String get bookmarkSaved;

  /// No description provided for @bookmarkRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed from your bookmarks'**
  String get bookmarkRemoved;

  /// No description provided for @circularLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Circular link copied!'**
  String get circularLinkCopied;

  /// No description provided for @stepCompanyProfile.
  ///
  /// In en, this message translates to:
  /// **'================================== Profile ========================'**
  String get stepCompanyProfile;

  /// No description provided for @recruiterPortalTagline.
  ///
  /// In en, this message translates to:
  /// **'Recruiter Portal & Company Desk'**
  String get recruiterPortalTagline;

  /// No description provided for @navPostings.
  ///
  /// In en, this message translates to:
  /// **'Jobs & Internships'**
  String get navPostings;

  /// No description provided for @navApplicants.
  ///
  /// In en, this message translates to:
  /// **'Applicants'**
  String get navApplicants;

  /// No description provided for @navCompanyPanel.
  ///
  /// In en, this message translates to:
  /// **'Company Panel'**
  String get navCompanyPanel;

  /// No description provided for @btebPartner.
  ///
  /// In en, this message translates to:
  /// **'BTEB Industry Partner'**
  String get btebPartner;

  /// No description provided for @newPost.
  ///
  /// In en, this message translates to:
  /// **'Post New'**
  String get newPost;

  /// No description provided for @shareProfile.
  ///
  /// In en, this message translates to:
  /// **'Share profile'**
  String get shareProfile;

  /// No description provided for @changeLogo.
  ///
  /// In en, this message translates to:
  /// **'Change logo'**
  String get changeLogo;

  /// No description provided for @toggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle theme'**
  String get toggleTheme;

  /// No description provided for @languageToggleLabel.
  ///
  /// In en, this message translates to:
  /// **'বাংলা'**
  String get languageToggleLabel;

  /// No description provided for @verifiedRecruiter.
  ///
  /// In en, this message translates to:
  /// **'Verified Recruiter'**
  String get verifiedRecruiter;

  /// No description provided for @btebApprovedIndustry.
  ///
  /// In en, this message translates to:
  /// **'BTEB Approved Industry'**
  String get btebApprovedIndustry;

  /// No description provided for @employeesCount.
  ///
  /// In en, this message translates to:
  /// **'{count}+ employees'**
  String employeesCount(String count);

  /// No description provided for @statTotalPostings.
  ///
  /// In en, this message translates to:
  /// **'Total circulars posted'**
  String get statTotalPostings;

  /// No description provided for @statJobs.
  ///
  /// In en, this message translates to:
  /// **'Job circulars'**
  String get statJobs;

  /// No description provided for @statAttachments.
  ///
  /// In en, this message translates to:
  /// **'Industrial attachments'**
  String get statAttachments;

  /// No description provided for @statApplications.
  ///
  /// In en, this message translates to:
  /// **'Applications received'**
  String get statApplications;

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count}'**
  String itemsCount(String count);

  /// No description provided for @tabPostings.
  ///
  /// In en, this message translates to:
  /// **'Circulars & Internship Management'**
  String get tabPostings;

  /// No description provided for @tabApplicants.
  ///
  /// In en, this message translates to:
  /// **'Applicants & Evaluation'**
  String get tabApplicants;

  /// No description provided for @tabMou.
  ///
  /// In en, this message translates to:
  /// **'Polytechnic Partnerships & MOU'**
  String get tabMou;

  /// No description provided for @filterType.
  ///
  /// In en, this message translates to:
  /// **'Filter type:'**
  String get filterType;

  /// No description provided for @filterAllPosts.
  ///
  /// In en, this message translates to:
  /// **'All posts ({count})'**
  String filterAllPosts(String count);

  /// No description provided for @filterJobs.
  ///
  /// In en, this message translates to:
  /// **'Full-time jobs ({count})'**
  String filterJobs(String count);

  /// No description provided for @filterAttachments.
  ///
  /// In en, this message translates to:
  /// **'8th-semester attachments ({count})'**
  String filterAttachments(String count);

  /// No description provided for @seatsLabel.
  ///
  /// In en, this message translates to:
  /// **'Seats: {count}'**
  String seatsLabel(String count);

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location: {value}'**
  String locationLabel(String value);

  /// No description provided for @salaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Salary: {value}'**
  String salaryLabel(String value);

  /// No description provided for @stipendLabel.
  ///
  /// In en, this message translates to:
  /// **'Stipend: {value}'**
  String stipendLabel(String value);

  /// No description provided for @viewApplications.
  ///
  /// In en, this message translates to:
  /// **'View applications ({count})'**
  String viewApplications(String count);

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// No description provided for @emptyPostings.
  ///
  /// In en, this message translates to:
  /// **'No circulars posted yet.'**
  String get emptyPostings;

  /// No description provided for @emptyApplicants.
  ///
  /// In en, this message translates to:
  /// **'No applicants found.'**
  String get emptyApplicants;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get genericError;

  /// No description provided for @postDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Post a new circular / internship'**
  String get postDialogTitle;

  /// No description provided for @postDialogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Provide details for a job or an 8th-semester industrial attachment'**
  String get postDialogSubtitle;

  /// No description provided for @postCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Select post category *'**
  String get postCategoryLabel;

  /// No description provided for @categoryAttachmentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Internship for polytechnic students'**
  String get categoryAttachmentSubtitle;

  /// No description provided for @categoryJobTitle.
  ///
  /// In en, this message translates to:
  /// **'Full-time / Part-time job'**
  String get categoryJobTitle;

  /// No description provided for @categoryJobSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hiring diploma graduates'**
  String get categoryJobSubtitle;

  /// No description provided for @postTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Position title *'**
  String get postTitleLabel;

  /// No description provided for @postTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Sub-Assistant Engineer (PLC & Automation)'**
  String get postTitleHint;

  /// No description provided for @postTechLabel.
  ///
  /// In en, this message translates to:
  /// **'Applicable technology / department *'**
  String get postTechLabel;

  /// No description provided for @postTechHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Computer, Electrical, Mechanical'**
  String get postTechHint;

  /// No description provided for @postSeatsLabel.
  ///
  /// In en, this message translates to:
  /// **'Vacancies (Seats) *'**
  String get postSeatsLabel;

  /// No description provided for @postSeatsHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 20'**
  String get postSeatsHint;

  /// No description provided for @postSalaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Salary / stipend *'**
  String get postSalaryLabel;

  /// No description provided for @postSalaryHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. ৳10,000/month (or negotiable)'**
  String get postSalaryHint;

  /// No description provided for @postDeadlineLabel.
  ///
  /// In en, this message translates to:
  /// **'Application deadline *'**
  String get postDeadlineLabel;

  /// No description provided for @postLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Work location / factory *'**
  String get postLocationLabel;

  /// No description provided for @postLocationHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Chandra, Gazipur plant'**
  String get postLocationHint;

  /// No description provided for @postBenefitsLabel.
  ///
  /// In en, this message translates to:
  /// **'Extra benefits & conditions'**
  String get postBenefitsLabel;

  /// No description provided for @benefitFreeHousing.
  ///
  /// In en, this message translates to:
  /// **'Free housing'**
  String get benefitFreeHousing;

  /// No description provided for @benefitCanteen.
  ///
  /// In en, this message translates to:
  /// **'Cafeteria subsidy'**
  String get benefitCanteen;

  /// No description provided for @benefitNocRequired.
  ///
  /// In en, this message translates to:
  /// **'Polytechnic NOC required'**
  String get benefitNocRequired;

  /// No description provided for @tagNocApplicable.
  ///
  /// In en, this message translates to:
  /// **'NOC applicable'**
  String get tagNocApplicable;

  /// No description provided for @publishToPortal.
  ///
  /// In en, this message translates to:
  /// **'Publish to portal'**
  String get publishToPortal;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get invalidNumber;

  /// No description provided for @editCompanyTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit company details'**
  String get editCompanyTitle;

  /// No description provided for @companyNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Company name *'**
  String get companyNameLabel;

  /// No description provided for @industryLabel.
  ///
  /// In en, this message translates to:
  /// **'Industry category *'**
  String get industryLabel;

  /// No description provided for @hrEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'HR email *'**
  String get hrEmailLabel;

  /// No description provided for @helplineLabel.
  ///
  /// In en, this message translates to:
  /// **'Helpline number *'**
  String get helplineLabel;

  /// No description provided for @aboutSummaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Company overview (About)'**
  String get aboutSummaryLabel;

  /// No description provided for @interviewDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule interview'**
  String get interviewDialogTitle;

  /// No description provided for @interviewCandidate.
  ///
  /// In en, this message translates to:
  /// **'Candidate: {name}'**
  String interviewCandidate(String name);

  /// No description provided for @interviewDateTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Interview date & time *'**
  String get interviewDateTimeLabel;

  /// No description provided for @interviewVenueLabel.
  ///
  /// In en, this message translates to:
  /// **'Venue / online meeting link *'**
  String get interviewVenueLabel;

  /// No description provided for @interviewVenueHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Walton Plant HQ Boardroom or Google Meet link'**
  String get interviewVenueHint;

  /// No description provided for @sendNotification.
  ///
  /// In en, this message translates to:
  /// **'Send notification'**
  String get sendNotification;

  /// No description provided for @applicantsTitle.
  ///
  /// In en, this message translates to:
  /// **'Applicant evaluation list'**
  String get applicantsTitle;

  /// No description provided for @applicantsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Verify CV, technology and NOC status of polytechnic students'**
  String get applicantsSubtitle;

  /// No description provided for @filterAllApplicants.
  ///
  /// In en, this message translates to:
  /// **'All applicants'**
  String get filterAllApplicants;

  /// No description provided for @statusInterviewOn.
  ///
  /// In en, this message translates to:
  /// **'Interview {date}'**
  String statusInterviewOn(String date);

  /// No description provided for @downloadCvs.
  ///
  /// In en, this message translates to:
  /// **'Download CVs'**
  String get downloadCvs;

  /// No description provided for @colStudent.
  ///
  /// In en, this message translates to:
  /// **'Student & polytechnic'**
  String get colStudent;

  /// No description provided for @colTechCgpa.
  ///
  /// In en, this message translates to:
  /// **'Technology & CGPA'**
  String get colTechCgpa;

  /// No description provided for @colPosition.
  ///
  /// In en, this message translates to:
  /// **'Applied position'**
  String get colPosition;

  /// No description provided for @colDocuments.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get colDocuments;

  /// No description provided for @cgpaLabel.
  ///
  /// In en, this message translates to:
  /// **'CGPA: {value}'**
  String cgpaLabel(String value);

  /// No description provided for @nocAttached.
  ///
  /// In en, this message translates to:
  /// **'NOC attached'**
  String get nocAttached;

  /// No description provided for @actionShortlist.
  ///
  /// In en, this message translates to:
  /// **'Shortlist'**
  String get actionShortlist;

  /// No description provided for @actionScheduleInterview.
  ///
  /// In en, this message translates to:
  /// **'Schedule interview'**
  String get actionScheduleInterview;

  /// No description provided for @actionDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get actionDone;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About & mission'**
  String get aboutTitle;

  /// No description provided for @domainsTitle.
  ///
  /// In en, this message translates to:
  /// **'Key engineering & technology areas'**
  String get domainsTitle;

  /// No description provided for @hrDeskTitle.
  ///
  /// In en, this message translates to:
  /// **'HR desk & contact'**
  String get hrDeskTitle;

  /// No description provided for @hrEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'HR email'**
  String get hrEmailTitle;

  /// No description provided for @helplineTitle.
  ///
  /// In en, this message translates to:
  /// **'Helpline number'**
  String get helplineTitle;

  /// No description provided for @headOfficeTitle.
  ///
  /// In en, this message translates to:
  /// **'Head office & plant'**
  String get headOfficeTitle;

  /// No description provided for @mouTitle.
  ///
  /// In en, this message translates to:
  /// **'Partner polytechnic institutes (Campus partners)'**
  String get mouTitle;

  /// No description provided for @mouSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Institutes with an industrial-attachment agreement'**
  String get mouSubtitle;

  /// No description provided for @newMou.
  ///
  /// In en, this message translates to:
  /// **'+ New MOU'**
  String get newMou;

  /// No description provided for @mouVerified.
  ///
  /// In en, this message translates to:
  /// **'MOU verified'**
  String get mouVerified;

  /// No description provided for @annualQuota.
  ///
  /// In en, this message translates to:
  /// **'Annual intern quota: {count} students'**
  String annualQuota(String count);

  /// No description provided for @toastPostPublished.
  ///
  /// In en, this message translates to:
  /// **'New circular published successfully!'**
  String get toastPostPublished;

  /// No description provided for @toastProfileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Company profile updated!'**
  String get toastProfileUpdated;

  /// No description provided for @toastInterviewSent.
  ///
  /// In en, this message translates to:
  /// **'Interview schedule sent to the student.'**
  String get toastInterviewSent;

  /// No description provided for @toastShortlisted.
  ///
  /// In en, this message translates to:
  /// **'Candidate added to the shortlist!'**
  String get toastShortlisted;

  /// No description provided for @toastLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Company dashboard link copied!'**
  String get toastLinkCopied;

  /// No description provided for @toastExportingCvs.
  ///
  /// In en, this message translates to:
  /// **'Exporting all CVs as a ZIP...'**
  String get toastExportingCvs;

  /// No description provided for @pfNoLink.
  ///
  /// In en, this message translates to:
  /// **'Link not available'**
  String get pfNoLink;

  /// No description provided for @pfLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Profile link copied'**
  String get pfLinkCopied;

  /// No description provided for @pfRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get pfRetry;

  /// No description provided for @pfNoData.
  ///
  /// In en, this message translates to:
  /// **'Nothing to show yet'**
  String get pfNoData;

  /// No description provided for @pfUnknownRole.
  ///
  /// In en, this message translates to:
  /// **'This account type has no profile page.'**
  String get pfUnknownRole;

  /// No description provided for @pfSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get pfSave;

  /// No description provided for @pfCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get pfCancel;

  /// No description provided for @pfComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get pfComingSoon;

  /// No description provided for @pfSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get pfSaved;

  /// No description provided for @pfEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get pfEditProfile;

  /// No description provided for @pfEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get pfEmail;

  /// No description provided for @pfPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get pfPhone;

  /// No description provided for @pfAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get pfAddress;

  /// No description provided for @pfAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get pfAll;

  /// No description provided for @pfShortlisted.
  ///
  /// In en, this message translates to:
  /// **'Shortlisted'**
  String get pfShortlisted;

  /// No description provided for @pfPending.
  ///
  /// In en, this message translates to:
  /// **'Pending review'**
  String get pfPending;

  /// No description provided for @pfInterview.
  ///
  /// In en, this message translates to:
  /// **'Interview scheduled'**
  String get pfInterview;

  /// No description provided for @pfInterviewOn.
  ///
  /// In en, this message translates to:
  /// **'Interview {date}'**
  String pfInterviewOn(String date);

  /// No description provided for @pfTypeJob.
  ///
  /// In en, this message translates to:
  /// **'Full-time job'**
  String get pfTypeJob;

  /// No description provided for @pfTypeAttachment.
  ///
  /// In en, this message translates to:
  /// **'Industrial attachment'**
  String get pfTypeAttachment;

  /// No description provided for @pfStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get pfStatus;

  /// No description provided for @pfUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get pfUpdate;

  /// No description provided for @pfPublish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get pfPublish;

  /// No description provided for @pfStudentVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified student'**
  String get pfStudentVerified;

  /// No description provided for @pfRoll.
  ///
  /// In en, this message translates to:
  /// **'Roll: {roll}'**
  String pfRoll(String roll);

  /// No description provided for @pfDownloadCv.
  ///
  /// In en, this message translates to:
  /// **'Download resume'**
  String get pfDownloadCv;

  /// No description provided for @pfUpdateCv.
  ///
  /// In en, this message translates to:
  /// **'Update CV link'**
  String get pfUpdateCv;

  /// No description provided for @pfStatCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current status'**
  String get pfStatCurrent;

  /// No description provided for @pfStatCgpa.
  ///
  /// In en, this message translates to:
  /// **'CGPA (average)'**
  String get pfStatCgpa;

  /// No description provided for @pfStatApplied.
  ///
  /// In en, this message translates to:
  /// **'Applied jobs / internships'**
  String get pfStatApplied;

  /// No description provided for @pfStatAppliedValue.
  ///
  /// In en, this message translates to:
  /// **'{count} circulars'**
  String pfStatAppliedValue(String count);

  /// No description provided for @pfStatNoc.
  ///
  /// In en, this message translates to:
  /// **'NOC status'**
  String get pfStatNoc;

  /// No description provided for @pfNocIssued.
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get pfNocIssued;

  /// No description provided for @pfNocPending.
  ///
  /// In en, this message translates to:
  /// **'Not issued'**
  String get pfNocPending;

  /// No description provided for @pfTabOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get pfTabOverview;

  /// No description provided for @pfTabAcademic.
  ///
  /// In en, this message translates to:
  /// **'Academics'**
  String get pfTabAcademic;

  /// No description provided for @pfTabProjects.
  ///
  /// In en, this message translates to:
  /// **'Skills & projects'**
  String get pfTabProjects;

  /// No description provided for @pfTabApplications.
  ///
  /// In en, this message translates to:
  /// **'Applications'**
  String get pfTabApplications;

  /// No description provided for @pfTabCertificates.
  ///
  /// In en, this message translates to:
  /// **'Certificates & social'**
  String get pfTabCertificates;

  /// No description provided for @pfAboutMe.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get pfAboutMe;

  /// No description provided for @pfSkills.
  ///
  /// In en, this message translates to:
  /// **'Technical proficiency'**
  String get pfSkills;

  /// No description provided for @pfContactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact information'**
  String get pfContactInfo;

  /// No description provided for @pfBoardInfo.
  ///
  /// In en, this message translates to:
  /// **'Technical board info'**
  String get pfBoardInfo;

  /// No description provided for @pfBoardRoll.
  ///
  /// In en, this message translates to:
  /// **'Board roll'**
  String get pfBoardRoll;

  /// No description provided for @pfRegistration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get pfRegistration;

  /// No description provided for @pfSession.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get pfSession;

  /// No description provided for @pfNocNumber.
  ///
  /// In en, this message translates to:
  /// **'NOC letter no.'**
  String get pfNocNumber;

  /// No description provided for @pfResultBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Polytechnic result breakdown (semester GPA)'**
  String get pfResultBreakdown;

  /// No description provided for @pfSemester.
  ///
  /// In en, this message translates to:
  /// **'Semester'**
  String get pfSemester;

  /// No description provided for @pfSemesterN.
  ///
  /// In en, this message translates to:
  /// **'Semester {n}'**
  String pfSemesterN(String n);

  /// No description provided for @pfExamYear.
  ///
  /// In en, this message translates to:
  /// **'Exam year'**
  String get pfExamYear;

  /// No description provided for @pfGpa.
  ///
  /// In en, this message translates to:
  /// **'GPA'**
  String get pfGpa;

  /// No description provided for @pfPassed.
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get pfPassed;

  /// No description provided for @pfNotPassed.
  ///
  /// In en, this message translates to:
  /// **'Not passed'**
  String get pfNotPassed;

  /// No description provided for @pfAverageCgpa.
  ///
  /// In en, this message translates to:
  /// **'Average CGPA'**
  String get pfAverageCgpa;

  /// No description provided for @pfSscTitle.
  ///
  /// In en, this message translates to:
  /// **'Secondary school certificate (SSC)'**
  String get pfSscTitle;

  /// No description provided for @pfSchool.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get pfSchool;

  /// No description provided for @pfGroupBoard.
  ///
  /// In en, this message translates to:
  /// **'Group & board'**
  String get pfGroupBoard;

  /// No description provided for @pfPassingYearGpa.
  ///
  /// In en, this message translates to:
  /// **'Passing year & GPA'**
  String get pfPassingYearGpa;

  /// No description provided for @pfPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Practical project portfolio'**
  String get pfPortfolio;

  /// No description provided for @pfPortfolioSub.
  ///
  /// In en, this message translates to:
  /// **'Projects built in class and on your own'**
  String get pfPortfolioSub;

  /// No description provided for @pfAddProject.
  ///
  /// In en, this message translates to:
  /// **'Add new project'**
  String get pfAddProject;

  /// No description provided for @pfLiveDemo.
  ///
  /// In en, this message translates to:
  /// **'Live demo'**
  String get pfLiveDemo;

  /// No description provided for @pfGithub.
  ///
  /// In en, this message translates to:
  /// **'GitHub code'**
  String get pfGithub;

  /// No description provided for @pfTrackerTitle.
  ///
  /// In en, this message translates to:
  /// **'Applied circulars & internship tracker'**
  String get pfTrackerTitle;

  /// No description provided for @pfTrackerSub.
  ///
  /// In en, this message translates to:
  /// **'Real-time status of all your applications'**
  String get pfTrackerSub;

  /// No description provided for @pfColCompany.
  ///
  /// In en, this message translates to:
  /// **'Company & role'**
  String get pfColCompany;

  /// No description provided for @pfColType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get pfColType;

  /// No description provided for @pfColDate.
  ///
  /// In en, this message translates to:
  /// **'Applied on'**
  String get pfColDate;

  /// No description provided for @pfColAction.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get pfColAction;

  /// No description provided for @pfViewMessage.
  ///
  /// In en, this message translates to:
  /// **'View message'**
  String get pfViewMessage;

  /// No description provided for @pfCertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Training & course certificates'**
  String get pfCertsTitle;

  /// No description provided for @pfSocialTitle.
  ///
  /// In en, this message translates to:
  /// **'Social media & portfolio links'**
  String get pfSocialTitle;

  /// No description provided for @pfEditStudentTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit student profile'**
  String get pfEditStudentTitle;

  /// No description provided for @pfFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get pfFullName;

  /// No description provided for @pfPolytechnic.
  ///
  /// In en, this message translates to:
  /// **'Polytechnic'**
  String get pfPolytechnic;

  /// No description provided for @pfTechnology.
  ///
  /// In en, this message translates to:
  /// **'Technology'**
  String get pfTechnology;

  /// No description provided for @pfBio.
  ///
  /// In en, this message translates to:
  /// **'Short bio'**
  String get pfBio;

  /// No description provided for @pfCvLink.
  ///
  /// In en, this message translates to:
  /// **'Google Drive CV link'**
  String get pfCvLink;

  /// No description provided for @pfCvHint.
  ///
  /// In en, this message translates to:
  /// **'Set access to \'Anyone with the link\' so recruiters can open it.'**
  String get pfCvHint;

  /// No description provided for @pfProjectName.
  ///
  /// In en, this message translates to:
  /// **'Project name'**
  String get pfProjectName;

  /// No description provided for @pfProjectTech.
  ///
  /// In en, this message translates to:
  /// **'Technologies (comma separated)'**
  String get pfProjectTech;

  /// No description provided for @pfProjectDesc.
  ///
  /// In en, this message translates to:
  /// **'Short description'**
  String get pfProjectDesc;

  /// No description provided for @pfVerifiedRecruiter.
  ///
  /// In en, this message translates to:
  /// **'Verified recruiter'**
  String get pfVerifiedRecruiter;

  /// No description provided for @pfBtebApproved.
  ///
  /// In en, this message translates to:
  /// **'BTEB approved industry partner'**
  String get pfBtebApproved;

  /// No description provided for @pfNewPost.
  ///
  /// In en, this message translates to:
  /// **'Post new circular'**
  String get pfNewPost;

  /// No description provided for @pfEmployees.
  ///
  /// In en, this message translates to:
  /// **'{count}+ employees'**
  String pfEmployees(String count);

  /// No description provided for @pfStatTotalPosts.
  ///
  /// In en, this message translates to:
  /// **'Total circulars'**
  String get pfStatTotalPosts;

  /// No description provided for @pfStatJobs.
  ///
  /// In en, this message translates to:
  /// **'Job circulars'**
  String get pfStatJobs;

  /// No description provided for @pfStatAttachments.
  ///
  /// In en, this message translates to:
  /// **'Industrial attachments'**
  String get pfStatAttachments;

  /// No description provided for @pfStatApplications.
  ///
  /// In en, this message translates to:
  /// **'Applications received'**
  String get pfStatApplications;

  /// No description provided for @pfTabPostings.
  ///
  /// In en, this message translates to:
  /// **'Circulars & internships'**
  String get pfTabPostings;

  /// No description provided for @pfTabApplicants.
  ///
  /// In en, this message translates to:
  /// **'Applicants & evaluation'**
  String get pfTabApplicants;

  /// No description provided for @pfTabCompany.
  ///
  /// In en, this message translates to:
  /// **'About & benefits'**
  String get pfTabCompany;

  /// No description provided for @pfTabMou.
  ///
  /// In en, this message translates to:
  /// **'Polytechnic partners & MOU'**
  String get pfTabMou;

  /// No description provided for @pfAllPosts.
  ///
  /// In en, this message translates to:
  /// **'All posts ({count})'**
  String pfAllPosts(String count);

  /// No description provided for @pfJobsCount.
  ///
  /// In en, this message translates to:
  /// **'Full-time jobs ({count})'**
  String pfJobsCount(String count);

  /// No description provided for @pfAttachCount.
  ///
  /// In en, this message translates to:
  /// **'Attachments ({count})'**
  String pfAttachCount(String count);

  /// No description provided for @pfSeats.
  ///
  /// In en, this message translates to:
  /// **'Seats: {count}'**
  String pfSeats(String count);

  /// No description provided for @pfPlace.
  ///
  /// In en, this message translates to:
  /// **'Location: {value}'**
  String pfPlace(String value);

  /// No description provided for @pfStipend.
  ///
  /// In en, this message translates to:
  /// **'Stipend: {value}'**
  String pfStipend(String value);

  /// No description provided for @pfSalary.
  ///
  /// In en, this message translates to:
  /// **'Salary: {value}'**
  String pfSalary(String value);

  /// No description provided for @pfDeadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline: {value}'**
  String pfDeadline(String value);

  /// No description provided for @pfTechnologyLine.
  ///
  /// In en, this message translates to:
  /// **'Technology: {value}'**
  String pfTechnologyLine(String value);

  /// No description provided for @pfViewApplicants.
  ///
  /// In en, this message translates to:
  /// **'View applicants ({count})'**
  String pfViewApplicants(String count);

  /// No description provided for @pfActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get pfActive;

  /// No description provided for @pfApplicantsTitle.
  ///
  /// In en, this message translates to:
  /// **'Applicant evaluation list'**
  String get pfApplicantsTitle;

  /// No description provided for @pfApplicantsSub.
  ///
  /// In en, this message translates to:
  /// **'Verify CV, technology and NOC status of polytechnic students'**
  String get pfApplicantsSub;

  /// No description provided for @pfColStudent.
  ///
  /// In en, this message translates to:
  /// **'Student & polytechnic'**
  String get pfColStudent;

  /// No description provided for @pfColTechCgpa.
  ///
  /// In en, this message translates to:
  /// **'Technology & CGPA'**
  String get pfColTechCgpa;

  /// No description provided for @pfColPosition.
  ///
  /// In en, this message translates to:
  /// **'Position & type'**
  String get pfColPosition;

  /// No description provided for @pfColDocs.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get pfColDocs;

  /// No description provided for @pfCgpaValue.
  ///
  /// In en, this message translates to:
  /// **'CGPA: {value}'**
  String pfCgpaValue(String value);

  /// No description provided for @pfNocAttached.
  ///
  /// In en, this message translates to:
  /// **'NOC attached'**
  String get pfNocAttached;

  /// No description provided for @pfShortlistAction.
  ///
  /// In en, this message translates to:
  /// **'Shortlist'**
  String get pfShortlistAction;

  /// No description provided for @pfScheduleInterview.
  ///
  /// In en, this message translates to:
  /// **'Schedule interview'**
  String get pfScheduleInterview;

  /// No description provided for @pfDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get pfDone;

  /// No description provided for @pfShortlistedToast.
  ///
  /// In en, this message translates to:
  /// **'Candidate shortlisted'**
  String get pfShortlistedToast;

  /// No description provided for @pfInterviewSentToast.
  ///
  /// In en, this message translates to:
  /// **'Interview schedule sent to the student'**
  String get pfInterviewSentToast;

  /// No description provided for @pfPostedToast.
  ///
  /// In en, this message translates to:
  /// **'Circular published'**
  String get pfPostedToast;

  /// No description provided for @pfAboutCompany.
  ///
  /// In en, this message translates to:
  /// **'About the company'**
  String get pfAboutCompany;

  /// No description provided for @pfDomains.
  ///
  /// In en, this message translates to:
  /// **'Main engineering & technology areas'**
  String get pfDomains;

  /// No description provided for @pfBenefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits for interns & new hires'**
  String get pfBenefits;

  /// No description provided for @pfHrDesk.
  ///
  /// In en, this message translates to:
  /// **'HR desk & contact'**
  String get pfHrDesk;

  /// No description provided for @pfHrEmail.
  ///
  /// In en, this message translates to:
  /// **'HR email'**
  String get pfHrEmail;

  /// No description provided for @pfHelpline.
  ///
  /// In en, this message translates to:
  /// **'Helpline'**
  String get pfHelpline;

  /// No description provided for @pfHeadOffice.
  ///
  /// In en, this message translates to:
  /// **'Head office & plant'**
  String get pfHeadOffice;

  /// No description provided for @pfPartnersTitle.
  ///
  /// In en, this message translates to:
  /// **'Partner polytechnic institutes'**
  String get pfPartnersTitle;

  /// No description provided for @pfPartnersSub.
  ///
  /// In en, this message translates to:
  /// **'Institutes with an industrial attachment agreement'**
  String get pfPartnersSub;

  /// No description provided for @pfAddMou.
  ///
  /// In en, this message translates to:
  /// **'+ New MOU'**
  String get pfAddMou;

  /// No description provided for @pfMouVerified.
  ///
  /// In en, this message translates to:
  /// **'MOU verified'**
  String get pfMouVerified;

  /// No description provided for @pfAnnualQuota.
  ///
  /// In en, this message translates to:
  /// **'Annual intern quota: {count} students'**
  String pfAnnualQuota(String count);

  /// No description provided for @pfEditCompanyTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit company info'**
  String get pfEditCompanyTitle;

  /// No description provided for @pfCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Company name'**
  String get pfCompanyName;

  /// No description provided for @pfIndustry.
  ///
  /// In en, this message translates to:
  /// **'Industry category'**
  String get pfIndustry;

  /// No description provided for @pfCompanyAbout.
  ///
  /// In en, this message translates to:
  /// **'Company overview'**
  String get pfCompanyAbout;

  /// No description provided for @pfNewPostTitle.
  ///
  /// In en, this message translates to:
  /// **'Post a new circular / internship'**
  String get pfNewPostTitle;

  /// No description provided for @pfPostCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get pfPostCategory;

  /// No description provided for @pfPostTitle.
  ///
  /// In en, this message translates to:
  /// **'Position title'**
  String get pfPostTitle;

  /// No description provided for @pfPostTech.
  ///
  /// In en, this message translates to:
  /// **'Applicable technology / department'**
  String get pfPostTech;

  /// No description provided for @pfPostSeats.
  ///
  /// In en, this message translates to:
  /// **'Vacancies'**
  String get pfPostSeats;

  /// No description provided for @pfPostSalary.
  ///
  /// In en, this message translates to:
  /// **'Salary / stipend'**
  String get pfPostSalary;

  /// No description provided for @pfPostDeadline.
  ///
  /// In en, this message translates to:
  /// **'Application deadline'**
  String get pfPostDeadline;

  /// No description provided for @pfPostLocation.
  ///
  /// In en, this message translates to:
  /// **'Workplace location'**
  String get pfPostLocation;

  /// No description provided for @pfPostBenefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits (comma separated)'**
  String get pfPostBenefits;

  /// No description provided for @pfPublishNow.
  ///
  /// In en, this message translates to:
  /// **'Publish to portal'**
  String get pfPublishNow;

  /// No description provided for @pfInterviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule interview'**
  String get pfInterviewTitle;

  /// No description provided for @pfInterviewCandidate.
  ///
  /// In en, this message translates to:
  /// **'Candidate: {name}'**
  String pfInterviewCandidate(String name);

  /// No description provided for @pfInterviewDate.
  ///
  /// In en, this message translates to:
  /// **'Interview date & time'**
  String get pfInterviewDate;

  /// No description provided for @pfInterviewPlace.
  ///
  /// In en, this message translates to:
  /// **'Venue / meeting link'**
  String get pfInterviewPlace;

  /// No description provided for @pfSendNotice.
  ///
  /// In en, this message translates to:
  /// **'Send notification'**
  String get pfSendNotice;
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
