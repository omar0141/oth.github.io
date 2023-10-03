// ignore_for_file: non_constant_identifier_names, avoid_print, empty_catches, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shakosh/controller/items.dart';
import 'package:shakosh/models/Item.dart';
import 'package:http/http.dart' as http;
import '../helper/Ebxhr.dart';
import '../helper/translation.dart';
import '../new/Data/Remote/MyApi.dart';

class Cart with ChangeNotifier {
  List<Item?> myitems = [];
  List<Item?> _favourites = [];
  List<Item> reorder = [];
  String? branch_id;
  List items_id = [];
  List items_qty = [];
  bool select_address = false;
  double _total = 0.00;
  double myendtotal = 0.00;
  double net = 0.00;

  calc_net(tax) {
    net = myendtotal + tax;
    notifyListeners();
  }

  Future add_to_cart(String? product_id, double? cart, int? wishlist) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var url = MyApi.AddToCart;
    var data = {
      'SID': MyApi.SID,
      "CID": user_id.toString(),
      "product_id": product_id.toString(),
    };

    data['quantity'] = cart.toString();
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    return responsebody;
  }

  Future add_to_wishlist(String? product_id, int wishlist) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var url = MyApi.AddToWishlist;
    var data = {
      'SID': MyApi.SID,
      "CID": user_id.toString(),
      "product_id": product_id.toString(),
      "wishlist": wishlist.toString()
    };
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    return responsebody;
  }

  batch_cart(checkout, reorder) async {
    if (reorder == false) {
      for (int i = 0; i < myitems.length; i++) {
        items_id.add(int.tryParse(myitems[i]!.item_no!));
        items_qty.add(myitems[i]!.qty.toInt());
      }
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var data = {
      'SID': MyApi.SID,
      "CID": user_id.toString(),
      'product_id': items_id,
      'quantity': items_qty,
    };
    EbXhr xhr = EbXhr("POST", MyApi.BatchCart, data: data);
    debugPrint(data.toString());
    EbXhrReponse response = await (xhr.send());
    var responsebody = response.bodyJson;
    if (checkout == false) {
      myitems = [];
    }

    debugPrint(responsebody.toString());
    return responsebody;
  }

  batch_wishlist() async {
    List items_id = [];
    List items_fav = [];
    for (int i = 0; i < _favourites.length; i++) {
      items_id.add(int.tryParse(_favourites[i]!.item_no!));
      items_fav.add(_favourites[i]!.fav == false ? 0 : 1);
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var data = {
      'SID': MyApi.SID,
      "CID": user_id.toString(),
      'product_id': items_id,
      'wishlist': items_fav,
    };
    EbXhr xhr = EbXhr("POST", MyApi.BatchWishlist, data: data);
    debugPrint(data.toString());
    EbXhrReponse response = await (xhr.send() as FutureOr<EbXhrReponse>);
    var responsebody = response.bodyJson;
    _favourites = [];
    debugPrint(responsebody.toString());
    return responsebody;
  }

  Future getcart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var url = MyApi.GetCart;
    var data = {'SID': MyApi.SID, 'CID': user_id};

    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    myitems = [];
    myendtotal = 0.00;
    net = 0.00;
    for (int i = 0; i < responsebody['data']['cart'].length; i++) {
      if (responsebody['data']['cart'][i]['quantity'] != null &&
          responsebody['data']['cart'][i]['quantity'] != '0') {
        myitems.add(Item(
            grp_code: responsebody['data']['cart'][i]['category_id'] == null
                ? 0
                : int.parse(responsebody['data']['cart'][i]['category_id']),
            name: responsebody['data']['cart'][i][Translation.get('product-name')]
                .toString(),
            qty: double.parse(responsebody['data']['cart'][i]['quantity']),
            step: responsebody['data']['cart'][i]['step_order_quantity'] == null
                ? 1
                : double.parse(
                    responsebody['data']['cart'][i]['step_order_quantity']),
            min: responsebody['data']['cart'][i]['min_order_quantity'] == null
                ? 1
                : double.parse(
                    responsebody['data']['cart'][i]['min_order_quantity']),
            max: responsebody['data']['cart'][i]['max_order_quantity'] == null
                ? double.infinity
                : double.parse(
                    responsebody['data']['cart'][i]['max_order_quantity']),
            stock:
                responsebody['data']['cart'][i]['stock'] == null ? 0 : double.parse(responsebody['data']['cart'][i]['stock']),
            multiplier: responsebody['data']['cart'][i]['display_multiplier'] == null ? 0 : double.parse(responsebody['data']['cart'][i]['display_multiplier']),
            price: responsebody['data']['cart'][i]['display_multiplier'] == null ? double.parse(responsebody['data']['cart'][i]['price'] ?? '0') : double.parse(responsebody['data']['cart'][i]['price'] ?? '0') * double.parse(responsebody['data']['cart'][i]['display_multiplier']),
            discount_price: responsebody['data']['cart'][i]['display_multiplier'] == null ? double.parse(responsebody['data']['cart'][i]['price'] ?? '0') : double.parse(responsebody['data']['cart'][i]['price'] ?? '0') * double.parse(responsebody['data']['cart'][i]['display_multiplier']),
            image: MyApi.media + responsebody['data']['cart'][i]['thumbnail'].toString(),
            item_no: responsebody['data']['cart'][i]['id'].toString(),
            qtys: 1,
            detail: '',
            fav: false,
            equation: responsebody['data']['cart'][i]['tax_equation'],
            end_animation: true));
        _total =
            (double.parse(responsebody['data']['cart'][i]['price'] ?? '0') *
                double.parse(
                    responsebody['data']['cart'][i]['display_multiplier']) *
                double.parse(responsebody['data']['cart'][i]['quantity']));

        myendtotal += _total;
      }
    }

    notifyListeners();
    return myitems;
  }

  Future getwishlist() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var url = MyApi.GetWishlist;
    var data = {'SID': MyApi.SID, 'CID': user_id};

    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    _favourites = [];
    for (int i = 0; i < responsebody['data']['wishlist'].length; i++) {
      _favourites.add(Item(
          grp_code: responsebody['data']['wishlist'][i]['category_id'] == null
              ? 0
              : int.parse(responsebody['data']['wishlist'][i]['category_id']),
          name: responsebody['data']['wishlist'][i]
                  [Translation.get('product-name')]
              .toString(),
          qty: 0,
          step: responsebody['data']['wishlist'][i]['step_order_quantity'] == null
              ? 1
              : double.parse(
                  responsebody['data']['wishlist'][i]['step_order_quantity']),
          min: responsebody['data']['wishlist'][i]['min_order_quantity'] == null
              ? 1
              : double.parse(
                  responsebody['data']['wishlist'][i]['min_order_quantity']),
          max: responsebody['data']['wishlist'][i]['max_order_quantity'] == null
              ? double.infinity
              : double.parse(
                  responsebody['data']['wishlist'][i]['max_order_quantity']),
          stock: responsebody['data']['wishlist'][i]['stock'] == null ? 0 : double.parse(responsebody['data']['wishlist'][i]['stock']),
          multiplier: responsebody['data']['wishlist'][i]['display_multiplier'] == null ? 0 : double.parse(responsebody['data']['wishlist'][i]['display_multiplier']),
          price: responsebody['data']['wishlist'][i]['display_multiplier'] == null ? double.parse(responsebody['data']['wishlist'][i]['price'] ?? '0') : double.parse(responsebody['data']['wishlist'][i]['price'] ?? '0') * double.parse(responsebody['data']['wishlist'][i]['display_multiplier']),
          discount_price: responsebody['data']['wishlist'][i]['display_multiplier'] == null ? double.parse(responsebody['data']['wishlist'][i]['price'] ?? '0') : double.parse(responsebody['data']['wishlist'][i]['price'] ?? '0') * double.parse(responsebody['data']['wishlist'][i]['display_multiplier']),
          image: MyApi.media + responsebody['data']['wishlist'][i]['thumbnail'].toString(),
          item_no: responsebody['data']['wishlist'][i]['id'].toString(),
          qtys: 1,
          detail: '',
          unit: responsebody['data']['wishlist'][i][Translation.get('unit-name')],
          fav: true,
          equation: responsebody['data']['wishlist'][i]['tax_equation'],
          end_animation: true));
    }

    notifyListeners();
    return myitems;
  }

  Future getcarts() async {
    if (myitems.isEmpty) {
      await getcart();
      notifyListeners();
    }
  }

  Future getwishlists() async {
    if (_favourites.isEmpty) {
      await getwishlist();
      for (int i = 0; i < _favourites.length; i++) {
        for (int d = 0; d < myitems.length; d++) {
          if (myitems[d]!.item_no == _favourites[i]!.item_no) {
            _favourites[i]!.qty = myitems[d]!.qty;
          }
        }
      }
    }
    notifyListeners();
  }

  void add(Item? item, context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    // stock
    double stock = 0;
    if ((item!.stock == null || item.stock == 0) && item.per_order == '1') {
      stock = double.infinity;
    } else if ((item.stock != null && item.stock! > 0)) {
      stock = item.stock ?? 0;
    }
    if (stock < max(item.min, item.step)) stock = 0;
    if (stock == 0) return;
    //

    int index =
        myitems.indexWhere((element) => element!.item_no == item.item_no);
    if (index != -1) {
      if (item.max > myitems[index]!.qty) {
        double addQty =
            min(myitems[index]!.qty + item.step, min(item.max, stock)) -
                myitems[index]!.qty;

        myitems[index]!.qty += addQty;

        try {
          List<Item> items =
              Provider.of<Getcategoryitems>(context, listen: false).getItems;
          int ind =
              items.indexWhere((element) => element.item_no == item.item_no);
          items[ind].qty = myitems[index]!.qty;
        } catch (e) {}

        try {
          List<Item?> favourites =
              Provider.of<Cart>(context, listen: false).favourites;
          int ind1 = favourites
              .indexWhere((element) => element!.item_no == item.item_no);
          favourites[ind1]!.qty = myitems[index]!.qty;
        } catch (e) {}
        try {
          List<Item> searchs =
              Provider.of<Getcategoryitems>(context, listen: false).searchs;
          int ind2 =
              searchs.indexWhere((element) => element.item_no == item.item_no);
          searchs[ind2].qty = myitems[index]!.qty;
        } catch (e) {}
        try {
          List<Item> similiar =
              Provider.of<Getcategoryitems>(context, listen: false).similiar;
          int ind3 =
              similiar.indexWhere((element) => element.item_no == item.item_no);
          similiar[ind3].qty = myitems[index]!.qty;
        } catch (e) {}

        _total =
            ((item.discount_price == 0 ? item.price! : item.discount_price!) *
                addQty);
        double tax = 0;
        if (item.equation != null) {
          Parser p = Parser();
          String newtax = item.equation!.replaceAll('x', '$_total');
          tax = p.parse(newtax).evaluate(EvaluationType.REAL, ContextModel());
        } else {
          tax = 0;
        }

        myendtotal += (_total + tax);
        if (user_id != null)
          add_to_cart(item.item_no, myitems[index]!.qty, null);
      }
    } else {
      item.qty = max(item.min, item.step);
      myitems.add(item);
      _total =
          ((item.discount_price == 0 ? item.price! : item.discount_price!) *
              item.qty);
      double tax = 0;
      if (item.equation != null) {
        Parser p = Parser();
        String newtax = item.equation!.replaceAll('x', '$_total');
        tax = p.parse(newtax).evaluate(EvaluationType.REAL, ContextModel());
      } else {
        tax = 0;
      }
      myendtotal += (_total + tax);
      if (user_id != null) add_to_cart(item.item_no, item.qty, null);
    }
    notifyListeners();
  }

  void remove_qty(Item? item, context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    if (user_id != null) {
      int index =
          myitems.indexWhere((element) => element!.item_no == item!.item_no);
      if (myitems[index]!.qty > myitems[index]!.min) {
        myitems[index]!.qty -= item!.step;
        try {
          List<Item> items =
              Provider.of<Getcategoryitems>(context, listen: false).getItems;
          int ind =
              items.indexWhere((element) => element.item_no == item.item_no);
          items[ind].qty = myitems[index]!.qty;
        } catch (e) {}

        try {
          List<Item?> favourites =
              Provider.of<Cart>(context, listen: false).favourites;
          int ind1 = favourites
              .indexWhere((element) => element!.item_no == item.item_no);
          favourites[ind1]!.qty = myitems[index]!.qty;
        } catch (e) {}
        try {
          List<Item> searchs =
              Provider.of<Getcategoryitems>(context, listen: false).searchs;
          int ind2 =
              searchs.indexWhere((element) => element.item_no == item.item_no);
          searchs[ind2].qty = myitems[index]!.qty;
        } catch (e) {}
        try {
          List<Item> similiar =
              Provider.of<Getcategoryitems>(context, listen: false).similiar;
          int ind3 =
              similiar.indexWhere((element) => element.item_no == item.item_no);
          similiar[ind3].qty = myitems[index]!.qty;
        } catch (e) {}
        _total =
            ((item.discount_price == 0 ? item.price! : item.discount_price!) *
                myitems[index]!.step);
        double tax = 0;
        if (item.equation != null) {
          Parser p = Parser();
          String newtax = item.equation!.replaceAll('x', '$_total');
          tax = p.parse(newtax).evaluate(EvaluationType.REAL, ContextModel());
        } else {
          tax = 0;
        }

        myendtotal -= (_total + tax);
      } else {
        myitems.removeAt(index);
        try {
          List<Item> items =
              Provider.of<Getcategoryitems>(context, listen: false).getItems;
          index =
              items.indexWhere((element) => element.item_no == item!.item_no);
          _total = ((item!.discount_price == 0
                  ? item.price!
                  : item.discount_price!) *
              item.qty);
          double tax = 0;
          if (item.equation != null) {
            Parser p = Parser();
            String newtax = item.equation!.replaceAll('x', '$_total');
            tax = p.parse(newtax).evaluate(EvaluationType.REAL, ContextModel());
          } else {
            tax = 0;
          }

          myendtotal -= (_total + tax);
          items[index].qty = 0;
          items[index].end_animation = false;
        } catch (e) {}

        try {
          List<Item?> favourites =
              Provider.of<Cart>(context, listen: false).favourites;
          int ind1 = favourites
              .indexWhere((element) => element!.item_no == item!.item_no);
          favourites[ind1]!.qty = 0;
          favourites[ind1]!.end_animation = false;
        } catch (e) {}
        try {
          List<Item> searchs =
              Provider.of<Getcategoryitems>(context, listen: false).searchs;
          int ind2 =
              searchs.indexWhere((element) => element.item_no == item!.item_no);
          searchs[ind2].qty = 0;
          searchs[ind2].end_animation = false;
        } catch (e) {}
        try {
          List<Item> similiar =
              Provider.of<Getcategoryitems>(context, listen: false).similiar;
          int ind3 = similiar
              .indexWhere((element) => element.item_no == item!.item_no);
          similiar[ind3].qty = 0;
          similiar[ind3].end_animation = false;
        } catch (e) {}
      }
      notifyListeners();
    } else {
      int index =
          myitems.indexWhere((element) => element!.item_no == item!.item_no);
      if (myitems[index]!.qty > myitems[index]!.min) {
        myitems[index]!.qty -= item!.step;
        try {
          List<Item> items =
              Provider.of<Getcategoryitems>(context, listen: false).getItems;
          int ind =
              items.indexWhere((element) => element.item_no == item.item_no);
          items[ind].qty = myitems[index]!.qty;
        } catch (e) {}

        try {
          List<Item?> favourites =
              Provider.of<Cart>(context, listen: false).favourites;
          int ind1 = favourites
              .indexWhere((element) => element!.item_no == item.item_no);
          favourites[ind1]!.qty = myitems[index]!.qty;
        } catch (e) {}
        try {
          List<Item> searchs =
              Provider.of<Getcategoryitems>(context, listen: false).searchs;
          int ind2 =
              searchs.indexWhere((element) => element.item_no == item.item_no);
          searchs[ind2].qty = myitems[index]!.qty;
        } catch (e) {}
        try {
          List<Item> similiar =
              Provider.of<Getcategoryitems>(context, listen: false).similiar;
          int ind3 =
              similiar.indexWhere((element) => element.item_no == item.item_no);
          similiar[ind3].qty = myitems[index]!.qty;
        } catch (e) {}
        _total =
            ((item.discount_price == 0 ? item.price! : item.discount_price!) *
                myitems[index]!.step);
        double tax = 0;
        if (item.equation != null) {
          Parser p = Parser();
          String newtax = item.equation!.replaceAll('x', '$_total');
          tax = p.parse(newtax).evaluate(EvaluationType.REAL, ContextModel());
        } else {
          tax = 0;
        }

        myendtotal -= (_total + tax);
      } else {
        myitems.removeAt(index);
        try {
          List<Item> items =
              Provider.of<Getcategoryitems>(context, listen: false).getItems;
          index =
              items.indexWhere((element) => element.item_no == item!.item_no);
          _total = ((item!.discount_price == 0
                  ? item.price!
                  : item.discount_price!) *
              item.qty);
          double tax = 0;
          if (item.equation != null) {
            Parser p = Parser();
            String newtax = item.equation!.replaceAll('x', '$_total');
            tax = p.parse(newtax).evaluate(EvaluationType.REAL, ContextModel());
          } else {
            tax = 0;
          }

          myendtotal -= (_total + tax);
          items[index].qty = 0;
          items[index].end_animation = false;
        } catch (e) {}

        try {
          List<Item?> favourites =
              Provider.of<Cart>(context, listen: false).favourites;
          int ind1 = favourites
              .indexWhere((element) => element!.item_no == item!.item_no);
          favourites[ind1]!.qty = 0;
          favourites[ind1]!.end_animation = false;
        } catch (e) {}
        try {
          List<Item> searchs =
              Provider.of<Getcategoryitems>(context, listen: false).searchs;
          int ind2 =
              searchs.indexWhere((element) => element.item_no == item!.item_no);
          searchs[ind2].qty = 0;
          searchs[ind2].end_animation = false;
        } catch (e) {}
        try {
          List<Item> similiar =
              Provider.of<Getcategoryitems>(context, listen: false).similiar;
          int ind3 = similiar
              .indexWhere((element) => element.item_no == item!.item_no);
          similiar[ind3].qty = 0;
          similiar[ind3].end_animation = false;
        } catch (e) {}
      }
      notifyListeners();
    }
  }

  void remove(Item? item, context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    if (user_id != null) {
      add_to_cart(item!.item_no, 0, null);
      int index =
          myitems.indexWhere((element) => element!.item_no == item.item_no);
      myitems.removeAt(index);

      _total =
          ((item.discount_price == 0 ? item.price! : item.discount_price!) *
              item.qty);
      double tax = 0;
      if (item.equation != null) {
        Parser p = Parser();
        String newtax = item.equation!.replaceAll('x', '$_total');
        tax = p.parse(newtax).evaluate(EvaluationType.REAL, ContextModel());
      } else {
        tax = 0;
      }

      myendtotal -= (_total + tax);
      try {
        List<Item> items =
            Provider.of<Getcategoryitems>(context, listen: false).getItems;
        index = items.indexWhere((element) => element.item_no == item.item_no);
        items[index].qty = 0;
        items[index].end_animation = false;
      } catch (e) {}
      try {
        List<Item> searchs =
            Provider.of<Getcategoryitems>(context, listen: false).searchs;
        int ind2 =
            searchs.indexWhere((element) => element.item_no == item.item_no);
        searchs[ind2].qty = 0;
        searchs[ind2].end_animation = false;
      } catch (e) {}

      try {
        List<Item?> favourites =
            Provider.of<Cart>(context, listen: false).favourites;
        int ind1 = favourites
            .indexWhere((element) => element!.item_no == item.item_no);
        favourites[ind1]!.qty = 0;
        favourites[ind1]!.end_animation = false;
      } catch (e) {}
      try {
        List<Item> similiar =
            Provider.of<Getcategoryitems>(context, listen: false).similiar;
        int ind3 =
            similiar.indexWhere((element) => element.item_no == item.item_no);
        similiar[ind3].qty = 0;
        similiar[ind3].end_animation = false;
      } catch (e) {}
      notifyListeners();
    } else {
      int index =
          myitems.indexWhere((element) => element!.item_no == item!.item_no);
      myitems.removeAt(index);
      _total =
          ((item!.discount_price == 0 ? item.price! : item.discount_price!) *
              item.qty);
      double tax = 0;
      if (item.equation != null) {
        Parser p = Parser();
        String newtax = item.equation!.replaceAll('x', '$_total');
        tax = p.parse(newtax).evaluate(EvaluationType.REAL, ContextModel());
      } else {
        tax = 0;
      }

      myendtotal -= (_total + tax);
      try {
        List<Item> items =
            Provider.of<Getcategoryitems>(context, listen: false).getItems;
        index = items.indexWhere((element) => element.item_no == item.item_no);
        items[index].qty = 0;
        items[index].end_animation = false;
      } catch (e) {}
      try {
        List<Item> searchs =
            Provider.of<Getcategoryitems>(context, listen: false).searchs;
        int ind2 =
            searchs.indexWhere((element) => element.item_no == item.item_no);
        searchs[ind2].qty = 0;
        searchs[ind2].end_animation = false;
      } catch (e) {}

      try {
        List<Item?> favourites =
            Provider.of<Cart>(context, listen: false).favourites;
        int ind1 = favourites
            .indexWhere((element) => element!.item_no == item.item_no);
        favourites[ind1]!.qty = 0;
        favourites[ind1]!.end_animation = false;
      } catch (e) {}
      try {
        List<Item> similiar =
            Provider.of<Getcategoryitems>(context, listen: false).similiar;
        int ind3 =
            similiar.indexWhere((element) => element.item_no == item.item_no);
        similiar[ind3].qty = 0;
        similiar[ind3].end_animation = false;
      } catch (e) {}
      notifyListeners();
    }
  }

  void removeall(context) {
    for (int i = 0; i < myitems.length; i++) {
      List<Item> items =
          Provider.of<Getcategoryitems>(context, listen: false).getItems;
      int index =
          items.indexWhere((element) => element.item_no == myitems[i]!.item_no);
      try {
        items[index].qty = 0;
        items[index].end_animation = false;
      } catch (e) {}
    }
    myitems = [];
    _total = 0.00;
    myendtotal = 0.00;
    select_address = false;
    notifyListeners();
  }

  void addfav(Item? item, context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    if (user_id != null) {
      var user_id =
          Provider.of<Getcategoryitems>(context, listen: false).user_id;
      if (user_id != null && user_id != '') {
        int index = _favourites
            .indexWhere((element) => element!.item_no == item!.item_no);
        if (_favourites.contains(item) || index != -1) {
        } else {
          add_to_wishlist(item!.item_no, 1);
          item.fav = true;
          _favourites.add(item);
          notifyListeners();
        }
      }
    } else {
      int index = _favourites
          .indexWhere((element) => element!.item_no == item!.item_no);
      if (_favourites.contains(item) || index != -1) {
      } else {
        item!.fav = true;
        _favourites.add(item);
        notifyListeners();
      }
    }
  }

  void removefav(Item? item, context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    if (user_id != null) {
      int index = 0;
      index = _favourites
          .indexWhere((element) => element!.item_no == item!.item_no);
      add_to_wishlist(item!.item_no, 0);
      _favourites.removeAt(index);
      try {
        List<Item> items =
            Provider.of<Getcategoryitems>(context, listen: false).getItems;
        index = items.indexWhere((element) => element.item_no == item.item_no);
        items[index].fav = false;
      } catch (e) {}
      try {
        List<Item> searchs =
            Provider.of<Getcategoryitems>(context, listen: false).getsearch;
        index =
            searchs.indexWhere((element) => element.item_no == item.item_no);
        searchs[index].fav = false;
      } catch (e) {}
      try {
        List<Item> similiar =
            Provider.of<Getcategoryitems>(context, listen: false).similiar;
        index =
            similiar.indexWhere((element) => element.item_no == item.item_no);
        similiar[index].fav = false;
      } catch (e) {}

      notifyListeners();
    } else {
      int index = 0;
      index = _favourites
          .indexWhere((element) => element!.item_no == item!.item_no);

      _favourites.removeAt(index);
      try {
        List<Item> items =
            Provider.of<Getcategoryitems>(context, listen: false).getItems;
        index = items.indexWhere((element) => element.item_no == item!.item_no);
        items[index].fav = false;
      } catch (e) {}
      try {
        List<Item> searchs =
            Provider.of<Getcategoryitems>(context, listen: false).getsearch;
        index =
            searchs.indexWhere((element) => element.item_no == item!.item_no);
        searchs[index].fav = false;
      } catch (e) {}
      try {
        List<Item> similiar =
            Provider.of<Getcategoryitems>(context, listen: false).similiar;
        index =
            similiar.indexWhere((element) => element.item_no == item!.item_no);
        similiar[index].fav = false;
      } catch (e) {}

      notifyListeners();
    }
  }

  void empty() {
    _favourites = [];
    myitems = [];
    notifyListeners();
  }

  int get count {
    return myitems.length;
  }

  double get totalprice {
    return _total;
  }

  double get endtotal {
    return myendtotal;
  }

  List<Item?> get basket {
    return myitems;
  }

  List<Item?> get favourites {
    return _favourites;
  }
}
