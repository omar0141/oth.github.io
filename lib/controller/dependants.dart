// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../helper/translation.dart';
import '../models/Dependants.dart';
import '../new/Data/Remote/MyApi.dart';

class GetDependants extends ChangeNotifier {
  List<Payments> payments = [];
  List<Payments> get getpayments => payments;
  List<Coupons> coupons = [];
  List<Coupons> get getcoupons => coupons;
  List<Taxes> taxes = [];
  List<Taxes> get gettaxes => taxes;
  List countries = [];
  List new_branches = [];
  List cities = [];
  List areas = [];

  Future getDependants() async {
    var url = MyApi.dependants;
    var data = {'SID': MyApi.SID};
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    countries = [];
    new_branches = [];
    cities = [];
    areas = [];
    payments = [];
    coupons = [];
    taxes = [];
    for (int i = 0; i < responsebody['data']['countries'].length; i++) {
      countries.add(responsebody['data']['countries'][i]);
    }
    for (int i = 0; i < responsebody['data']['cities'].length; i++) {
      cities.add(responsebody['data']['cities'][i]);
    }
    for (int i = 0; i < responsebody['data']['areas'].length; i++) {
      areas.add(responsebody['data']['areas'][i]);
    }
    debugPrint('this my branches ${responsebody['data']['branches']}');
    for (int i = 0; i < responsebody['data']['branches'].length; i++) {
      new_branches.add(responsebody['data']['branches'][i]);
    }
    // debugPrint(new_branches.toString());
    debugPrint(responsebody['data']['payments'].toString());
    for (int i = 0; i < responsebody['data']['payments'].length; i++) {
      payments.add(Payments(
          id: responsebody['data']['payments'][i]['id'],
          name: responsebody['data']['payments'][i]['name'],
          code: responsebody['data']['payments'][i]['id'],
          image: responsebody['data']['payments'][i]['icon_data']));
    }
    for (int i = 0; i < responsebody['data']['coupons'].length; i++) {
      coupons.add(Coupons(
          id: int.tryParse(responsebody['data']['coupons'][i]['id']),
          code: responsebody['data']['coupons'][i]['coupon_code'],
          name: responsebody['data']['coupons'][i][Translation.get('cat-name')],
          image: responsebody['data']['coupons'][i]['thumbnail'],
          discount_equation: responsebody['data']['coupons'][i]
              ['discount_equation']));
    }
    for (int i = 0; i < responsebody['data']['taxes'].length; i++) {
      taxes.add(Taxes(
          id: int.tryParse(responsebody['data']['taxes'][i]['id']),
          name: responsebody['data']['taxes'][i][Translation.get('cat-name')],
          image: responsebody['data']['taxes'][i]['thumbnail'],
          tax_equation: responsebody['data']['taxes'][i]['equation']));
    }
    return responsebody;
  }

  void getData() async {
    if (countries.isEmpty) {
      await getDependants();
      notifyListeners();
    }
  }

  void empty() {
    coupons = [];
    taxes = [];
    payments = [];
    countries = [];
    cities = [];
    areas = [];
    new_branches = [];
    notifyListeners();
  }

  search_coupons(coupon) {
    int i = coupons.indexWhere((element) => element.code.toString() == coupon);
    return i;
  }
}
