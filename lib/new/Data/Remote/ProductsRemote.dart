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
      required String count,
      String? search}) async {
    try {
      var url = MyApi.products;
      var data = {"SID": MyApi.SID, "thresh": count};
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

  Future<(List<dynamic>, dynamic)> getProductDetails(String? productId) async {
    try {
      var url = MyApi.productDetails;
      var data = {"SID": MyApi.SID, "product_id": productId ?? ""};
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Product Details Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Product Details Remote Success");
        return (
          responsebody["data"]["media"] as List,
          responsebody["data"]["product"]
        );
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
    return ([], {});
  }

  Future<List<dynamic>> getSimilarProducts(String? productId) async {
    try {
      var url = MyApi.productSimilars;
      var data = {"SID": MyApi.SID, "product_id": productId ?? ""};
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Product Similars Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Product Similars Remote Success");
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
