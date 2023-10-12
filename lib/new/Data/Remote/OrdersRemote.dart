import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/snakbars.dart';

class OrdersRemote {
  Future<List<dynamic>> getOrders() async {
    try {
      var url = MyApi.getOrders;
      var data = {
        "SID": MyApi.SID,
        "CID": MyApi.UID,
      };
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Get Orders Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Get Orders Remote Success");
        return responsebody["data"];
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
    return [];
  }

  Future<List<dynamic>> getOrderDetails({required String orderId}) async {
    try {
      var url = MyApi.getOrderDetails;
      var data = {"SID": MyApi.SID, "CID": MyApi.UID, "order_id": orderId};
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Get Order Details Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Get Order Details Remote Success");
        return responsebody["data"]["products"];
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
    return [];
  }
}
