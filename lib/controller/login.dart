// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_print, prefer_typing_uninitialized_variables
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/Material.dart';
import 'package:shakosh/controller/post_firebase.dart';
import 'package:shakosh/controller/social_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/loading.dart';
import '../helper/translation.dart';
import '../screens/splash/splash_screen.dart';
import 'cart_wishlist.dart';
import 'MyApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginC with ChangeNotifier {
  var post_login;
  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var data = {'SID': MyApi.SID, "CID": user_id};
    var url = MyApi.postLogin;
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    if (responsebody['status'] == 200) {
      debugPrint('success');
      post_login = responsebody;
    } else {
      debugPrint('failed');
    }
  }

  signin(context, password, email, tel, country_code, mytoken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String google_id =
        Provider.of<SocialAuth>(context, listen: false).google_id;
    String? apple_id = Provider.of<SocialAuth>(context, listen: false).apple_id;
    String? facebook_id =
        Provider.of<SocialAuth>(context, listen: false).facebook_id;
    String? social_email =
        Provider.of<SocialAuth>(context, listen: false).social_email;
    String? social_name =
        Provider.of<SocialAuth>(context, listen: false).social_name;
    bool social = Provider.of<SocialAuth>(context, listen: false).social;
    Loading().showloading(context);
    var data = {};
    if (social == true) {
      String? first_name = social_name!.split(' ')[0];
      String? last_name =
          social_name.replaceAll('${social_name.split(' ')[0]} ', '');

      data = {
        'create': '1',
        'SID': MyApi.SID,
        'username': social_email,
        'first_name': first_name,
        'last_name': last_name
      };
      if (facebook_id != '') {
        data['facebook_id'] = facebook_id;
      }
      if (google_id != '') {
        data['google_id'] = google_id;
      }
      if (apple_id != '') {
        data['apple_id'] = apple_id;
      }
    } else {
      data = {
        'SID': MyApi.SID,
        'password': password.text,
      };
      if (email.text.isNotEmpty) {
        data['username'] = email.text;
      }
      if (tel.text.isNotEmpty) {
        data['username'] = '${country_code}${tel.text}';
      }
    }

    var url = MyApi.login;
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(data.toString());
    debugPrint(responsebody.toString());
    if (responsebody['status'] == 200) {
      Provider.of<PostFirebaseC>(context, listen: false).postfirebase(
          responsebody['data']['CID'].toString(), mytoken, context);
      await preferences.setString(
          'user_id', responsebody['data']['CID'].toString());
      if (Provider.of<Cart>(context, listen: false).basket.isNotEmpty) {
        await Provider.of<Cart>(context, listen: false)
            .batch_cart(false, false);
      }
      if (Provider.of<Cart>(context, listen: false).favourites.isNotEmpty) {
        await Provider.of<Cart>(context, listen: false).batch_wishlist();
      }
      await preferences.remove("address");
      Navigator.of(context).pushNamed(SplashScreen.routeName);
    } else {
      debugPrint('failed');
      Navigator.of(context).pop();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: Translation.get("error"),
        desc: Translation.get("sign-in-error"),
        btnOkColor: Colors.red,
        btnOkText: Translation.get("ok"),
        btnOkOnPress: () {},
      ).show();
    }
  }
}
