// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Career Orbit';

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
  String deadlineLabel(String value) {
    return 'Deadline: $value';
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
      'Bridging BTEB polytechnic students and factories.';

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
  String get comingSoon => 'Coming soon';

  @override
  String get changeCover => 'Change banner';

  @override
  String get verifiedStudent => 'Verified student';

  @override
  String get downloadResume => 'Download resume';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get copyPublicLink => 'Copy public link';

  @override
  String get linkCopied => 'Profile link copied to clipboard!';

  @override
  String get cvNotUploaded => 'No CV link has been added yet';

  @override
  String get linkOpenFailed => 'Unable to open the link';

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
  String get tabOverview => 'About & Benefits';

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
  String get typeAttachment => '8th Semester Attachment';

  @override
  String get typeJob => 'Full-time job';

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
  String technologyLabel(String value) {
    return 'Technology: $value';
  }

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
  String get benefitsTitle => 'Benefits for interns & new hires';

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

  @override
  String get stepCompanyProfile =>
      '================================== Profile ========================';

  @override
  String get recruiterPortalTagline => 'Recruiter Portal & Company Desk';

  @override
  String get navPostings => 'Jobs & Internships';

  @override
  String get navApplicants => 'Applicants';

  @override
  String get navCompanyPanel => 'Company Panel';

  @override
  String get btebPartner => 'BTEB Industry Partner';

  @override
  String get newPost => 'Post New';

  @override
  String get shareProfile => 'Share profile';

  @override
  String get changeLogo => 'Change logo';

  @override
  String get toggleTheme => 'Toggle theme';

  @override
  String get languageToggleLabel => 'বাংলা';

  @override
  String get verifiedRecruiter => 'Verified Recruiter';

  @override
  String get btebApprovedIndustry => 'BTEB Approved Industry';

  @override
  String employeesCount(String count) {
    return '$count+ employees';
  }

  @override
  String get statTotalPostings => 'Total circulars posted';

  @override
  String get statJobs => 'Job circulars';

  @override
  String get statAttachments => 'Industrial attachments';

  @override
  String get statApplications => 'Applications received';

  @override
  String itemsCount(String count) {
    return '$count';
  }

  @override
  String get tabPostings => 'Circulars & Internship Management';

  @override
  String get tabApplicants => 'Applicants & Evaluation';

  @override
  String get tabMou => 'Polytechnic Partnerships & MOU';

  @override
  String get filterType => 'Filter type:';

  @override
  String filterAllPosts(String count) {
    return 'All posts ($count)';
  }

  @override
  String filterJobs(String count) {
    return 'Full-time jobs ($count)';
  }

  @override
  String filterAttachments(String count) {
    return '8th-semester attachments ($count)';
  }

  @override
  String seatsLabel(String count) {
    return 'Seats: $count';
  }

  @override
  String locationLabel(String value) {
    return 'Location: $value';
  }

  @override
  String salaryLabel(String value) {
    return 'Salary: $value';
  }

  @override
  String stipendLabel(String value) {
    return 'Stipend: $value';
  }

  @override
  String viewApplications(String count) {
    return 'View applications ($count)';
  }

  @override
  String get statusActive => 'Active';

  @override
  String get emptyPostings => 'No circulars posted yet.';

  @override
  String get emptyApplicants => 'No applicants found.';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get postDialogTitle => 'Post a new circular / internship';

  @override
  String get postDialogSubtitle =>
      'Provide details for a job or an 8th-semester industrial attachment';

  @override
  String get postCategoryLabel => 'Select post category *';

  @override
  String get categoryAttachmentSubtitle =>
      'Internship for polytechnic students';

  @override
  String get categoryJobTitle => 'Full-time / Part-time job';

  @override
  String get categoryJobSubtitle => 'Hiring diploma graduates';

  @override
  String get postTitleLabel => 'Position title *';

  @override
  String get postTitleHint => 'e.g. Sub-Assistant Engineer (PLC & Automation)';

  @override
  String get postTechLabel => 'Applicable technology / department *';

  @override
  String get postTechHint => 'e.g. Computer, Electrical, Mechanical';

  @override
  String get postSeatsLabel => 'Vacancies (Seats) *';

  @override
  String get postSeatsHint => 'e.g. 20';

  @override
  String get postSalaryLabel => 'Salary / stipend *';

  @override
  String get postSalaryHint => 'e.g. ৳10,000/month (or negotiable)';

  @override
  String get postDeadlineLabel => 'Application deadline *';

  @override
  String get postLocationLabel => 'Work location / factory *';

  @override
  String get postLocationHint => 'e.g. Chandra, Gazipur plant';

  @override
  String get postBenefitsLabel => 'Extra benefits & conditions';

  @override
  String get benefitFreeHousing => 'Free housing';

  @override
  String get benefitCanteen => 'Cafeteria subsidy';

  @override
  String get benefitNocRequired => 'Polytechnic NOC required';

  @override
  String get tagNocApplicable => 'NOC applicable';

  @override
  String get publishToPortal => 'Publish to portal';

  @override
  String get invalidNumber => 'Enter a valid number';

  @override
  String get editCompanyTitle => 'Edit company details';

  @override
  String get companyNameLabel => 'Company name *';

  @override
  String get industryLabel => 'Industry category *';

  @override
  String get hrEmailLabel => 'HR email *';

  @override
  String get helplineLabel => 'Helpline number *';

  @override
  String get aboutSummaryLabel => 'Company overview (About)';

  @override
  String get interviewDialogTitle => 'Schedule interview';

  @override
  String interviewCandidate(String name) {
    return 'Candidate: $name';
  }

  @override
  String get interviewDateTimeLabel => 'Interview date & time *';

  @override
  String get interviewVenueLabel => 'Venue / online meeting link *';

  @override
  String get interviewVenueHint =>
      'e.g. Walton Plant HQ Boardroom or Google Meet link';

  @override
  String get sendNotification => 'Send notification';

  @override
  String get applicantsTitle => 'Applicant evaluation list';

  @override
  String get applicantsSubtitle =>
      'Verify CV, technology and NOC status of polytechnic students';

  @override
  String get filterAllApplicants => 'All applicants';

  @override
  String statusInterviewOn(String date) {
    return 'Interview $date';
  }

  @override
  String get downloadCvs => 'Download CVs';

  @override
  String get colStudent => 'Student & polytechnic';

  @override
  String get colTechCgpa => 'Technology & CGPA';

  @override
  String get colPosition => 'Applied position';

  @override
  String get colDocuments => 'Documents';

  @override
  String cgpaLabel(String value) {
    return 'CGPA: $value';
  }

  @override
  String get nocAttached => 'NOC attached';

  @override
  String get actionShortlist => 'Shortlist';

  @override
  String get actionScheduleInterview => 'Schedule interview';

  @override
  String get actionDone => 'Done';

  @override
  String get aboutTitle => 'About & mission';

  @override
  String get domainsTitle => 'Key engineering & technology areas';

  @override
  String get hrDeskTitle => 'HR desk & contact';

  @override
  String get hrEmailTitle => 'HR email';

  @override
  String get helplineTitle => 'Helpline number';

  @override
  String get headOfficeTitle => 'Head office & plant';

  @override
  String get mouTitle => 'Partner polytechnic institutes (Campus partners)';

  @override
  String get mouSubtitle =>
      'Institutes with an industrial-attachment agreement';

  @override
  String get newMou => '+ New MOU';

  @override
  String get mouVerified => 'MOU verified';

  @override
  String annualQuota(String count) {
    return 'Annual intern quota: $count students';
  }

  @override
  String get toastPostPublished => 'New circular published successfully!';

  @override
  String get toastProfileUpdated => 'Company profile updated!';

  @override
  String get toastInterviewSent => 'Interview schedule sent to the student.';

  @override
  String get toastShortlisted => 'Candidate added to the shortlist!';

  @override
  String get toastLinkCopied => 'Company dashboard link copied!';

  @override
  String get toastExportingCvs => 'Exporting all CVs as a ZIP...';

  @override
  String get pfNoLink => 'Link not available';

  @override
  String get pfLinkCopied => 'Profile link copied';

  @override
  String get pfRetry => 'Retry';

  @override
  String get pfNoData => 'Nothing to show yet';

  @override
  String get pfUnknownRole => 'This account type has no profile page.';

  @override
  String get pfSave => 'Save';

  @override
  String get pfCancel => 'Cancel';

  @override
  String get pfComingSoon => 'Coming soon';

  @override
  String get pfSaved => 'Saved successfully';

  @override
  String get pfEditProfile => 'Edit profile';

  @override
  String get pfEmail => 'Email';

  @override
  String get pfPhone => 'Phone';

  @override
  String get pfAddress => 'Address';

  @override
  String get pfAll => 'All';

  @override
  String get pfShortlisted => 'Shortlisted';

  @override
  String get pfPending => 'Pending review';

  @override
  String get pfInterview => 'Interview scheduled';

  @override
  String pfInterviewOn(String date) {
    return 'Interview $date';
  }

  @override
  String get pfTypeJob => 'Full-time job';

  @override
  String get pfTypeAttachment => 'Industrial attachment';

  @override
  String get pfStatus => 'Status';

  @override
  String get pfUpdate => 'Update';

  @override
  String get pfPublish => 'Publish';

  @override
  String get pfStudentVerified => 'Verified student';

  @override
  String pfRoll(String roll) {
    return 'Roll: $roll';
  }

  @override
  String get pfDownloadCv => 'Download resume';

  @override
  String get pfUpdateCv => 'Update CV link';

  @override
  String get pfStatCurrent => 'Current status';

  @override
  String get pfStatCgpa => 'CGPA (average)';

  @override
  String get pfStatApplied => 'Applied jobs / internships';

  @override
  String pfStatAppliedValue(String count) {
    return '$count circulars';
  }

  @override
  String get pfStatNoc => 'NOC status';

  @override
  String get pfNocIssued => 'Issued';

  @override
  String get pfNocPending => 'Not issued';

  @override
  String get pfTabOverview => 'Overview';

  @override
  String get pfTabAcademic => 'Academics';

  @override
  String get pfTabProjects => 'Skills & projects';

  @override
  String get pfTabApplications => 'Applications';

  @override
  String get pfTabCertificates => 'Certificates & social';

  @override
  String get pfAboutMe => 'About me';

  @override
  String get pfSkills => 'Technical proficiency';

  @override
  String get pfContactInfo => 'Contact information';

  @override
  String get pfBoardInfo => 'Technical board info';

  @override
  String get pfBoardRoll => 'Board roll';

  @override
  String get pfRegistration => 'Registration';

  @override
  String get pfSession => 'Session';

  @override
  String get pfNocNumber => 'NOC letter no.';

  @override
  String get pfResultBreakdown => 'Polytechnic result breakdown (semester GPA)';

  @override
  String get pfSemester => 'Semester';

  @override
  String pfSemesterN(String n) {
    return 'Semester $n';
  }

  @override
  String get pfExamYear => 'Exam year';

  @override
  String get pfGpa => 'GPA';

  @override
  String get pfPassed => 'Passed';

  @override
  String get pfNotPassed => 'Not passed';

  @override
  String get pfAverageCgpa => 'Average CGPA';

  @override
  String get pfSscTitle => 'Secondary school certificate (SSC)';

  @override
  String get pfSchool => 'School';

  @override
  String get pfGroupBoard => 'Group & board';

  @override
  String get pfPassingYearGpa => 'Passing year & GPA';

  @override
  String get pfPortfolio => 'Practical project portfolio';

  @override
  String get pfPortfolioSub => 'Projects built in class and on your own';

  @override
  String get pfAddProject => 'Add new project';

  @override
  String get pfLiveDemo => 'Live demo';

  @override
  String get pfGithub => 'GitHub code';

  @override
  String get pfTrackerTitle => 'Applied circulars & internship tracker';

  @override
  String get pfTrackerSub => 'Real-time status of all your applications';

  @override
  String get pfColCompany => 'Company & role';

  @override
  String get pfColType => 'Type';

  @override
  String get pfColDate => 'Applied on';

  @override
  String get pfColAction => 'Action';

  @override
  String get pfViewMessage => 'View message';

  @override
  String get pfCertsTitle => 'Training & course certificates';

  @override
  String get pfSocialTitle => 'Social media & portfolio links';

  @override
  String get pfEditStudentTitle => 'Edit student profile';

  @override
  String get pfFullName => 'Full name';

  @override
  String get pfPolytechnic => 'Polytechnic';

  @override
  String get pfTechnology => 'Technology';

  @override
  String get pfBio => 'Short bio';

  @override
  String get pfCvLink => 'Google Drive CV link';

  @override
  String get pfCvHint =>
      'Set access to \'Anyone with the link\' so recruiters can open it.';

  @override
  String get pfProjectName => 'Project name';

  @override
  String get pfProjectTech => 'Technologies (comma separated)';

  @override
  String get pfProjectDesc => 'Short description';

  @override
  String get pfVerifiedRecruiter => 'Verified recruiter';

  @override
  String get pfBtebApproved => 'BTEB approved industry partner';

  @override
  String get pfNewPost => 'Post new circular';

  @override
  String pfEmployees(String count) {
    return '$count+ employees';
  }

  @override
  String get pfStatTotalPosts => 'Total circulars';

  @override
  String get pfStatJobs => 'Job circulars';

  @override
  String get pfStatAttachments => 'Industrial attachments';

  @override
  String get pfStatApplications => 'Applications received';

  @override
  String get pfTabPostings => 'Circulars & internships';

  @override
  String get pfTabApplicants => 'Applicants & evaluation';

  @override
  String get pfTabCompany => 'About & benefits';

  @override
  String get pfTabMou => 'Polytechnic partners & MOU';

  @override
  String pfAllPosts(String count) {
    return 'All posts ($count)';
  }

  @override
  String pfJobsCount(String count) {
    return 'Full-time jobs ($count)';
  }

  @override
  String pfAttachCount(String count) {
    return 'Attachments ($count)';
  }

  @override
  String pfSeats(String count) {
    return 'Seats: $count';
  }

  @override
  String pfPlace(String value) {
    return 'Location: $value';
  }

  @override
  String pfStipend(String value) {
    return 'Stipend: $value';
  }

  @override
  String pfSalary(String value) {
    return 'Salary: $value';
  }

  @override
  String pfDeadline(String value) {
    return 'Deadline: $value';
  }

  @override
  String pfTechnologyLine(String value) {
    return 'Technology: $value';
  }

  @override
  String pfViewApplicants(String count) {
    return 'View applicants ($count)';
  }

  @override
  String get pfActive => 'Active';

  @override
  String get pfApplicantsTitle => 'Applicant evaluation list';

  @override
  String get pfApplicantsSub =>
      'Verify CV, technology and NOC status of polytechnic students';

  @override
  String get pfColStudent => 'Student & polytechnic';

  @override
  String get pfColTechCgpa => 'Technology & CGPA';

  @override
  String get pfColPosition => 'Position & type';

  @override
  String get pfColDocs => 'Documents';

  @override
  String pfCgpaValue(String value) {
    return 'CGPA: $value';
  }

  @override
  String get pfNocAttached => 'NOC attached';

  @override
  String get pfShortlistAction => 'Shortlist';

  @override
  String get pfScheduleInterview => 'Schedule interview';

  @override
  String get pfDone => 'Done';

  @override
  String get pfShortlistedToast => 'Candidate shortlisted';

  @override
  String get pfInterviewSentToast => 'Interview schedule sent to the student';

  @override
  String get pfPostedToast => 'Circular published';

  @override
  String get pfAboutCompany => 'About the company';

  @override
  String get pfDomains => 'Main engineering & technology areas';

  @override
  String get pfBenefits => 'Benefits for interns & new hires';

  @override
  String get pfHrDesk => 'HR desk & contact';

  @override
  String get pfHrEmail => 'HR email';

  @override
  String get pfHelpline => 'Helpline';

  @override
  String get pfHeadOffice => 'Head office & plant';

  @override
  String get pfPartnersTitle => 'Partner polytechnic institutes';

  @override
  String get pfPartnersSub =>
      'Institutes with an industrial attachment agreement';

  @override
  String get pfAddMou => '+ New MOU';

  @override
  String get pfMouVerified => 'MOU verified';

  @override
  String pfAnnualQuota(String count) {
    return 'Annual intern quota: $count students';
  }

  @override
  String get pfEditCompanyTitle => 'Edit company info';

  @override
  String get pfCompanyName => 'Company name';

  @override
  String get pfIndustry => 'Industry category';

  @override
  String get pfCompanyAbout => 'Company overview';

  @override
  String get pfNewPostTitle => 'Post a new circular / internship';

  @override
  String get pfPostCategory => 'Category';

  @override
  String get pfPostTitle => 'Position title';

  @override
  String get pfPostTech => 'Applicable technology / department';

  @override
  String get pfPostSeats => 'Vacancies';

  @override
  String get pfPostSalary => 'Salary / stipend';

  @override
  String get pfPostDeadline => 'Application deadline';

  @override
  String get pfPostLocation => 'Workplace location';

  @override
  String get pfPostBenefits => 'Benefits (comma separated)';

  @override
  String get pfPublishNow => 'Publish to portal';

  @override
  String get pfInterviewTitle => 'Schedule interview';

  @override
  String pfInterviewCandidate(String name) {
    return 'Candidate: $name';
  }

  @override
  String get pfInterviewDate => 'Interview date & time';

  @override
  String get pfInterviewPlace => 'Venue / meeting link';

  @override
  String get pfSendNotice => 'Send notification';
}
