// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/Material.dart';
import '../components/loading.dart';
import '../helper/translation.dart';
import '../screens/sign_in/sign_in_screen.dart';
import 'MyApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResetPasswordC with ChangeNotifier {
  reset(
    country_code,
    tel,
    password,
    context,
    email,
  ) async {
    Loading().showloading(context);
    var data = {'SID': MyApi.SID};
    if (email.text.isEmpty) {
      data['username'] = '${country_code}${tel.text}';
      data['password'] = password.text;
    }
    if (tel.text.isEmpty) {
      data['username'] = email.text;
    }
    debugPrint(data.toString());
    var url = MyApi.resetPassword;
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    if (responsebody['status'] == 200) {
      Navigator.pushNamed(context, SignInScreen.routeName);
    } else {
      debugPrint('failed');
      AwesomeDialog(
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.ERROR,
        title: Translation.get("error"),
        desc: Translation.get("password-reset-error"),
        btnOkColor: Colors.red,
        btnOkText: Translation.get("ok"),
        btnOkOnPress: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ).show();
    }
  }
}
