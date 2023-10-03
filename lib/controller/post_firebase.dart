// ignore_for_file: non_constant_identifier_names, avoid_print
import 'package:flutter/Material.dart';
import '../screens/home/home_screen.dart';
import '../new/Data/Remote/MyApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostFirebaseC with ChangeNotifier {
  postfirebase(user_id, mytoken, context) async {
    var data = {
      'SID': MyApi.SID,
      'CID': user_id,
      'token': 'mytoken',
    };
    var url = MyApi.postFirebase;
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    if (responsebody['status'] == 200) {
      //   Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }
}
