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
  /// **'This feature is coming soon!'**
  String get comingSoon;

  /// No description provided for @changeCover.
  ///
  /// In en, this message translates to:
  /// **'Change cover'**
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
  /// **'Edit profile'**
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
  /// **'Could not open the link'**
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
  /// **'Overview & details'**
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
  /// **'🎓 Attachment'**
  String get typeAttachment;

  /// No description provided for @typeJob.
  ///
  /// In en, this message translates to:
  /// **'💼 Job'**
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
  /// **'Technology:'**
  String get technologyLabel;

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
  /// **'Benefits & perks'**
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
