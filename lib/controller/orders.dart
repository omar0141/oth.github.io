// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../new/Data/Remote/MyApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrdersC with ChangeNotifier {
  var orders;
  var orders_details;
  Future getorders() async {
    var data;
    var user_id;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
    var url = MyApi.getOrders;
    data = {'SID': MyApi.SID, "CID": user_id};
    var response = await http
        .post(Uri.parse(url), body: data, headers: {"User-Timezone": "120"});
    var responsebody = jsonDecode(response.body);
    orders = responsebody;
    return responsebody;
  }

  Future delorder(invo) async {
    var data;
    var user_id;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
    var url = MyApi.CancelOrders;
    data = {'SID': MyApi.SID, "CID": user_id, "order_id": invo.toString()};
    var response = await http
        .post(Uri.parse(url), body: data, headers: {"User-Timezone": "120"});
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future getOrdersDetails(invo) async {
    var user_id;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
    var url = MyApi.api + 'public/ecommerce/clients/orders/details';
    var data = {'SID': MyApi.SID, 'CID': user_id, 'order_id': invo.toString()};
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    orders_details = responsebody;
    return responsebody;
  }
}
