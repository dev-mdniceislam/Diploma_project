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
}
