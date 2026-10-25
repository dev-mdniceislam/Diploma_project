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
  String get retry => 'Retry';

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

  @override
  String get stepProfile =>
      '================================== Student Profile ========================';

  @override
  String get myProfile => 'My Profile';

  @override
  String get nocGuide => 'NOC Guide';

  @override
  String get updateCv => 'Update CV';

  @override
  String get comingSoon => 'This feature is coming soon!';

  @override
  String get changeCover => 'Change cover';

  @override
  String get verifiedStudent => 'Verified student';

  @override
  String get downloadResume => 'Download resume';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get copyPublicLink => 'Copy public link';

  @override
  String get linkCopied => 'Profile link copied to clipboard!';

  @override
  String get cvNotUploaded => 'No CV link has been added yet';

  @override
  String get linkOpenFailed => 'Could not open the link';

  @override
  String instituteRoll(String institute, String roll) {
    return '$institute • Roll: $roll';
  }

  @override
  String semesterLabel(String ordinal) {
    return '$ordinal Semester';
  }

  @override
  String ordinal(String n) {
    String _temp0 = intl.Intl.selectLogic(n, {
      '1': '1st',
      '2': '2nd',
      '3': '3rd',
      '4': '4th',
      '5': '5th',
      '6': '6th',
      '7': '7th',
      '8': '8th',
      'other': '${n}th',
    });
    return '$_temp0';
  }

  @override
  String get metricCurrentStatus => 'Current status';

  @override
  String metricStatusValue(String semester) {
    return '$semester (Attachment)';
  }

  @override
  String get metricCgpa => 'CGPA (average)';

  @override
  String get metricApplied => 'Applied jobs / internships';

  @override
  String circularsCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString circulars',
      one: '1 circular',
      zero: 'No circulars',
    );
    return '$_temp0';
  }

  @override
  String get metricNoc => 'NOC status';

  @override
  String get nocIssued => 'Issued';

  @override
  String get nocPending => 'In process';

  @override
  String get nocRejected => 'Rejected';

  @override
  String get tabOverview => 'Overview & details';

  @override
  String get tabAcademic => 'Academic';

  @override
  String get tabProjects => 'Skills & projects';

  @override
  String get tabApplications => 'Application tracker';

  @override
  String get tabCertifications => 'Certificates & social';

  @override
  String get aboutMe => 'About me (Bio)';

  @override
  String get edit => 'Edit';

  @override
  String get techProficiency => 'Technical proficiency';

  @override
  String get contactInfo => 'Contact information';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get currentAddress => 'Current address';

  @override
  String get boardInfo => 'Technical education board';

  @override
  String get boardRoll => 'Board roll:';

  @override
  String get registration => 'Registration:';

  @override
  String get session => 'Session:';

  @override
  String get nocLetterNo => 'NOC letter no:';

  @override
  String get resultBreakdown => 'Polytechnic result breakdown (Semester GPA)';

  @override
  String get colSemester => 'Semester';

  @override
  String get colExamYear => 'Exam year';

  @override
  String get colGpa => 'GPA';

  @override
  String get colStatus => 'Status';

  @override
  String get passed => 'Passed';

  @override
  String avgCgpaRange(String from, String to) {
    return 'Average CGPA ($from – $to)';
  }

  @override
  String get gradeFirstClass => 'First class honors equivalent';

  @override
  String get sscTitle => 'Secondary School Certificate (SSC / equivalent)';

  @override
  String get schoolName => 'School name:';

  @override
  String get groupBoard => 'Group & board:';

  @override
  String get passingYearGpa => 'Passing year & GPA:';

  @override
  String get portfolioTitle => 'Practical project portfolio';

  @override
  String get portfolioSubtitle => 'Projects built in class and on your own';

  @override
  String get addProject => 'Add new project';

  @override
  String get newProject => 'New project';

  @override
  String get liveDemo => 'Live demo';

  @override
  String get githubCode => 'GitHub code';

  @override
  String get trackerTitle => 'Applied circulars & internship tracker';

  @override
  String get trackerSubtitle =>
      'Real-time status of all your submitted applications';

  @override
  String get filter => 'Filter:';

  @override
  String get filterAll => 'All applications';

  @override
  String get filterShortlisted => 'Shortlisted';

  @override
  String get filterPending => 'Pending';

  @override
  String get filterInterview => 'Interview scheduled';

  @override
  String get noApplications => 'No applications found';

  @override
  String get colCompany => 'Company & position';

  @override
  String get colType => 'Type';

  @override
  String get colAppliedDate => 'Applied on';

  @override
  String get colCurrentStatus => 'Current status';

  @override
  String get colAction => 'Action';

  @override
  String get typeAttachment => '🎓 Attachment';

  @override
  String get typeJob => '💼 Job';

  @override
  String get statusShortlisted => 'Shortlisted';

  @override
  String get statusInterview => 'Interview scheduled';

  @override
  String get statusPending => 'Review pending';

  @override
  String get actionViewMessage => 'View message';

  @override
  String get actionDetails => 'Details';

  @override
  String get actionPleaseWait => 'Please wait';

  @override
  String get noMessage => 'No message yet';

  @override
  String get certificatesTitle => 'Training & course certificates';

  @override
  String get add => 'Add';

  @override
  String get socialTitle => 'Social media & online portfolio links';

  @override
  String get linkedinProfile => 'LinkedIn Profile';

  @override
  String get githubRepos => 'GitHub Repositories';

  @override
  String get editProfileTitle => 'Edit student profile';

  @override
  String get fullName => 'Student\'s full name';

  @override
  String get polytechnicName => 'Polytechnic name';

  @override
  String get technology => 'Technology';

  @override
  String get email => 'Email';

  @override
  String get bioLabel => 'Short bio';

  @override
  String get save => 'Save';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidEmail => 'Enter a valid email address';

  @override
  String get invalidUrl => 'Enter a valid link';

  @override
  String get profileUpdated => 'Profile updated successfully!';

  @override
  String get cvDialogTitle => 'Google Drive resume / CV link';

  @override
  String get cvLinkLabel => 'Google Drive CV link';

  @override
  String get cvLinkNote => 'Turn on \'Anyone with the link\' view permission.';

  @override
  String get update => 'Update';

  @override
  String get cvUpdated => 'Your Google Drive CV link has been updated!';

  @override
  String get addProjectTitle => 'Add a new project';

  @override
  String get projectName => 'Project name';

  @override
  String get projectTech => 'Technologies used (comma separated)';

  @override
  String get projectTechHint => 'e.g. HTML, Tailwind, JS';

  @override
  String get projectDesc => 'Short description';

  @override
  String get publish => 'Publish';

  @override
  String get projectAdded => 'Project added to your portfolio!';

  @override
  String get nocGuideTitle => 'NOC guideline';

  @override
  String get nocGuideBody =>
      'Attach the NOC letter approved by your polytechnic\'s industrial liaison office when you apply.';

  @override
  String nocVerifiedActive(String number) {
    return 'NOC No: $number (Verified Active)';
  }

  @override
  String get somethingWentWrong => 'Something went wrong. Please try again.';

  @override
  String get stepJobDetails =>
      '================================== Job details ========================';

  @override
  String get appliedBannerTitle =>
      'You have successfully applied to this circular!';

  @override
  String appliedBannerSubtitle(String date, String status) {
    return 'Applied on: $date | Status: $status';
  }

  @override
  String get applicationDetails => 'Application details';

  @override
  String typeSemesterAttachment(String semester) {
    return '🎓 $semester attachment';
  }

  @override
  String get typeFullTimeJob => '💼 Full-time job';

  @override
  String get verifiedEmployer => 'Verified employer';

  @override
  String get technologyLabel => 'Technology:';

  @override
  String get applied => 'Application submitted';

  @override
  String get bookmarkTooltip => 'Save';

  @override
  String get shareTooltip => 'Share';

  @override
  String get hlLocation => 'Work location';

  @override
  String get hlStipend => 'Monthly stipend';

  @override
  String get hlExperience => 'Experience / semester';

  @override
  String get hlDeadline => 'Application deadline';

  @override
  String get hlVacancies => 'Vacancies';

  @override
  String stipendPerMonth(int amount) {
    final intl.NumberFormat amountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String amountString = amountNumberFormat.format(amount);

    return '৳ $amountString / month';
  }

  @override
  String vacanciesCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString seats',
      one: '1 seat',
    );
    return '$_temp0';
  }

  @override
  String get roleOverview => 'Role overview';

  @override
  String get keyResponsibilities => 'Key responsibilities';

  @override
  String get requirementsTitle => 'Education & technology requirements';

  @override
  String get benefitsTitle => 'Benefits & perks';

  @override
  String get requiredDocsTitle => 'Documents required to apply';

  @override
  String get summaryTitle => 'Circular summary';

  @override
  String get sumPublished => 'Published on:';

  @override
  String get sumDeadline => 'Deadline:';

  @override
  String get sumJobType => 'Job type:';

  @override
  String get sumEducation => 'Education:';

  @override
  String get sumHousing => 'Housing:';

  @override
  String get applyOnline => 'Apply online now';

  @override
  String get hrTitle => 'HR desk & contact';

  @override
  String get hrEmail => 'Official HR email';

  @override
  String get hrHelpline => 'Helpline (9am–5pm)';

  @override
  String get hrWebsite => 'Website';

  @override
  String get relatedTitle => 'Related circulars';

  @override
  String get applyDialogTitle => 'Apply directly to this circular';

  @override
  String get cvUploadLabel => 'Your updated CV (PDF) *';

  @override
  String get dropOrBrowse => 'Drop a file or';

  @override
  String get browse => 'browse';

  @override
  String get maxFileSize => 'Max file size: 5 MB (PDF)';

  @override
  String get removeFile => 'Remove file';

  @override
  String get nocUploadLabel => 'Polytechnic NOC attachment (optional)';

  @override
  String get expectedStipend => 'Expected stipend';

  @override
  String get companyDecided => '(set by company)';

  @override
  String get currentSemester => 'Current semester *';

  @override
  String get coverNoteLabel => 'Short note to the HR desk (cover note)';

  @override
  String get coverNoteHint =>
      'Why you are a good fit and a bit about your technical projects…';

  @override
  String get confirmApplication => 'Confirm application';

  @override
  String get cvRequired => 'Please attach your CV (PDF)';

  @override
  String get fileTooLarge => 'File is larger than 5 MB';

  @override
  String applicantNameRoll(String name, String roll) {
    return '$name (Roll: $roll)';
  }

  @override
  String applicationSubmitted(String company) {
    return 'Your application was submitted to the $company HR desk!';
  }

  @override
  String get alreadyApplied => 'You have already applied!';

  @override
  String get bookmarkSaved => 'Circular saved to your bookmarks';

  @override
  String get bookmarkRemoved => 'Removed from your bookmarks';

  @override
  String get circularLinkCopied => 'Circular link copied!';
}
