import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language with ChangeNotifier {
  // language dir
  String languageDirection = 'ltr';

  // language code
  String languageCode = 'en';

  void setLanguage(code, direction) async {
    languageCode = code;
    languageDirection = direction;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('languageCode', languageCode);
    sharedPreferences.setString('languageDirection', languageDirection);
    notifyListeners();
  }

  Future<void> getLanguageDataInLocal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    languageCode = sharedPreferences.getString('languageCode') ?? 'en';
    languageDirection =
        sharedPreferences.getString('languageDirection') ?? 'ltr';
    print(languageCode);
    notifyListeners();
  }

  Map<String, dynamic> get words => _words[languageCode];

// language words
  Map _words = {
    'kr': {

      'language': 'کوردی',
      "change mode": 'گۆرینی دۆخ',
      "dark mode": 'دۆخی تاریک',
      "share": "بەشکردن",
      "download": 'دابەزاندن',
      "favorite": "دڵخواز",
      "all": "گشتی",
      "nature": "سروشت",
      "technology": "تەکنەلۆجیا",
      "animal":'ئاژەڵ',
      "fashion": 'فاشیۆن',
      "baby": "منداڵ",
      "travel": "گەشت",
      "anime": "ئەنیمەی",
      "moon": "مانگ",
      "kurdistan": "کردستان",
      "flag": "ئاڵا",
      "architecture": "شارستانیەت",
      "laptop": "لاپتۆپ",
      'programing':'پرۆگرامینینگ',
      "health & wealth":"سەروتو و تەندروستی",
      "culture":"کەلتور",
      'message':"چاوەڕوانی......",
      "video":' ڤیدیۆکان',
      'favorite video':'ڤیدۆ دڵخوازەکان',
      'favorite photo':'وێنە دڵخوازەکان',
      "photo":'وێنەکان',
      'about':'دەربارە',
      'search to':"گەران بۆ...",
      'send problem':"ناردنی کێشە",
      'wal':'بەرنامەی ۆڵپی',
      'about wal':'ۆڵپی بەرنامەیەکە دەتوانی لەرێگەی سەیری وێنەو ڤیدۆبکەیت و دایبەزێنیت وە هەندێک تایبەتمەندیتریش'
    },
    'en': {
      'language': 'language',
      'change mode': 'Change mode',
      "dark mode": 'Dark mode',
      "share": "share",
      "download": 'download',
      "favorite": "favorite",
      "all": "all",
      "nature": "nature",
      "technology": "technology",
      'programing':'programing',
      "animal":"animal",
      "fashion": 'fashion',
      "baby": "baby",
      "travel": "travel",
      "anime": "anime",
      "moon": "moon",
      "kurdistan": "kurdistan",
      "flag": "flag",
      "architecture": "architecture",
      "laptop": "laptop",
      "health & wealth":"health & wealth",
      "culture":"culture",
      'message':"loading .....",
      "video":'videos',
      "photo":"photos",
      'favorite video':"favorite videos",
      "favorite photo":"favorite photos",
          'about':'about',
      'search to':"search to...",
      'send problem':'send problem',
      'wal':'walpy application',
      'about wal':'walpy is an application for for watching and downloading wallpaper and video with some other futures'
    },
    'ar': {

      'language': 'کوردی',
      "change mode": 'گۆرینی دۆخ',
      "dark mode": 'دۆخی تاریک',
      "share": "بەشکردن",
      "download": 'دابەزاندن',
      "favorite": "دڵخواز",
      "all": "گشتی",
      "nature": "سروشت",
      "technology": "تەکنەلۆجیا",
      "animal":'ئاژەڵ',
      "fashion": 'فاشیۆن',
      "baby": "منداڵ",
      "travel": "گەشت",
      "anime": "ئەنیمەی",
      "moon": "مانگ",
      "kurdistan": "کردستان",
      "flag": "ئاڵا",
      "architecture": "شارستانیەت",
      "laptop": "لاپتۆپ",
      'programing':'پرۆگرامینینگ',
      "health & wealth":"سەروتو و تەندروستی",
      "culture":"کەلتور",
      'message':"چاوەڕوانی......",
      "video":' ڤیدیۆکان',
      'favorite video':'ڤیدۆ دڵخوازەکان',
      'favorite photo':'وێنە دڵخوازەکان',
      "photo":'وێنەکان',
      'about':'دەربارە',
      'search to':"search to...",
      'send problem':"ناردنی کێشە",
      'wal':'walpy application',
      'about wal':'walpy is an application for for watching and downloading wallpaper and video with some other futures'
    }
  };
}
