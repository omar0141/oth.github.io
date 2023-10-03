// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print, non_constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/Material.dart';
import 'package:shakosh/controller/post_firebase.dart';
import 'package:shakosh/screens/splash/splash_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/loading.dart';
import '../helper/translation.dart';
import '../screens/home/home_screen.dart';
import '../new/Data/Remote/MyApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterC with ChangeNotifier {
  signup(
      context,
      google_id,
      facebook_id,
      firstname,
      lastname,
      email,
      country_code,
      tel,
      password,
      gender,
      mydate,
      mytoken,
      verified,
      apple_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Loading().showloading(context);
    var data = {
      'SID': MyApi.SID,
      'google_id': google_id,
      'facebook_id': facebook_id,
      'apple_id': apple_id,
      'first_name': firstname.text,
      'last_name': lastname.text,
      'email': email.text,
      'telephone': '${country_code}${tel.text}',
      'password': password.text,
      'gender': gender,
      'birthdate': mydate == null ? '' : DateFormat('yyyy-MM-dd').format(mydate)
    };
    var url = MyApi.register;
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    if (responsebody['status'] == 200) {
      Provider.of<PostFirebaseC>(context, listen: false).postfirebase(
          responsebody['data']['CID'].toString(), mytoken, context);
      debugPrint('success');
      preferences.setString('username', firstname.text);
      preferences.setString('tel', tel.text);
      preferences.setString('user_id', responsebody['data']['CID'].toString());
      await preferences.remove("address");
      Navigator.pushNamed(context, SplashScreen.routeName);
    } else {
      debugPrint('failed');
      AwesomeDialog(
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.ERROR,
        title: Translation.get("error"),
        desc: Translation.get("sign-up-error"),
        btnOkColor: Colors.red,
        btnOkText: Translation.get("ok"),
        btnOkOnPress: () {
          Navigator.pop(context);
          if (verified == false) {
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        },
      ).show();
    }
    debugPrint('valid');
  }
}
