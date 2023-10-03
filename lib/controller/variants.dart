// ignore_for_file: non_constant_identifier_names, missing_return

import 'dart:async';
import 'dart:convert';
import 'package:shakosh/controller/MyApi.dart';
import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../helper/translation.dart';
import '../models/Item.dart';
import 'items.dart';

class GetVariants extends ChangeNotifier {
  Map<String, VariantBasis> variants = {};
  List<VariantSelected> selected = [];

  //
  void reset() {
    variants = {};
    selected = [];
  }

  bool _isSelected(String? option_id, String? value_id) {
    return selected.indexWhere(
            (e) => e.basis_id == option_id && e.value_id == value_id) >
        -1;
  }

  //
  Future<Map<String, VariantBasis>> getVars(String? product_id, context) async {
    variants = {};
    selected = [];
    var url = MyApi.ProductVariants;
    var data = {
      'SID': MyApi.SID,
      'product_id': product_id.toString(),
      'stock_only': Provider.of<Getcategoryitems>(context, listen: false)
          .myswitched
          .toString()
    };
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    var res = responsebody['data'];
    //
    List<dynamic>? options = res['options'];
    List<dynamic> products = res['variants'];
    //
    // get current product
    int farouk = products.indexWhere((element) => element['id'] == product_id);
    if (farouk > -1) {
      dynamic curr = products[farouk];
      for (dynamic option in curr['options']) {
        dynamic o = options!.indexWhere((e) => e['id'] == option['basis_id']);
        if (o > -1) {
          dynamic v = options[o]['values']
              .indexWhere((e) => e['id'] == option['value_id']);
          if (v > -1) {
            selected.add(
              VariantSelected(
                options[o]['id'],
                options[o]['name'],
                options[o]['name_alt'],
                options[o]['values'][v]['id'],
                options[o]['values'][v]['name'],
                options[o]['values'][v]['name_alt'],
              ),
            );
          }
        }
      }
      // loop through options
      for (int o = 0; o < options!.length; o++) {
        dynamic option = options[o];
        Map<String, VariantValues> myValues = {};

        // values
        for (int v = 0; v < option['values'].length; v++) {
          dynamic value = options[o]['values'][v];
          dynamic product;
          // case of currently selected
          if (_isSelected(option['id'], value['id'])) {
            product = curr;
          }
          // case of non selected
          else {
            for (dynamic prod in products) {
              bool currOpt = false;
              bool sameOpt = true;
              //
              for (dynamic prodOpt in prod['options']) {
                if (prodOpt['basis_id'] == option["id"] &&
                    prodOpt['value_id'] == value['id']) currOpt = true;

                if (prodOpt['basis_id'] != option["id"] &&
                    !_isSelected(prodOpt['basis_id'], prodOpt['value_id'])) {
                  sameOpt = false;
                }
              }
              //
              if (currOpt == true && sameOpt == true) product = prod;
            }
          }
          //
          if (product != null) {
            myValues[value['id'].toString()] = VariantValues(
              value['id'],
              value['name'],
              value['name_alt'],
              product['id'] == curr['id'],
              Item(
                grp_code: 0,
                name: product[Translation.get('product-name')].toString(),
                qty: 0,
                step: product['step_order_quantity'] == null
                    ? 1
                    : double.parse(product['step_order_quantity']),
                min: product['min_order_quantity'] == null
                    ? 1
                    : double.parse(product['min_order_quantity']),
                max: product['max_order_quantity'] == null
                    ? double.infinity
                    : double.parse(product['max_order_quantity']),
                stock: product['stock'] == null
                    ? 0
                    : double.parse(product['stock']),
                multiplier: product['display_multiplier'] == null
                    ? 0
                    : double.parse(product['display_multiplier']),
                unit: product[Translation.get('unit-name')],
                price: double.parse(product['price']),
                discount_price: double.parse(product['discount_price']),
                image: (product['thumbnail'] == null
                    ? null
                    : MyApi.media + product['thumbnail'].toString()),
                item_no: product['id'].toString(),
                qtys: 1,
                detail: '',
                fav: false,
                equation: product['tax_equation'],
              ),
            );
          }
        }
        //
        if (myValues.isNotEmpty) {
          variants[option['id'].toString()] = VariantBasis(
            option['id'],
            option['name'],
            option['name_alt'],
            option['thumbnail'] == "1",
            myValues,
          );
        }
      }
    }
    notifyListeners();
    return {};
  }
}

//
class VariantBasis {
  String? id;
  String? name;
  String? name_alt;
  bool thumbnail;
  Map<String, VariantValues> values;
  //
  VariantBasis(this.id, this.name, this.name_alt, this.thumbnail, this.values);
}

class VariantValues {
  String? id;
  String? name;
  String? name_alt;
  bool selected;
  Item product;
  //
  VariantValues(this.id, this.name, this.name_alt, this.selected, this.product);
}

class VariantSelected {
  String? basis_id;
  String? basis_name;
  String? basis_name_alt;
  String? value_id;
  String? value_name;
  String? value_name_alt;
  //
  VariantSelected(this.basis_id, this.basis_name, this.basis_name_alt,
      this.value_id, this.value_name, this.value_name_alt);
}
