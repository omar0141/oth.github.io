//packages
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../controller/lang.dart';
//main
import '../main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../enums.dart';

class Translation {
  static String? currentLocale = 'en';
  static Map? languages;

  static Future<void> init(
    String languagesPath,
  ) async {
    try {
      languages = json.decode(await rootBundle.loadString(languagesPath));
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      String? locale = _pref.getString('locale');
      if (languages != null && languages![locale] != null)
        currentLocale = locale;
      if (locale == 'en')
        Language.setCurrentLang = CurrentLang.en;
      else if (locale == 'ar') Language.setCurrentLang = CurrentLang.ar;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<bool> setLocale(String key) async {
    if (languages != null && languages![key] != null) {
      currentLocale = key;
      if (key == 'en')
        Language.setCurrentLang = CurrentLang.en;
      else if (key == 'ar') Language.setCurrentLang = CurrentLang.ar;
      try {
        final SharedPreferences _pref = await SharedPreferences.getInstance();
        await _pref.setString('locale', currentLocale!);
      } on Exception catch (e) {
        throw e;
      }
      main();
    }
    return true;
  }

  static String get(String key, {String filler = '', String? locale}) {
    if (locale == null) locale = currentLocale;
    if (languages != null &&
        languages![locale] != null &&
        languages![locale][key] != null)
      return (languages![locale][key].toString())
          .replaceAll('<filler>', filler);
    return "n/a";
  }

  static Locale getLocale() {
    return Locale(currentLocale!);
  }

  static List<Locale> getLocales({List<String>? exceptions}) {
    List ls = languages!.keys.toList();
    List<Locale> mls = [];

    for (var i = 0; i < ls.length; i++)
      if (exceptions == null || exceptions.contains(ls[i]) == false)
        mls.add(Locale(ls[i]));

    return mls;
  }
}
