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
  String get applyNow => 'আবেদন করুন';

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
}
