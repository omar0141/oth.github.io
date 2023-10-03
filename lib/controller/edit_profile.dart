// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shakosh/controller/Address.dart';
import 'package:shakosh/controller/cart_wishlist.dart';
import 'package:shakosh/screens/pre_sign/pre_sign_screen.dart';
import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/loading.dart';
import '../helper/translation.dart';
import '../screens/profile/profile_screen.dart';
import '../new/Data/Remote/MyApi.dart';
import 'package:intl/intl.dart';

import 'items.dart';

class EditProfileC with ChangeNotifier {
  String gender = '';
  String gender_val = '';
  String? phone = '';
  String? apple_id = '';
  String google_id = '';
  String facebook_id = '';

  getData(firstname, lastname, email, tel, date_val, formatter) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var data = {'SID': MyApi.SID, "CID": user_id};
    var url = MyApi.postLogin;
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    if (responsebody['status'] == 200) {
      debugPrint('success');
      firstname.text = responsebody['data']['clientdata']['first_name'] ?? '';
      lastname.text = responsebody['data']['clientdata']['last_name'] ?? '';
      email.text = responsebody['data']['clientdata']['email'] ?? '';
      phone = responsebody['data']['clientdata']['telephone'] ?? '';
      tel.text = responsebody['data']['clientdata']['telephone'] ?? '';
      facebook_id = responsebody['data']['clientdata']['facebook_id'] ?? '';
      google_id = responsebody['data']['clientdata']['google_id'] ?? '';
      apple_id = responsebody['data']['clientdata']['apple_id'] ?? '';
      gender_val = responsebody['data']['clientdata']['gender'] ?? '';
      date_val.text = formatter
          .format(DateTime.tryParse(responsebody['data']['clientdata']
                  ['birthdate'] ??
              DateTime.now().toString()))
          .toString();
    } else {
      debugPrint('failed');
    }
  }

  change_profile(context, firstname, lastname, email, tel, mydate, mygoogle_id,
      myfacebook_id, myapple_id) async {
    Loading().showloading(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var data;
    data = {
      'SID': MyApi.SID,
      'CID': user_id,
      'first_name': firstname.text,
      'last_name': lastname.text,
      'email': email.text,
      'telephone': '${tel.text}',
      'google_id': mygoogle_id,
      'facebook_id': myfacebook_id,
      'apple_id': myapple_id
    };

    if (gender != '') {
      data['gender'] = gender;
    }
    if (mydate != null) {
      data['birthdate'] = DateFormat('yyyy-MM-dd').format(mydate);
    }
    var url = MyApi.EditProfile;
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    if (responsebody['status'] == 200) {
      debugPrint('success');
      preferences.setString('username', firstname.text);
      preferences.setString('tel', tel.text);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        title: Translation.get("success"),
        desc: Translation.get("edit-profile-success"),
        btnOkColor: Colors.green,
        btnOkText: Translation.get("ok"),
        btnOkOnPress: () {
          Navigator.pushNamed(context, ProfileScreen.routeName);
        },
      ).show();
    } else {
      debugPrint('failed');
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: Translation.get("error"),
        desc: Translation.get("edit-profile-error"),
        btnOkColor: Colors.red,
        btnOkText: Translation.get("ok"),
        btnOkOnPress: () {
          Navigator.of(context).pop();
        },
      ).show();
    }
    debugPrint('valid');
  }

  delete_profile(context) async {
    Loading().showloading(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var data;
    data = {
      'SID': MyApi.SID,
      'CID': user_id,
    };
    var url = MyApi.DeleteProfile;
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    if (responsebody['status'] == 200) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        title: Translation.get("success"),
        desc: "Account Deleted",
        btnOkColor: Colors.green,
        btnOkText: Translation.get("ok"),
        btnOkOnPress: () async {
          Provider.of<MyAddress>(context, listen: false).empty();
          Provider.of<Cart>(context, listen: false).empty();
          Provider.of<Getcategoryitems>(context, listen: false).empty();
          await preferences.clear();
          Navigator.pushNamed(context, PreSignScreen.routeName);
        },
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: Translation.get("error"),
        desc: Translation.get("edit-profile-error"),
        btnOkColor: Colors.red,
        btnOkText: Translation.get("ok"),
        btnOkOnPress: () {
          Navigator.of(context).pop();
        },
      ).show();
    }
  }
}
