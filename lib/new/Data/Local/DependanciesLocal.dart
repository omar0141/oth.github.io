import 'dart:convert';
import 'dart:developer';
import 'package:shakosh/main.dart';

class DependanciesLocal {
  Future<Map<String, dynamic>> getDependancies() async {
    log("Local");
    return jsonDecode(preferences.getString("dependanciesData") ?? "{}");
  }
}
