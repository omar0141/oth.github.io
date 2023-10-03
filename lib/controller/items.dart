// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shakosh/models/Item.dart';
import 'package:http/http.dart' as http;
import '../helper/translation.dart';
import 'cart_wishlist.dart';
import 'MyApi.dart';

class Getcategoryitems extends ChangeNotifier {
  List<Item> get getItems => items;
  List<Item> get getsearch => searchs;
  List<Item> get getsimiliar => similiar;
  List<Item> items = [];
  List<Item> searchs = [];
  List<Item> similiar = [];
  List<Item> category_products = [];
  var user_id;
  int? pages = 0;
  int? cPage = 1;
  bool list = true;
  bool pageintaion = false;
  bool isfav = false;
  bool loading = false;
  int? catgeory_id;
  String? sort;
  int myswitched = 0;

  Future getSimiliar(String? product_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString('user_id');
    var url = MyApi.ProductSimilars;
    var data = {
      'SID': MyApi.SID,
      'product_id': product_id.toString(),
      'stock_only': myswitched.toString(),
    };
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    similiar = [];
    for (int i = 0; i < responsebody['data']['products'].length; i++) {
      similiar.add(Item(
          grp_code: 0,
          name: responsebody['data']['products'][i][Translation.get('product-name')]
              .toString(),
          qty: 0,
          step: responsebody['data']['products'][i]['step_order_quantity'] == null
              ? 1
              : double.parse(
                  responsebody['data']['products'][i]['step_order_quantity']),
          min: responsebody['data']['products'][i]['min_order_quantity'] == null
              ? 1
              : double.parse(
                  responsebody['data']['products'][i]['min_order_quantity']),
          max: responsebody['data']['products'][i]['max_order_quantity'] == null
              ? double.infinity
              : double.parse(
                  responsebody['data']['products'][i]['max_order_quantity']),
          stock: responsebody['data']['products'][i]['stock'] == null
              ? 0
              : double.parse(responsebody['data']['products'][i]['stock']),
          multiplier: responsebody['data']['products'][i]['display_multiplier'] == null ? 0 : double.parse(responsebody['data']['products'][i]['display_multiplier']),
          unit: responsebody['data']['products'][i][Translation.get('unit-name')],
          price: double.parse(responsebody['data']['products'][i]['price'] ?? '0'),
          discount_price: double.parse(responsebody['data']['products'][i]['discount_price'] ?? '0'),
          image: (responsebody['data']['products'][i]['thumbnail'] == null ? '' : MyApi.media + responsebody['data']['products'][i]['thumbnail'].toString()),
          item_no: responsebody['data']['products'][i]['id'].toString(),
          qtys: 1,
          detail: '',
          fav: false,
          equation: responsebody['data']['products'][i]['tax_equation']));
    }
    return similiar;
  }

