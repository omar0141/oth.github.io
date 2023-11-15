import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shakosh/main.dart';

class Translations {
  static Map<String, dynamic> data = {};
  static String currentLocale = 'ar';

  static Future init() async {
    currentLocale = preferences.getString("lang") ?? "ar";
    data =
        json.decode(await rootBundle.loadString("assets/$currentLocale.json"));
  }

  static Future setLocale(String lang) async {
    preferences.setString("lang", lang);
    currentLocale = lang;
    data =
        json.decode(await rootBundle.loadString("assets/$currentLocale.json"));
    MyApp.setAppState();
  }

  static Locale getLocale() {
    return Locale(currentLocale);
  }

  static List<Locale> getLocales() {
    return [
      Locale('en'),
      Locale('ar'),
    ];
  }
}

extension Translate on String {
  String get tr {
    return Translations.data[this] ?? this;
  }
}
