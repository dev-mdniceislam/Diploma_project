// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'ডিপ্লোমা জব হাব';

  @override
  String get appTagline => 'Diploma Engineer Career Portal';

  @override
  String get navHome => 'হোম / সার্কুলার';

  @override
  String get navAttachment => 'ইন্ডাস্ট্রিয়াল অ্যাটাচমেন্ট';

  @override
  String get navGuide => 'গাইডলাইন ও NOC';

  @override
  String get personaStudent => 'শিক্ষার্থী';

  @override
  String get personaCompany => 'কোম্পানি';

  @override
  String get personaStudentToast =>
      'শিক্ষার্থী মোড সক্রিয় হয়েছে। সহজেই আবেদন করুন!';

  @override
  String get personaCompanyToast =>
      'কোম্পানি মোড সক্রিয় হয়েছে। নতুন সার্কুলার পোস্ট করুন!';

  @override
  String get postCircular => 'সার্কুলার পোস্ট করুন';

  @override
  String get savedCirculars => 'সংরক্ষিত সার্কুলার';

  @override
  String get saveCircular => 'সংরক্ষণ করুন';

  @override
  String get savedAdded => 'সার্কুলারটি বুকমার্ক তালিকায় সংরক্ষিত হয়েছে!';

  @override
  String get savedRemoved => 'সংরক্ষিত সার্কুলার তালিকা থেকে মুছে ফেলা হয়েছে।';

  @override
  String get menu => 'মেনু';

  @override
  String get heroBadge =>
      'বাংলাদেশের ১ম বিশেষায়িত ডিপ্লোমা ইঞ্জিনিয়ারিং জব পোর্টাল';

  @override
  String get heroTitleLine => 'ডিপ্লোমা প্রকৌশলী ও শিক্ষার্থীদের জন্য';

  @override
  String get heroTitleHighlight => 'সেরা চাকরি ও ইন্ডাস্ট্রিয়াল অ্যাটাচমেন্ট';

  @override
  String get heroSubtitle =>
      'দেশের ৩০০+ নামীদামী কোম্পানিতে আপনার প্রযুক্তির স্বপ্নের ক্যারিয়ার শুরু করুন। ৮ম সেমিস্টারের ইন্ডাস্ট্রিয়াল ট্রেনিং এবং চাকরির সার্কুলার এক প্ল্যাটফর্মে!';

  @override
  String get searchHint =>
      'পদের নাম বা স্কিল লিখুন (ex: PLC, AutoCAD, Developer)...';

  @override
  String get allTechnologiesDept => 'সকল টেকনোলজি / বিভাগ';

  @override
  String get filterAction => 'ফিল্টার করুন';

  @override
  String get statJobsValue => '৪৫০+';

  @override
  String get statJobsLabel => 'সক্রিয় চাকরির সুযোগ';

  @override
  String get statInternsValue => '২৫০+';

  @override
  String get statInternsLabel => 'ইন্ডাস্ট্রিয়াল অ্যাটাচমেন্ট সিট';

  @override
  String get statPartnersValue => '১৫০+';

  @override
  String get statPartnersLabel => 'অংশীদার কোম্পানি';

  @override
  String get statPolytechnicValue => '১০০%';

  @override
  String get statPolytechnicLabel => 'পলিটেকনিক শিক্ষার্থীদের জন্য';

  @override
  String get techFilterTitle => 'টেকনোলজি অনুযায়ী ফিল্টার করুন:';

  @override
  String get techAll => 'সকল টেকনোলজি';

  @override
  String get techComputer => 'কম্পিউটার';

  @override
  String get techCivil => 'সিভিল';

  @override
  String get techElectrical => 'ইলেক্ট্রিক্যাল';

  @override
  String get techMechanical => 'মেকানিক্যাল';

  @override
  String get techArchitecture => 'আর্কিটেকচার';

  @override
  String get techElectronics => 'ইলেক্ট্রনিক্স';

  @override
  String tabAll(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'সব সার্কুলার ($countString)';
  }

  @override
  String tabJobs(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '💼 চাকরি / জব ($countString)';
  }

  @override
  String tabInternships(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '🎓 ৮ম সেমিস্টার অ্যাটাচমেন্ট ($countString)';
  }

  @override
  String get sortLabel => 'সাজানো:';

  @override
  String get sortNewest => 'সর্বশেষ প্রকাশিত';

  @override
  String get sortDeadline => 'আবেদনের শেষ তারিখ';

  @override
  String get jobTypeInternship => '🎓 ইন্ডাস্ট্রিয়াল অ্যাটাচমেন্ট';

  @override
  String get jobTypeFullTime => '💼 ফুল-টাইম চাকরি';

  @override
  String techBadge(String tech) {
    return '$tech টেকনোলজি';
  }

  @override
  String deadlineLabel(String date) {
    return 'মেয়াদের শেষ: $date';
  }

  @override
  String get applyNow => 'এখনই আবেদন করুন';

  @override
  String get emptyTitle => 'কোন সার্কুলার পাওয়া যায়নি!';

  @override
  String get emptyMessage =>
      'আপনার সার্চ বা ফিল্টারের সাথে মিলে এমন কোন তথ্য এই মুহূর্তে আমাদের ডেটাবেজে নেই। অন্য কী-ওয়ার্ড চেষ্টা করুন।';

  @override
  String get resetFilters => 'সকল ফিল্টার রিসেট করুন';

  @override
  String get errorLoading => 'সার্কুলার লোড করা যায়নি।';

  @override
  String get retry => 'আবার চেষ্টা করুন';

  @override
  String get footerAbout =>
      'বাংলাদেশের সকল সরকারি ও বেসরকারি পলিটেকনিক ইনস্টিটিউটের শিক্ষার্থীদের জন্য ক্যারিয়ার গড়ার এক নির্ভরযোগ্য স্থান।';

  @override
  String get footerPopularTech => 'জনপ্রিয় টেকনোলজি';

  @override
  String get footerImportantLinks => 'গুরুত্বপূর্ণ লিংক';

  @override
  String get footerNocGuide => 'NOC আবেদন গাইড';

  @override
  String get footerPostCircular => 'কোম্পানি সার্কুলার পোস্ট';

  @override
  String get footerBteb => 'BTEB অফিশিয়াল সাইট';

  @override
  String get footerContact => 'যোগাযোগ ও সহায়তা';

  @override
  String get footerContactHint =>
      'পলিটেকনিক লিয়াঁজো ও জব পোস্ট সহায়তার জন্য:';

  @override
  String get footerCopyright => '© ২০২৬ ডিপ্লোমা জব হাব। সর্বস্বত্ব সংরক্ষিত।';

  @override
  String get footerTagline =>
      'পলিটেকনিক শিক্ষার্থীদের ক্যারিয়ার উন্নয়নে নিবেদিত।';

  @override
  String get stepAuthentication =>
      '================================== Authentication ========================';

  @override
  String get authBadge => 'বিটিইবি নিবন্ধিত ও ভেরিফাইড প্ল্যাটফর্ম';

  @override
  String get authHeroTitle =>
      'ডিপ্লোমা প্রকৌশলীদের জন্য সঠিক ক্যারিয়ারের শুরু';

  @override
  String get authHeroSubtitle =>
      'একটি মাত্র অ্যাকাউন্টে আপনার পলিটেকনিকের ৮ম সেমিস্টার অ্যাটাচমেন্ট এবং গ্র্যাজুয়েশন পরবর্তী স্বপ্নালু চাকরি খুঁজে নিন।';

  @override
  String get authFeature1 =>
      'বাংলাদেশ কারিগরি শিক্ষা বোর্ডের ৩৫০+ অ্যাটাচমেন্ট পার্টনার';

  @override
  String get authFeature2 => '১-ক্লিকে ইন্সট্যান্ট পলিটেকনিক সিভি জমা দিন';

  @override
  String get authFeature3 => 'অনলাইন NOC ও রেকমেন্ডেশন লেটার গাইডলাইন';

  @override
  String get demoTitle => 'ডেমো অ্যাকাউন্টে দ্রুত টেস্ট করুন:';

  @override
  String get demoStudent => 'শিক্ষার্থী ডেমো';

  @override
  String get demoCompany => 'কোম্পানি ডেমো';

  @override
  String get demoStudentToast =>
      'শিক্ষার্থী ডেমো তথ্য স্বয়ংক্রিয়ভাবে প্রদান করা হয়েছে।';

  @override
  String get demoCompanyToast =>
      'কোম্পানি ডেমো তথ্য স্বয়ংক্রিয়ভাবে প্রদান করা হয়েছে।';

  @override
  String get tabLogin => 'প্রবেশ করুন (Login)';

  @override
  String get tabRegister => 'নতুন অ্যাকাউন্ট তৈরি (Register)';

  @override
  String get roleStudent => 'ডিপ্লোমা শিক্ষার্থী / গ্র্যাজুয়েট';

  @override
  String get roleCompany => 'নিয়োগকারী প্রতিষ্ঠান';

  @override
  String get fieldEmail => 'ইমেইল ঠিকানা *';

  @override
  String get fieldPassword => 'পাসওয়ার্ড *';

  @override
  String get fieldConfirmPassword => 'পাসওয়ার্ড নিশ্চিত করুন *';

  @override
  String get forgotPassword => 'পাসওয়ার্ড ভুলে গেছেন?';

  @override
  String get rememberMe => 'আমায় মনে রাখুন (Remember me)';

  @override
  String get loginAction => 'লগইন করুন';

  @override
  String get registerAction => 'রেজিস্ট্রেশন সম্পূর্ণ করুন';

  @override
  String get fieldFullName => 'পূর্ণ নাম (Full Name) *';

  @override
  String get fullNameHint => 'ex: মোঃ তানভীর আহম্মেদ';

  @override
  String get fieldPolytechnic => 'পলিটেকনিক ইনস্টিটিউট *';

  @override
  String get selectPolytechnic => 'ইনস্টিটিউট সিলেক্ট করুন';

  @override
  String get fieldDepartment => 'টেকনোলজি/ডিপার্টমেন্ট *';

  @override
  String get polyDpi => 'ঢাকা পলিটেকনিক ইনস্টিটিউট (DPI)';

  @override
  String get polyCpi => 'চট্টগ্রাম পলিটেকনিক (CPI)';

  @override
  String get polyRpi => 'রাজশাহী পলিটেকনিক (RPI)';

  @override
  String get polyBpi => 'বগুড়া পলিটেকনিক (BPI)';

  @override
  String get polySpi => 'সিলেট পলিটেকনিক (SPI)';

  @override
  String get polyFci => 'ফেনী কম্পিউটার ইনস্টিটিউট (FCI)';

  @override
  String get polyOther => 'অন্যান্য প্রাইভেট পলিটেকনিক';

  @override
  String get fieldCompanyName => 'কোম্পানি/প্রতিষ্ঠানের নাম *';

  @override
  String get fieldIndustry => 'ইন্ডাস্ট্রি টাইপ *';

  @override
  String get fieldWebsite => 'অফিশিয়াল ওয়েবসাইট URL';

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
  String get companyRoleLabel => 'অফিশিয়াল নিয়োগকারী';

  @override
  String get pwdHintLength => 'কমপক্ষে ৮ ক্যারেক্টার দিন';

  @override
  String get pwdWeak => 'দুর্বল পাসওয়ার্ড';

  @override
  String get pwdMedium => 'মাঝারি শক্ত পাসওয়ার্ড';

  @override
  String get pwdStrong => 'খুবই শক্তিশালী পাসওয়ার্ড!';

  @override
  String get socialDivider => 'অথবা সোশ্যাল অ্যাকাউন্ট দিয়ে';

  @override
  String get googleSignIn => 'গুগল অ্যাকাউন্ট দিয়ে সহজে সাইন ইন';

  @override
  String get googleVerifying => 'গুগল একাউন্ট দিয়ে যাচাই করা হচ্ছে...';

  @override
  String get googleSuccess => 'গুগল একাউন্ট দিয়ে সফলভাবে প্রবেশ করেছেন!';

  @override
  String get errRequired => 'এই তথ্যটি আবশ্যক';

  @override
  String get errInvalidEmail => 'সঠিক ইমেইল ঠিকানা দিন';

  @override
  String get errPasswordShort => 'পাসওয়ার্ড কমপক্ষে ৮ ক্যারেক্টারের হতে হবে';

  @override
  String get errPasswordMismatch => 'পাসওয়ার্ড দুটি মিলছে না';

  @override
  String get errInvalidUrl => 'সঠিক ওয়েবসাইট URL দিন (https://...)';

  @override
  String get errPolytechnicRequired => 'পলিটেকনিক ইনস্টিটিউট সিলেক্ট করুন';

  @override
  String get loginStudentSuccess =>
      'সফলভাবে প্রবেশ করেছেন! শিক্ষার্থী ড্যাশবোর্ডে স্বাগতম।';

  @override
  String get loginCompanySuccess =>
      'সফলভাবে প্রবেশ করেছেন! কোম্পানি ড্যাশবোর্ডে স্বাগতম।';

  @override
  String get registerSuccess => 'অ্যাকাউন্ট সফলভাবে তৈরি হয়েছে!';

  @override
  String get authFailed => 'প্রবেশ করা যায়নি। আবার চেষ্টা করুন।';

  @override
  String get loggedOut => 'সফলভাবে লগআউট করা হয়েছে।';

  @override
  String get forgotTitle => 'পাসওয়ার্ড রিসেট করুন';

  @override
  String get forgotMessage =>
      'আপনার নিবন্ধিত ইমেইল দিলে আমরা রিসেট লিঙ্ক পাঠিয়ে দেব।';

  @override
  String get forgotEmailHint => 'ইমেইল দিন...';

  @override
  String get cancel => 'বাতিল';

  @override
  String get sendLink => 'লিংক পাঠান';

  @override
  String get resetSent => 'রিসেট লিঙ্ক ইমেইলে পাঠানো হয়েছে!';

  @override
  String get navLogin => 'লগইন / সাইনআপ';

  @override
  String get navDashboard => 'আমার ড্যাশবোর্ড';

  @override
  String get logout => 'লগআউট';

  @override
  String get stepForgot =>
      '================================== Forgot Password ========================';

  @override
  String get resetPasswordTitle => 'পাসওয়ার্ড রিসেট করুন';

  @override
  String get resetPasswordDesc =>
      'আপনার নিবন্ধিত ইমেইল দিন, আমরা একটি রিসেট লিংক পাঠিয়ে দেব।';

  @override
  String get emailAddress => 'ইমেইল ঠিকানা';

  @override
  String get emailHint => 'আপনার ইমেইল লিখুন...';

  @override
  String get close => 'বন্ধ করুন';

  @override
  String resetLinkSent(String email) {
    return 'আমরা $email এ পাসওয়ার্ড রিসেট লিংক পাঠিয়েছি। অনুগ্রহ করে ইনবক্স চেক করুন।';
  }

  @override
  String get setNewPasswordTitle => 'নতুন পাসওয়ার্ড দিন';

  @override
  String get setNewPasswordDesc =>
      'আপনার অ্যাকাউন্টের জন্য একটি নতুন পাসওয়ার্ড বেছে নিন।';

  @override
  String get newPassword => 'নতুন পাসওয়ার্ড';

  @override
  String get resetPasswordButton => 'পাসওয়ার্ড রিসেট করুন';

  @override
  String get passwordResetSuccess =>
      'আপনার পাসওয়ার্ড সফলভাবে রিসেট হয়েছে। এখন সাইন ইন করতে পারবেন।';

  @override
  String get backToLogin => 'সাইন ইনে ফিরে যান';

  @override
  String get otpLabel => 'ভেরিফিকেশন কোড';

  @override
  String get otpSubtitle => 'আপনার ইমেইলে পাঠানো ৬ সংখ্যার কোডটি লিখুন।';

  @override
  String get verifyOtp => 'ভেরিফাই করুন';

  @override
  String get resendOtp => 'আবার কোড পাঠান';

  @override
  String get errInvalidOtp => '৬ সংখ্যার কোড দিন';

  @override
  String get passwordResetSuccessTitle => 'Password updated!';

  @override
  String get sendCode => 'কোড পাঠান';

  @override
  String get back => 'পিছনে';

  @override
  String otpSentTo(String email) {
    return '$email এ পাঠানো ৬ সংখ্যার কোডটি লিখুন।';
  }

  @override
  String get stepProfile =>
      '================================== Student Profile ========================';

  @override
  String get myProfile => 'মাই প্রোফাইল';

  @override
  String get nocGuide => 'NOC গাইড';

  @override
  String get updateCv => 'সিভি আপডেট';

  @override
  String get comingSoon => 'এই ফিচারটি শীঘ্রই আসছে!';

  @override
  String get changeCover => 'কভার চেঞ্জ করুন';

  @override
  String get verifiedStudent => 'ভেরিফাইড স্টুডেন্ট';

  @override
  String get downloadResume => 'রেজুমে ডাউনলোড';

  @override
  String get editProfile => 'প্রোফাইল এডিট';

  @override
  String get copyPublicLink => 'পাবলিক লিংক কপি';

  @override
  String get linkCopied => 'প্রোফাইল লিংক ক্লিপবোর্ডে কপি করা হয়েছে!';

  @override
  String get cvNotUploaded => 'এখনও কোনো সিভি লিংক যোগ করা হয়নি';

  @override
  String get linkOpenFailed => 'লিংকটি খোলা যায়নি';

  @override
  String instituteRoll(String institute, String roll) {
    return '$institute • রোল: $roll';
  }

  @override
  String semesterLabel(String ordinal) {
    return '$ordinal সেমিস্টার';
  }

  @override
  String ordinal(String n) {
    String _temp0 = intl.Intl.selectLogic(n, {
      '1': '১ম',
      '2': '২য়',
      '3': '৩য়',
      '4': '৪র্থ',
      '5': '৫ম',
      '6': '৬ষ্ঠ',
      '7': '৭ম',
      '8': '৮ম',
      'other': '$nম',
    });
    return '$_temp0';
  }

  @override
  String get metricCurrentStatus => 'বর্তমান অবস্থান';

  @override
  String metricStatusValue(String semester) {
    return '$semester (অ্যাটাচমেন্ট)';
  }

  @override
  String get metricCgpa => 'সিজিপিএ (গড় CGPA)';

  @override
  String get metricApplied => 'আবেদনকৃত জব/ইন্টার্ন';

  @override
  String circularsCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countStringটি সার্কুলার',
      zero: 'কোনো সার্কুলার নেই',
    );
    return '$_temp0';
  }

  @override
  String get metricNoc => 'NOC স্ট্যাটাস';

  @override
  String get nocIssued => 'ইস্যু করা হয়েছে';

  @override
  String get nocPending => 'প্রক্রিয়াধীন';

  @override
  String get nocRejected => 'বাতিল';

  @override
  String get tabOverview => 'ওভারভিউ ও বিবরণ';

  @override
  String get tabAcademic => 'শিক্ষাগত যোগ্যতা';

  @override
  String get tabProjects => 'স্কিলস ও প্রজেক্ট';

  @override
  String get tabApplications => 'আবেদন ট্র্যাকার';

  @override
  String get tabCertifications => 'সার্টিফিকেট ও সোশ্যাল';

  @override
  String get aboutMe => 'নিজের সম্পর্কে (Bio)';

  @override
  String get edit => 'এডিট করুন';

  @override
  String get techProficiency => 'প্রধান কারিগরি দক্ষতা (Tech Proficiency)';

  @override
  String get contactInfo => 'যোগাযোগের তথ্য';

  @override
  String get phoneNumber => 'ফোন নম্বর';

  @override
  String get currentAddress => 'বর্তমান ঠিকানা';

  @override
  String get boardInfo => 'কারিগরি শিক্ষা বোর্ড তথ্য';

  @override
  String get boardRoll => 'বোর্ড রোল:';

  @override
  String get registration => 'রেজিস্ট্রেশন:';

  @override
  String get session => 'সেশন:';

  @override
  String get nocLetterNo => 'NOC পত্র নম্বর:';

  @override
  String get resultBreakdown => 'পলিটেকনিক রেজাল্ট ব্রেকডাউন (Semester GPA)';

  @override
  String get colSemester => 'সেমিস্টার';

  @override
  String get colExamYear => 'পরীক্ষার বছর';

  @override
  String get colGpa => 'প্রাপ্ত জিপিএ (GPA)';

  @override
  String get colStatus => 'স্ট্যাটাস';

  @override
  String get passed => 'উত্তীর্ণ';

  @override
  String avgCgpaRange(String from, String to) {
    return 'গড় সিজিপিএ ($from - $to)';
  }

  @override
  String get gradeFirstClass => 'ফার্স্ট ক্লাস অনার্স সমমান';

  @override
  String get sscTitle => 'মাধ্যমিক স্কুল সার্টিফিকেট (SSC / সমমান)';

  @override
  String get schoolName => 'স্কুল নাম:';

  @override
  String get groupBoard => 'গ্রুপ & বোর্ড:';

  @override
  String get passingYearGpa => 'পাসিং ইয়ার & জিপিএ:';

  @override
  String get portfolioTitle => 'প্র্যাকটিক্যাল প্রজেক্ট পোর্টফোলিও';

  @override
  String get portfolioSubtitle =>
      'পলিটেকনিক ক্লাসে ও ব্যক্তিগতভাবে তৈরি প্রজেক্টসমূহ';

  @override
  String get addProject => 'নতুন প্রজেক্ট যোগ করুন';

  @override
  String get newProject => 'নতুন প্রজেক্ট';

  @override
  String get liveDemo => 'লাইভ ডেমো';

  @override
  String get githubCode => 'গিটহাব কোড';

  @override
  String get trackerTitle => 'আবেদনকৃত সার্কুলার ও ইন্টার্নশিপ ট্র্যাকার';

  @override
  String get trackerSubtitle =>
      'আপনার জমাকৃত সকল আবেদনের রিয়েল-টাইম স্ট্যাটাস';

  @override
  String get filter => 'ফিল্টার:';

  @override
  String get filterAll => 'সব আবেদন';

  @override
  String get filterShortlisted => 'শর্ট লিস্টেড';

  @override
  String get filterPending => 'পেন্ডিং';

  @override
  String get filterInterview => 'ইন্টারভিউ নির্ধারিত';

  @override
  String get noApplications => 'কোনো আবেদন পাওয়া যায়নি';

  @override
  String get colCompany => 'কোম্পানি & পদের নাম';

  @override
  String get colType => 'ধরন';

  @override
  String get colAppliedDate => 'আবেদনের তারিখ';

  @override
  String get colCurrentStatus => 'বর্তমান স্ট্যাটাস';

  @override
  String get colAction => 'অ্যাকশন';

  @override
  String get typeAttachment => '🎓 অ্যাটাচমেন্ট';

  @override
  String get typeJob => '💼 চাকরি';

  @override
  String get statusShortlisted => 'শর্ট লিস্টেড';

  @override
  String get statusInterview => 'ইন্টারভিউ নির্ধারিত';

  @override
  String get statusPending => 'রিভিউ পেন্ডিং';

  @override
  String get actionViewMessage => 'মেসেজ দেখুন';

  @override
  String get actionDetails => 'ডিটেইলস';

  @override
  String get actionPleaseWait => 'অপেক্ষা করুন';

  @override
  String get noMessage => 'এখনও কোনো মেসেজ নেই';

  @override
  String get certificatesTitle => 'অর্জিত ট্রেনিং ও কোর্স সার্টিফিকেটসমূহ';

  @override
  String get add => 'যোগ করুন';

  @override
  String get socialTitle => 'সোশ্যাল মিডিয়া ও অনলাইন পোর্টফোলিও লিংক';

  @override
  String get linkedinProfile => 'LinkedIn Profile';

  @override
  String get githubRepos => 'GitHub Repositories';

  @override
  String get editProfileTitle => 'শিক্ষার্থী প্রোফাইল এডিট করুন';

  @override
  String get fullName => 'শিক্ষার্থীর পূর্ণ নাম';

  @override
  String get polytechnicName => 'পলিটেকনিকের নাম';

  @override
  String get technology => 'টেকনোলজি';

  @override
  String get email => 'ইমেইল';

  @override
  String get bioLabel => 'নিজের সম্পর্কে সংক্ষিপ্ত বিবরণ (Bio)';

  @override
  String get save => 'সেভ করুন';

  @override
  String get fieldRequired => 'এই ঘরটি পূরণ করা আবশ্যক';

  @override
  String get invalidEmail => 'সঠিক ইমেইল ঠিকানা দিন';

  @override
  String get invalidUrl => 'সঠিক লিংক দিন';

  @override
  String get profileUpdated => 'প্রোফাইল তথ্য সফলভাবে আপডেট করা হয়েছে!';

  @override
  String get cvDialogTitle => 'গুগোল ড্রাইভ রেজুমে / সিভি লিংক';

  @override
  String get cvLinkLabel => 'Google Drive CV Link';

  @override
  String get cvLinkNote =>
      'লিংকটি অবশ্যই \'Anyone with the link\' ভিউ পারমিশন অন করে দিন।';

  @override
  String get update => 'আপডেট করুন';

  @override
  String get cvUpdated => 'আপনার গুগোল ড্রাইভ সিভি লিংকটি হালনাগাদ করা হয়েছে!';

  @override
  String get addProjectTitle => 'নতুন প্রজেক্ট যুক্ত করুন';

  @override
  String get projectName => 'প্রজেক্টের নাম';

  @override
  String get projectTech => 'ব্যবহৃত টেকনোলজি (কমা দিয়ে লিখুন)';

  @override
  String get projectTechHint => 'ex: HTML, Tailwind, JS';

  @override
  String get projectDesc => 'সংক্ষিপ্ত বিবরণ';

  @override
  String get publish => 'পাবলিশ করুন';

  @override
  String get projectAdded =>
      'নতুন প্রজেক্ট সফলভাবে পোর্টফোলিওতে যোগ করা হয়েছে!';

  @override
  String get nocGuideTitle => 'NOC গাইডলাইন';

  @override
  String get nocGuideBody =>
      'পলিটেকনিকের ইন্ডাস্ট্রিয়াল লিয়াঁজো শাখা থেকে অনুমোদিত NOC পত্রটি অ্যাপ্লাই করার সময় সংলগ্ন করতে হবে।';

  @override
  String nocVerifiedActive(String number) {
    return 'NOC No: $number (Verified Active)';
  }

  @override
  String get somethingWentWrong => 'কিছু একটা সমস্যা হয়েছে। আবার চেষ্টা করুন।';

  @override
  String get stepJobDetails =>
      '================================== Job details ========================';

  @override
  String get appliedBannerTitle => 'আপনি এই সার্কুলারে সফলভাবে আবেদন করেছেন!';

  @override
  String appliedBannerSubtitle(String date, String status) {
    return 'আবেদনের তারিখ: $date | স্ট্যাটাস: $status';
  }

  @override
  String get applicationDetails => 'আবেদন বিবরণী';

  @override
  String typeSemesterAttachment(String semester) {
    return '🎓 $semester অ্যাটাচমেন্ট';
  }

  @override
  String get typeFullTimeJob => '💼 ফুল-টাইম চাকরি';

  @override
  String get verifiedEmployer => 'ভেরিফাইড নিয়োগকারী';

  @override
  String get technologyLabel => 'টেকনোলজি:';

  @override
  String get applied => 'আবেদন সম্পন্ন হয়েছে';

  @override
  String get bookmarkTooltip => 'সেভ করুন';

  @override
  String get shareTooltip => 'শেয়ার করুন';

  @override
  String get hlLocation => 'কর্মস্থল / লোকেশন';

  @override
  String get hlStipend => 'মাসিক স্টাইপেন্ড';

  @override
  String get hlExperience => 'অভিজ্ঞতা / সেমিস্টার';

  @override
  String get hlDeadline => 'আবেদনের ডেডলাইন';

  @override
  String get hlVacancies => 'খালি পদের সংখ্যা';

  @override
  String stipendPerMonth(int amount) {
    final intl.NumberFormat amountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String amountString = amountNumberFormat.format(amount);

    return '৳ $amountString / মাস';
  }

  @override
  String vacanciesCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString টি আসন',
    );
    return '$_temp0';
  }

  @override
  String get roleOverview => 'পদের বিবরণ ও সারসংক্ষেপ (Role Overview)';

  @override
  String get keyResponsibilities =>
      'প্রধান দায়িত্বসমূহ (Key Responsibilities)';

  @override
  String get requirementsTitle => 'শিক্ষাগত যোগ্যতা ও টেকনোলজি শর্তাবলী';

  @override
  String get benefitsTitle => 'সুযোগ-সুবিধা ও প্রণোদনা (Benefits & Perks)';

  @override
  String get requiredDocsTitle => 'আবেদনের প্রয়োজনীয় সংলগ্নী কাগজপত্র';

  @override
  String get summaryTitle => 'সংক্ষেপ সার্কুলার তথ্য';

  @override
  String get sumPublished => 'প্রকাশের তারিখ:';

  @override
  String get sumDeadline => 'আবেদনের শেষ সময়:';

  @override
  String get sumJobType => 'চাকরির ধরণ:';

  @override
  String get sumEducation => 'শিক্ষাগত যোগ্যতা:';

  @override
  String get sumHousing => 'আবাসন সুবিধা:';

  @override
  String get applyOnline => 'এখনই অনলাইনে আবেদন করুন';

  @override
  String get hrTitle => 'এইচআর ডেস্ক ও যোগাযোগ';

  @override
  String get hrEmail => 'অফিসিয়াল এইচআর ইমেইল';

  @override
  String get hrHelpline => 'হেল্পলাইন (সকাল ৯টা-৫টা)';

  @override
  String get hrWebsite => 'ওয়েবসাইট';

  @override
  String get relatedTitle => 'সম্পর্কিত অন্যান্য সার্কুলার';

  @override
  String get applyDialogTitle => 'সার্কুলারে সরাসরি আবেদন করুন';

  @override
  String get cvUploadLabel => 'আপনার আপডেট সিভি (PDF Format) *';

  @override
  String get dropOrBrowse => 'ফাইল ড্রপ করুন অথবা';

  @override
  String get browse => 'ব্রাউজ করুন';

  @override
  String get maxFileSize => 'সর্বোচ্চ ফাইল সাইজ: 5MB (PDF)';

  @override
  String get removeFile => 'ফাইল সরান';

  @override
  String get nocUploadLabel => 'পলিটেকনিক ছাড়পত্র / NOC সংলগ্নী (ঐচ্ছিক)';

  @override
  String get expectedStipend => 'প্রত্যাশিত স্টাইপেন্ড';

  @override
  String get companyDecided => '(কোম্পানি নির্ধারিত)';

  @override
  String get currentSemester => 'বর্তমান সেমিস্টার *';

  @override
  String get coverNoteLabel => 'এইচআর ডেস্কে সংক্ষিপ্ত নোট (Cover Note)';

  @override
  String get coverNoteHint =>
      'কেন আপনি এই পদের জন্য উপযুক্ত এবং আপনার কারিগরি প্রজেক্ট সম্পর্কে কিছু লিখুন...';

  @override
  String get confirmApplication => 'আবেদন কনফার্ম করুন';

  @override
  String get cvRequired => 'সিভি (PDF) সংযুক্ত করুন';

  @override
  String get fileTooLarge => 'ফাইলের সাইজ ৫ এমবির বেশি';

  @override
  String applicantNameRoll(String name, String roll) {
    return '$name (রোল: $roll)';
  }

  @override
  String applicationSubmitted(String company) {
    return 'আপনার আবেদনপত্র $company এইচআর ডেস্কে সফলভাবে জমা হয়েছে!';
  }

  @override
  String get alreadyApplied => 'আপনি ইতিমধ্যেই আবেদন করেছেন!';

  @override
  String get bookmarkSaved =>
      'সার্কুলারটি আপনার বুকমার্ক তালিকায় সেভ করা হয়েছে';

  @override
  String get bookmarkRemoved => 'বুকমার্ক তালিকা থেকে সরানো হয়েছে';

  @override
  String get circularLinkCopied => 'সার্কুলার লিংক কপি করা হয়েছে!';
}