  Future getCategoryProducts(stock_only) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString('user_id');
    var url = MyApi.CategoryProducts;
    var data = {
      'SID': MyApi.SID,
      'stock_only': stock_only.toString(),
    };
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    category_products = [];
    // log(responsebody['data']['products'].toString());
    for (int i = 0; i < responsebody['data']['products'].length; i++) {
      category_products.add(Item(
          grp_code:
              int.parse(responsebody['data']['products'][i]['category_id']),
          name: responsebody['data']['products'][i]
                  [Translation.get('product-name')]
              .toString(),
          qty: 0,
          step: responsebody['data']['products'][i]['step_order_quantity'] == null
              ? 1
              : double.parse(
                  responsebody['data']['products'][i]['step_order_quantity']),
          min: responsebody['data']['products'][i]['min_order_quantity'] == null
              ? 1
              : double.parse(
                  responsebody['data']['products'][i]['min_order_quantity']),
          max: responsebody['data']['products'][i]['max_order_quantity'] == null
              ? double.infinity
              : double.parse(
                  responsebody['data']['products'][i]['max_order_quantity']),
          stock: responsebody['data']['products'][i]['stock'] == null ? 0 : double.parse(responsebody['data']['products'][i]['stock']),
          multiplier: responsebody['data']['products'][i]['display_multiplier'] == null ? 0 : double.parse(responsebody['data']['products'][i]['display_multiplier']),
          unit: responsebody['data']['products'][i][Translation.get('unit-name')],
          price: double.parse(responsebody['data']['products'][i]['price'] ?? '0' ?? '0'),
          discount_price: double.parse(responsebody['data']['products'][i]['discount_price'] ?? '0'),
          image: (responsebody['data']['products'][i]['thumbnail'] == null ? '' : MyApi.media + responsebody['data']['products'][i]['thumbnail'].toString()),
          item_no: responsebody['data']['products'][i]['id'].toString(),
          qtys: 1,
          detail: '',
          fav: false,
          featured: responsebody['data']['products'][i]['featured'],
          equation: responsebody['data']['products'][i]['tax_equation']));
    }
    notifyListeners();
    return category_products;
  }

  Future getData(int? selected_cat, int? page, search, stock_only, deal) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString('user_id');
    loading = true;
    notifyListeners();
    var url = MyApi.Products;
    var data = {
      // 'search': '1',
      'SID': MyApi.SID,
      'stock_only': stock_only.toString(),
    };

    if (selected_cat != null) {
      data['category_id'] = selected_cat.toString();
    }
    if (deal != null) {
      data['deal_id'] = deal.toString();
    }
    if (sort != null) {
      data['order'] = sort.toString();
    }
    if (search != null) {
      data['search'] = search.toString();
    }
    if (page != null) {
      data['page'] = page.toString();
    }

    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(data.toString());
    debugPrint(responsebody.toString());
    if (search != null) {
      searchs = [];
    } else {
      items = [];
    }

    for (int i = 0; i < responsebody['data']['products'].length; i++) {
      if (search != null) {
        searchs.add(Item(
            grp_code: 0,
            name: responsebody['data']['products'][i]
                    [Translation.get('product-name')]
                .toString(),
            qty: 0,
            step: responsebody['data']['products'][i]['step_order_quantity'] == null
                ? 1
                : double.parse(
                    responsebody['data']['products'][i]['step_order_quantity']),
            min: responsebody['data']['products'][i]['min_order_quantity'] == null
                ? 1
                : double.parse(
                    responsebody['data']['products'][i]['min_order_quantity']),
            max: responsebody['data']['products'][i]['max_order_quantity'] == null
                ? double.infinity
                : double.parse(
                    responsebody['data']['products'][i]['max_order_quantity']),
            stock: responsebody['data']['products'][i]['stock'] == null ? 0 : double.parse(responsebody['data']['products'][i]['stock']),
            multiplier: responsebody['data']['products'][i]['display_multiplier'] == null ? 0 : double.parse(responsebody['data']['products'][i]['display_multiplier']),
            unit: responsebody['data']['products'][i][Translation.get('unit-name')],
            price: double.parse(responsebody['data']['products'][i]['price'] ?? '0'),
            discount_price: double.parse(responsebody['data']['products'][i]['discount_price'] ?? '0'),
            image: (responsebody['data']['products'][i]['thumbnail'] == null ? '' : MyApi.media + responsebody['data']['products'][i]['thumbnail'].toString()),
            item_no: responsebody['data']['products'][i]['id'].toString(),
            qtys: 1,
            detail: '',
            fav: false,
            featured: responsebody['data']['products'][i]['featured'],
            per_order: responsebody['data']['products'][i]['per_order'],
            equation: responsebody['data']['products'][i]['tax_equation']));
      } else {
        items.add(Item(
            grp_code: selected_cat == null
                ? 0
                : int.parse(responsebody['data']['products'][i]['category_id']),
            name: responsebody['data']['products'][i]
                    [Translation.get('product-name')]
                .toString(),
            qty: 0,
            step: responsebody['data']['products'][i]['step_order_quantity'] == null
                ? 1
                : double.parse(
                    responsebody['data']['products'][i]['step_order_quantity']),
            min: responsebody['data']['products'][i]['min_order_quantity'] == null
                ? 1
                : double.parse(
                    responsebody['data']['products'][i]['min_order_quantity']),
            max: responsebody['data']['products'][i]['max_order_quantity'] == null
                ? double.infinity
                : double.parse(
                    responsebody['data']['products'][i]['max_order_quantity']),
            stock: responsebody['data']['products'][i]['stock'] == null || responsebody['data']['products'][i]['visible_stock'] == 0 ? 0 : double.parse(responsebody['data']['products'][i]['stock']),
            multiplier: responsebody['data']['products'][i]['display_multiplier'] == null ? 0 : double.parse(responsebody['data']['products'][i]['display_multiplier']),
            unit: responsebody['data']['products'][i][Translation.get('unit-name')],
            price: double.parse(responsebody['data']['products'][i]['price'] ?? '0'),
            discount_price: double.parse(responsebody['data']['products'][i]['discount_price'] ?? '0'),
            image: (responsebody['data']['products'][i]['thumbnail'] == null ? '' : MyApi.media + responsebody['data']['products'][i]['thumbnail'].toString()),
            item_no: responsebody['data']['products'][i]['id'].toString(),
            qtys: 1,
            detail: '',
            fav: false,
            featured: responsebody['data']['products'][i]['featured'],
            per_order: responsebody['data']['products'][i]['per_order'],
            equation: responsebody['data']['products'][i]['tax_equation']));
      }
    }

    pages = responsebody['data']['pages'];
    cPage = responsebody['data']['page'];
    loading = false;
    notifyListeners();

    return items;
  }

  Future getsimiliars(context, String? product_id) async {
    await getSimiliar(product_id).then((value) {
      for (int i = 0; i < similiar.length; i++) {
        for (int d = 0;
            d < Provider.of<Cart>(context, listen: false).basket.length;
            d++) {
          if (Provider.of<Cart>(context, listen: false).basket[d]!.item_no ==
              similiar[i].item_no) {
            similiar[i].qty =
                Provider.of<Cart>(context, listen: false).basket[d]!.qty;
            similiar[i].end_animation = true;
          }
        }
        for (int f = 0;
            f < Provider.of<Cart>(context, listen: false).favourites.length;
            f++) {
          if (Provider.of<Cart>(context, listen: false)
                  .favourites[f]!
                  .item_no ==
              similiar[i].item_no) {
            similiar[i].fav =
                Provider.of<Cart>(context, listen: false).favourites[f]!.fav;
          }
        }
      }
      notifyListeners();
    });
    return 0;
  }

  Future getitemscat(
      int? select_cat, context, int? pag, search, stock_only, deal) async {
    await getData(select_cat, pag, search, stock_only, deal).then((value) {
      for (int i = 0; i < items.length; i++) {
        for (int d = 0;
            d < Provider.of<Cart>(context, listen: false).basket.length;
            d++) {
          if (Provider.of<Cart>(context, listen: false).basket[d]!.item_no ==
              items[i].item_no) {
            items[i].qty =
                Provider.of<Cart>(context, listen: false).basket[d]!.qty;
            items[i].end_animation = true;
          }
        }
        for (int f = 0;
            f < Provider.of<Cart>(context, listen: false).favourites.length;
            f++) {
          if (Provider.of<Cart>(context, listen: false)
                  .favourites[f]!
                  .item_no ==
              items[i].item_no) {
            items[i].fav =
                Provider.of<Cart>(context, listen: false).favourites[f]!.fav;
          }
        }
      }
    });
    catgeory_id = select_cat;
    pageintaion = true;
    notifyListeners();
  }

  void empty() {
    items = [];
    notifyListeners();
  }
}
