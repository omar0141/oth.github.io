import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/new/Config/Utils/Ebxhr.dart';
import 'package:shakosh/new/Bloc/Cart/cart_bloc.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/snakbars.dart';

class CartRemote {
  Future batchCart() async {
    try {
      List<ProductModel> cart =
          BlocProvider.of<CartBloc>(navigatorKey.currentContext!).cart;
      if (cart.isNotEmpty) {
        List<String> productsId = [];
        List<String> productsQty = [];
        for (var item in cart) {
          productsId.add(item.id ?? "");
          productsQty.add(item.cart.toString());
        }
        var url = MyApi.batchCart;
        var data = {
          "SID": MyApi.SID,
          "CID": MyApi.UID,
          "product_id": productsId,
          "quantity": productsQty
        };
        EbXhr xhr = EbXhr("POST", url, data: data);
        EbXhrReponse response = await (xhr.send());
        var responsebody = response.bodyJson;
        log("Batch Cart Remote");
        if (responsebody == null) {
          MySnackBar()
              .errorSnack(navigatorKey.currentContext, "Server Error", true);
        } else if (responsebody["status"] == 200) {
          log("Batch Cart Remote Success");
          BlocProvider.of<CartBloc>(navigatorKey.currentContext!)
              .add(GetRemoteCartEvent());
        } else {
          MySnackBar().errorSnack(
              navigatorKey.currentContext, responsebody.toString(), true);
        }
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }

  Future<List<dynamic>> getCart() async {
    try {
      var url = MyApi.getCart;
      var data = {
        "SID": MyApi.SID,
        "CID": MyApi.UID,
      };
      EbXhr xhr = EbXhr("POST", url, data: data);
      EbXhrReponse response = await (xhr.send());
      var responsebody = response.bodyJson;
      log("Get Cart Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Get Cart Remote Success");
        return responsebody["data"]["cart"];
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
    return [];
  }

  Future<bool> manageCart(
      {required String productId, required String productQty}) async {
    try {
      if (MyApi.UID != "") {
        var url = MyApi.manageCart;
        var data = {
          "SID": MyApi.SID,
          "CID": MyApi.UID,
          "product_id": productId,
          "quantity": productQty
        };
        EbXhr xhr = EbXhr("POST", url, data: data);
        EbXhrReponse response = await (xhr.send());
        var responsebody = response.bodyJson;
        log("manage Cart Remote");
        if (responsebody == null) {
          MySnackBar()
              .errorSnack(navigatorKey.currentContext, "Server Error", true);
        } else if (responsebody["status"] == 200) {
          log("manage Cart Remote Success");
          return true;
        } else {
          MySnackBar().errorSnack(
              navigatorKey.currentContext, responsebody.toString(), true);
        }
      } else {
        return true;
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
    return false;
  }

  Future<bool> checkout(
      {required String paymentId,
      required String pickup,
      required String addressId,
      String? branchId,
      required String order}) async {
    try {
      var url = MyApi.checkout;
      var data = {
        "SID": MyApi.SID,
        "CID": MyApi.UID,
        "payment_method_id": paymentId,
        "pickup": pickup,
        "order": order
      };
      if (branchId == null) {
        data["address_id"] = addressId;
      } else {
        data["branch_id"] = branchId;
      }
      EbXhr xhr = EbXhr("POST", url, data: data);
      EbXhrReponse response = await (xhr.send());
      var responsebody = response.bodyJson;
      log("Checkout Cart Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Checkout Cart Remote Success");
        MySnackBar()
            .successSnack(navigatorKey.currentContext, "checkout-success");
        return true;
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
    return false;
  }
}
