import 'dart:convert';
import 'dart:developer';
import 'package:shakosh/main.dart';

class DependanciesLocal {
  Future<Map<String, dynamic>> getHomeDependancies() async {
    log("Home Local Dependancies Success");
    return jsonDecode(preferences.getString("dependanciesHomeData") ?? "{}");
  }

  Future<Map<String, dynamic>> getDependancies() async {
    log("Local Dependancies Success");
    return jsonDecode(preferences.getString("dependanciesData") ?? "{}");
  }
}
