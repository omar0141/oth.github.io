import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/cart/cart_bloc.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:universal_html/html.dart' as html;

class CartLocal {
  void postCart(List<ProductModel> cart) {
    List<dynamic> cartJson = [];
    for (var element in cart) {
      cartJson.add(element.toJson());
    }
    html.window.localStorage['cart'] = jsonEncode(cartJson);
  }

  void getCart({bool setState = false}) {
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
  }
}
