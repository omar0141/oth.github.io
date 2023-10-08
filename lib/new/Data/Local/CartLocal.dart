import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Cart/cart_bloc.dart';
import 'package:shakosh/new/Components/snakbars.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:universal_html/html.dart' as html;

class CartLocal {
  void postCart(List<ProductModel> cart) {
    try {
      if (kIsWeb) {
        List<dynamic> cartJson = [];
        for (var element in cart) {
          cartJson.add(element.toJson());
        }
        html.window.localStorage['cart'] = jsonEncode(cartJson);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }

  void getCart({bool setState = false}) {
    try {
      if (kIsWeb) {
        List<dynamic> cartJson =
            jsonDecode(html.window.localStorage['cart'] ?? "[]");
        List<ProductModel> cart = [];
        for (var element in cartJson) {
          cart.add(ProductModel.fromJson(element));
        }
        if (setState) {
          BlocProvider.of<CartBloc>(navigatorKey.currentContext!)
              .add(GetLocalCartEvent(cart: cart));
        } else {
          BlocProvider.of<CartBloc>(navigatorKey.currentContext!).cart = cart;
        }
        log("Local Get Cart Success");
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }
}
