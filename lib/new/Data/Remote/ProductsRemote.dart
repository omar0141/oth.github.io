import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/snakbars.dart';

class ProductsRemote {
  Future<(int, int, int, List<dynamic>)> getProducts(
      {String? page,
      String? order,
      String? stockOnly,
      String? dealId,
      String? brandId,
      String? categoryId,
      String? search}) async {
    try {
      var url = MyApi.products;
      var data = {"SID": MyApi.SID};
      if (page != null) {
        data["page"] = page;
      }
      if (order != null) {
        data["order"] = order;
      }
      if (stockOnly != null) {
        data["stock_only"] = stockOnly;
      }
      if (dealId != null) {
        data["deal_id"] = dealId;
      }
      if (brandId != null) {
        data["brand_id"] = brandId;
      }
      if (categoryId != null) {
        data["category_id"] = categoryId;
      }
      if (search != null) {
        data["search"] = search;
      }
      print(data);
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Products Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Products Remote Success");
        return (
          (responsebody["data"]["pages"] as int),
          (responsebody["data"]["page"] as int),
          int.parse(responsebody["data"]["results"].toString()),
          responsebody["data"]["products"] as List<dynamic>
        );
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
    return (0, 0, 0, []);
  }
}
