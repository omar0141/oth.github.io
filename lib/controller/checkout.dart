// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shakosh/screens/edit_profile/edit_profile_screen.dart';
import 'package:flutter/Material.dart';
import 'package:shakosh/controller/login.dart';
import 'package:shakosh/screens/paymob.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/translation.dart';
import '../screens/home/home_screen.dart';
import 'Address.dart';
import '../new/Data/Remote/MyApi.dart';
import 'package:http/http.dart' as http;
import 'cart_wishlist.dart';
import 'dependants.dart';
import 'items.dart';

class CheckoutC with ChangeNotifier {
  paymob(double total, val, selected_payment, coupon, mydate, format,
      context) async {
    var url;
    var data;
    var response;
    var responsebody;
    int integration_id = 2852202;
    String api_key =
        'ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6VXhNaUo5LmV5SndjbTltYVd4bFgzQnJJam8xTXprNU9URXNJbU5zWVhOeklqb2lUV1Z5WTJoaGJuUWlMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuaTJRTG9XdDNIT3FnZXlOa2dVZFFxcnNDTHpIa25vb3U0anNtS194N1NoUnBBbjB0c2t0aG53Sl9sWkNRRFN5bkQ5VC1XbGw5TjhjRjV0bVQ5RWNCWnc=';
    url = 'https://accept.paymob.com/api/auth/tokens';
    data = {'api_key': api_key};
    response = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    responsebody = jsonDecode(response.body);
    String token = responsebody['token'].toString();
    url = 'https://accept.paymob.com/api/ecommerce/orders';
    data = {
      "auth_token": token,
      "delivery_needed": "false",
      "amount_cents": (total * 100).toString(),
      "currency": "EGP"
    };
    response = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    responsebody = jsonDecode(response.body);

    url = 'https://accept.paymob.com/api/acceptance/payment_keys';
    data = {
      "auth_token": token,
      "amount_cents": (total * 100).toString(),
      "expiration": 3600,
      "order_id": responsebody['id'].toString(),
      "billing_data": {
        "apartment": "NA",
        "email": Provider.of<LoginC>(context, listen: false)
            .post_login['data']['clientdata']['email']
            .toString(),
        "floor": "NA",
        "first_name": Provider.of<LoginC>(context, listen: false)
            .post_login['data']['clientdata']['first_name']
            .toString(),
        "street": "NA",
        "building": "NA",
        "phone_number":
            "+${Provider.of<LoginC>(context, listen: false).post_login['data']['clientdata']['telephone']}",
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": Provider.of<LoginC>(context, listen: false)
            .post_login['data']['clientdata']['last_name']
            .toString(),
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": integration_id,
      "lock_order_when_paid": "false"
    };

    response = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    responsebody = jsonDecode(response.body);
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PaymobScreen(
        mytoken: responsebody['token'].toString(),
        mydate: mydate,
        myformat: format,
        mynet: total,
        myselected_payment: selected_payment,
        myval: val,
        mycoupon: coupon,
      );
    }));
    log(responsebody.toString());
  }

  checkout(double total, val, selected_payment, coupon, mydate, format, context,
      order, code) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var tel = preferences.getString('tel') ?? '';
    if (tel == '') {
      AwesomeDialog(
          context: context,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          dialogType: DialogType.INFO_REVERSED,
          title: "Please add your phone number",
          btnOkColor: Colors.blue,
          btnOkText: Translation.get('ok'),
          btnOkOnPress: () async {
            Navigator.of(context).pushNamed(edit_profile.routeName);
          }).show();

      return false;
    }

    var url = MyApi.Checkout;
    debugPrint(total.toString());
    var data = {
      'SID': MyApi.SID,
      "CID": user_id,
      "order": order,
      "pickup": val.toString(),
      "payment_method_id": selected_payment,
      "coupon_id": coupon.text,
      "address_date": mydate == null
          ? format.parse(DateTime.now().toString()).toString()
          : mydate.toString()
    };
    String? address_id = preferences.getString('address_id');

    if (val == 1) {
      var addresses =
          Provider.of<MyAddress>(context, listen: false).myaddresses;
      int d = addresses.indexWhere((element) => element.id == address_id);

      var branches =
          Provider.of<GetDependants>(context, listen: false).new_branches;
      int s = branches
          .indexWhere((element) => element['id'] == addresses[d].branche_id);
      if (s == -1) {
        s = branches.indexWhere(
            (element) => element['area_id'] == addresses[d].area_id);
      }
      data["branch_id"] = branches[s]['id'].toString();
    } else {
      data["address_id"] = address_id.toString();
    }
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);

    if (responsebody['status'] == 200) {
      if (order == '0') {
        if (code == 'paymob') {
          await Provider.of<CheckoutC>(context, listen: false).paymob(
              total, val, selected_payment, coupon, mydate, format, context);
        }
      } else {
        AwesomeDialog(
            context: context,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            dialogType: DialogType.SUCCES,
            title: Translation.get('order-done'),
            btnOkColor: Colors.green,
            btnOkText: Translation.get('ok'),
            btnOkOnPress: () async {
              Provider.of<Cart>(context, listen: false).removeall(context);
              Provider.of<Getcategoryitems>(context, listen: false)
                  .getitemscat(null, context, null, null, 0, null);
              Navigator.pushNamed(context, HomeScreen.routeName);
            }).show();
      }
    } else if (responsebody['error'] == 'products_quantity') {
      AwesomeDialog(
          context: context,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          dialogType: DialogType.ERROR,
          title: 'Product Quantity Error',
          btnOkColor: Colors.red,
          btnOkText: Translation.get('ok'),
          btnOkOnPress: () async {
            for (var i = 0; i < responsebody['data'].length; i++) {
              int index = Provider.of<Cart>(context, listen: false)
                  .myitems
                  .indexWhere((element) =>
                      element!.item_no.toString() ==
                      responsebody['data'][i]['product_id'].toString());
              Provider.of<Cart>(context, listen: false).myitems[index]!.error =
                  true;
              if (responsebody['data'][i]['msg'] == 'below_min') {
                Provider.of<Cart>(context, listen: false).myitems[index]!.qty =
                    double.tryParse(responsebody['data'][i]['min'].toString())!;
              } else if (responsebody['data'][i]['msg'] == 'above_max') {
                Provider.of<Cart>(context, listen: false).myitems[index]!.qty =
                    double.tryParse(responsebody['data'][i]['max'].toString())!;
              }
            }
            await Provider.of<Cart>(context, listen: false)
                .batch_cart(true, false);
            Navigator.pushNamed(context, HomeScreen.routeName);
          }).show();
    }

    log(responsebody.toString());
    return responsebody;
  }
}
