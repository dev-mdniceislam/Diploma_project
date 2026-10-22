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

  @override
  String get stepAuthentication =>
      '================================== Authentication ========================';

  @override
  String get authBadge => 'BTEB registered & verified platform';

  @override
  String get authHeroTitle => 'The right career start for diploma engineers';

  @override
  String get authHeroSubtitle =>
      'Find your 8th-semester attachment and your dream job after graduation with a single account.';

  @override
  String get authFeature1 =>
      '350+ attachment partners of the Bangladesh Technical Education Board';

  @override
  String get authFeature2 => 'Submit your polytechnic CV instantly in 1 click';

  @override
  String get authFeature3 => 'Online NOC & recommendation letter guidelines';

  @override
  String get demoTitle => 'Quickly test with a demo account:';

  @override
  String get demoStudent => 'Student demo';

  @override
  String get demoCompany => 'Company demo';

  @override
  String get demoStudentToast =>
      'Student demo details filled in automatically.';

  @override
  String get demoCompanyToast =>
      'Company demo details filled in automatically.';

  @override
  String get tabLogin => 'Sign in (Login)';

  @override
  String get tabRegister => 'Create account (Register)';

  @override
  String get roleStudent => 'Diploma student / graduate';

  @override
  String get roleCompany => 'Hiring company';

  @override
  String get fieldEmail => 'Email address *';

  @override
  String get fieldPassword => 'Password *';

  @override
  String get fieldConfirmPassword => 'Confirm password *';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get loginAction => 'Sign in';

  @override
  String get registerAction => 'Complete registration';

  @override
  String get fieldFullName => 'Full name *';

  @override
  String get fullNameHint => 'ex: Md. Tanvir Ahmed';

  @override
  String get fieldPolytechnic => 'Polytechnic institute *';

  @override
  String get selectPolytechnic => 'Select institute';

  @override
  String get fieldDepartment => 'Technology / department *';

  @override
  String get polyDpi => 'Dhaka Polytechnic Institute (DPI)';

  @override
  String get polyCpi => 'Chittagong Polytechnic (CPI)';

  @override
  String get polyRpi => 'Rajshahi Polytechnic (RPI)';

  @override
  String get polyBpi => 'Bogura Polytechnic (BPI)';

  @override
  String get polySpi => 'Sylhet Polytechnic (SPI)';

  @override
  String get polyFci => 'Feni Computer Institute (FCI)';

  @override
  String get polyOther => 'Other private polytechnics';

  @override
  String get fieldCompanyName => 'Company / organization name *';

  @override
  String get fieldIndustry => 'Industry type *';

  @override
  String get fieldWebsite => 'Official website URL';

  @override
  String get industryIt => 'Software & IT Solutions';

  @override
  String get industryConstruction => 'Construction & Real Estate';

  @override
  String get industryManufacturing => 'Manufacturing & Electronics';

  @override
  String get industryPower => 'Power & Energy';

  @override
  String get industryTextile => 'Textile & Garments';

  @override
  String get companyRoleLabel => 'Official recruiter';

  @override
  String get pwdHintLength => 'Use at least 8 characters';

  @override
  String get pwdWeak => 'Weak password';

  @override
  String get pwdMedium => 'Fair password';

  @override
  String get pwdStrong => 'Very strong password!';

  @override
  String get socialDivider => 'or continue with a social account';

  @override
  String get googleSignIn => 'Easily sign in with Google';

  @override
  String get googleVerifying => 'Verifying with your Google account...';

  @override
  String get googleSuccess => 'Signed in with Google successfully!';

  @override
  String get errRequired => 'This field is required';

  @override
  String get errInvalidEmail => 'Enter a valid email address';

  @override
  String get errPasswordShort => 'Password must be at least 8 characters';

  @override
  String get errPasswordMismatch => 'Passwords do not match';

  @override
  String get errInvalidUrl => 'Enter a valid website URL (https://...)';

  @override
  String get errPolytechnicRequired =>
      'Please select your polytechnic institute';

  @override
  String get loginStudentSuccess =>
      'Signed in! Welcome to the student dashboard.';

  @override
  String get loginCompanySuccess =>
      'Signed in! Welcome to the company dashboard.';

  @override
  String get registerSuccess => 'Account created successfully!';

  @override
  String get authFailed => 'Couldn\'t sign you in. Please try again.';

  @override
  String get loggedOut => 'You have been signed out.';

  @override
  String get forgotTitle => 'Reset password';

  @override
  String get forgotMessage =>
      'Enter your registered email and we\'ll send you a reset link.';

  @override
  String get forgotEmailHint => 'Enter your email...';

  @override
  String get cancel => 'Cancel';

  @override
  String get sendLink => 'Send link';

  @override
  String get resetSent => 'Reset link sent to your email!';

  @override
  String get navLogin => 'Login / Sign up';

  @override
  String get navDashboard => 'My dashboard';

  @override
  String get logout => 'Log out';

  @override
  String get stepForgot =>
      '================================== Forgot Password ========================';

  @override
  String get resetPasswordTitle => 'Reset password';

  @override
  String get resetPasswordDesc =>
      'Enter your registered email and we\'ll send you a reset link.';

  @override
  String get emailAddress => 'Email address';

  @override
  String get emailHint => 'Enter your email...';

  @override
  String get close => 'Close';

  @override
  String resetLinkSent(String email) {
    return 'We\'ve sent a password reset link to $email. Please check your inbox.';
  }

  @override
  String get setNewPasswordTitle => 'Set new password';

  @override
  String get setNewPasswordDesc => 'Choose a new password for your account.';

  @override
  String get newPassword => 'New password';

  @override
  String get resetPasswordButton => 'Reset password';

  @override
  String get passwordResetSuccess =>
      'Your password has been reset successfully. You can now sign in.';

  @override
  String get backToLogin => 'Back to sign in';

  @override
  String get otpLabel => 'Verification code';

  @override
  String get otpSubtitle => 'Enter the 6-digit code we sent to your email.';

  @override
  String get verifyOtp => 'Verify';

  @override
  String get resendOtp => 'Resend code';

  @override
  String get errInvalidOtp => 'Enter the 6-digit code';

  @override
  String get passwordResetSuccessTitle => 'Password updated!';

  @override
  String get sendCode => 'Send code';

  @override
  String get back => 'Back';

  @override
  String otpSentTo(String email) {
    return 'Enter the 6-digit code we sent to $email.';
  }
}
