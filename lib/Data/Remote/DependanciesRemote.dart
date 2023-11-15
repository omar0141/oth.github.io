import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shakosh/Data/Remote/MyApi.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Components/snakbars.dart';

class DependanciesRemote {
  Future getHomeDependancies() async {
    try {
      var url = MyApi.home;
      var data = {"SID": MyApi.SID};
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Home Dependancies Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Home Dependancies Remote Success");
        preferences.setString(
            "dependanciesHomeData", jsonEncode(responsebody["data"]));
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }

  Future getDependancies() async {
    try {
      var url = MyApi.dependants;
      var data = {"SID": MyApi.SID};
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Dependancies Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Dependancies Remote Success");
        preferences.setString(
            "dependanciesData", jsonEncode(responsebody["data"]));
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }
}
