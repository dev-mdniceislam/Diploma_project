import '../gen/assets_gen.dart';

abstract class AppConstants {
  AppConstants._();

  static const schoolName = 'গড়েয়া ইসলামী একাডেমী';
  static const schoolSubTitle = 'হে রব আমাকে জ্ঞান দাও';

  static const footerPromoteLeft =
      "© ২০২৬ গড়েয়া ইসলামী একাডেমী | সর্বস্বত্ব সংরক্ষিত";
  static const footerPromoteRight =
      "Developed by Nice Islam(Software Developer)";
  static const footerSubTitle =
      "গড়ৈয়া ইসলামী একাডেমী একটি আধুনিক ও দ্বীনি শিক্ষার অনন্য সমন্বয়ে গড়া শিক্ষাপ্রতিষ্ঠান। শিক্ষার্থীদের সুশিক্ষা, চরিত্র গঠন এবং নৈতিকতার মেলবন্ধনে একটি উজ্জ্বল ভবিষ্যৎ গড়ে তোলাই আমাদের মূল লক্ষ্য।";

  static const schoolAddress = 'গড়েয়া, ঠাকুরগাঁও সদর, ঠাকুরগাঁও - ৫১০০';
  static const schoolPhone = '01712-345678';
  static const schoolEmail = 'gariaislamicacademy@gmail.com';
  static const facebookUrl =
      'https://www.facebook.com/profile.php?id=61568970557098';
  static const youtubeUrl = 'https://youtube.com';
  static const twitterUrl = 'https://twitter.com';
  static const telegramUrl = 'https://t.me';

  // google map url
  static const googleMapUrl =
      "https://www.google.com/maps/dir/?api=1&destination=26.0435173584623,88.59603524212436";

  static final List<Map<String, dynamic>> linkIcon = [
    {
      "name": "facebook",
      "icon": Assets.icons.facebook,
    },
    {
      "name": "youtube",
      "icon": Assets.icons.youtube,
    },
    {
      "name": "linkedin",
      "icon": Assets.icons.linkedin,
    },
    {
      "name": "twitter",
      "icon": Assets.icons.twiter,
    },
    {
      "name": "instagram",
      "icon": Assets.icons.instagram,
    },
  ];

  static const List<String> contactMessageSubject = [
    'ভর্তি সংক্রান্ত তথ্য',
    'ফি এবং পেমেন্ট',
    'সাধারণ জিজ্ঞাসাবাদ',
    'অন্যান্য',
  ];
}
