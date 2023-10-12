// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/Material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/loading.dart';
import '../helper/translation.dart';
import '../screens/home/home_screen.dart';
import 'dart:convert';
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:http/http.dart' as http;

class ChangePasswordC with ChangeNotifier {
  change_password(context, password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    Loading().showloading(context);
    var data = {'SID': MyApi.SID, "CID": user_id, "password": password.text};
    var url = MyApi.changePassword;
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    if (responsebody['status'] == 200) {
      debugPrint('success');
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        title: Translation.get("success"),
        desc: Translation.get("password-change-success"),
        btnOkColor: Colors.green,
        btnOkText: Translation.get("ok"),
        btnOkOnPress: () {
          Navigator.pushNamed(context, HomeScreen.routeName);
        },
      ).show();
    } else {
      debugPrint('failed');
    }
  }
}
