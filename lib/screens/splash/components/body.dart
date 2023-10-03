// ignore_for_file: prefer_const_constructors, await_only_futures, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shakosh/screens/google_map.dart';
import 'package:shakosh/screens/orders/orders_screen.dart';
import 'package:shakosh/screens/pre_sign/pre_sign_screen.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/controller/login.dart';
import 'package:shakosh/models/Item.dart';
import 'package:shakosh/screens/splash/components/splash_content.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shakosh/screens/home/home_screen.dart';
import '../../../controller/Address.dart';
import '../../../new/Data/Remote/MyApi.dart';
import '../../../controller/cart_wishlist.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import '../../../controller/categories.dart';
import '../../../controller/dependants.dart';
import '../../../controller/items.dart';
import '../../details/details_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"": ""},
  ];

  String? first_name = "Username";
  String? last_name = "";
  String? tel = "Phone";
  String? _linkMessage;
  bool _isCreatingLink = false;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      var data =
          jsonDecode(dynamicLinkData.link.queryParameters['item'].toString());
      debugPrint(data['qty'].toString());
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return DetailsScreen(
          itm_no: dynamicLinkData.link.queryParameters['id'],
          itm_name: dynamicLinkData.link.queryParameters['name'],
          price: dynamicLinkData.link.queryParameters['price'],
          item: Item(
            grp_code: int.parse(data['grp_code'] ?? '0'),
            name: data['name'],
            price: data['price'],
            qty: data['qty'],
            image: data['image'],
            item_no: data['item_no'],
            qtys: data['qtys'],
            stock: data['stock'],
            step: data['step'] ?? 1,
            min: data['min'] ?? 1,
            max: data['max'] ?? double.infinity,
            multiplier: data['multiplier'],
            unit: data['unit'],
            discount_price: data['whl_price'],
            detail: data['detail'],
            fav: data['fav'],
            featured: data['featured'],
            per_order: data['per_order'],
            error: data['error'],
          ),
        );
      }));
    }).onError((error) {
      debugPrint('onLink error');
      debugPrint(error.message.toString());
    });

    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      var data = jsonDecode(deepLink.queryParameters['item'].toString());
      debugPrint(deepLink.toString());
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return DetailsScreen(
          itm_no: deepLink.queryParameters['id'],
          itm_name: deepLink.queryParameters['name'],
          price: deepLink.queryParameters['price'],
          item: Item(
            grp_code: int.parse(data['grp_code'] ?? '0'),
            name: data['name'],
            price: data['price'],
            qty: data['qty'],
            image: data['image'],
            item_no: data['item_no'],
            qtys: data['qtys'],
            stock: data['stock'],
            step: data['step'] ?? 1,
            min: data['min'] ?? 1,
            max: data['max'] ?? double.infinity,
            multiplier: data['multiplier'],
            unit: data['unit'],
            discount_price: data['whl_price'],
            detail: data['detail'],
            fav: data['fav'],
            featured: data['featured'],
            per_order: data['per_order'],
            error: data['error'],
          ),
        );
      }));
    }
  }

  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString("user_id");
    String? address = preferences.getString("address");
    debugPrint('this is user_id : ${user_id}');
    Provider.of<GetDependants>(context, listen: false).empty();
    await Provider.of<GetDependants>(context, listen: false).getDependants();
    if (user_id != null) {
      var addresses =
          Provider.of<MyAddress>(context, listen: false).myaddresses;
      if (addresses.isEmpty) {
        await Provider.of<MyAddress>(context, listen: false)
            .getAddresses(context);
        addresses = Provider.of<MyAddress>(context, listen: false).myaddresses;
      }

      var branches =
          Provider.of<GetDependants>(context, listen: false).new_branches;
      if (address == null) {
        for (var i = 0; i < addresses.length; i++) {
          int d = branches.indexWhere(
              (element) => element['id'] == addresses[i].branche_id);
          if (d != -1) {
            MyApi.SID = preferences.getString("branch") ?? branches[d]['SID'];
            MyApi.BranchId =
                preferences.getString("BranchId") ?? addresses[i].branche_id;
            MyApi.AddressId =
                preferences.getString("address_id") ?? addresses[i].id;
            // fuck you ya omar
            await preferences.setString("address", addresses[i].name);
            debugPrint('===================================================');
            debugPrint(MyApi.BranchId.toString());
            debugPrint(MyApi.AddressId.toString());
            Provider.of<Getcategories>(context, listen: false)
                .categories
                .clear();
            Provider.of<Getcategories>(context, listen: false)
                .subcategories
                .clear();
            break;
          }
        }
      } else {
        MyApi.SID = preferences.getString("branch") ??
            'd3hhZmdQdkRrYnlKOktJdmdSWFVQamZZSnRlWDVqZm5wMXc9PQ==';
        MyApi.BranchId = preferences.getString("BranchId") ?? '';
        MyApi.AddressId = preferences.getString("address_id") ?? '';
      }

      debugPrint('===================================================');
      debugPrint(MyApi.BranchId.toString());
      debugPrint(MyApi.AddressId.toString());

      // get user data, fuck you ya omar
      Provider.of<Getcategoryitems>(context, listen: false).user_id = user_id;
      await Provider.of<Cart>(context, listen: false).getcarts();
      await Provider.of<Cart>(context, listen: false).getwishlists();
      await Provider.of<LoginC>(context, listen: false).getData();
      first_name = Provider.of<LoginC>(context, listen: false)
          .post_login['data']['clientdata']['first_name'];
      last_name = Provider.of<LoginC>(context, listen: false).post_login['data']
          ['clientdata']['last_name'];
      tel = Provider.of<LoginC>(context, listen: false).post_login['data']
          ['clientdata']['telephone'];
      await preferences.setString(
          "name", "${first_name ?? ''} ${last_name ?? ''}");
      if (tel != null) {
        await preferences.setString("tel", tel!);
      }
    }

    // after not guest, fuck you ya omar

    Provider.of<Getcategoryitems>(context, listen: false).items = [];
    if (Provider.of<Getcategories>(context, listen: false).categories.isEmpty &&
        Provider.of<Getcategories>(context, listen: false)
            .subcategories
            .isEmpty) {
      await Provider.of<Getcategories>(context, listen: false).getData();
    }

    await Provider.of<Getcategoryitems>(context, listen: false)
        .getitemscat(null, context, null, null, 0, null);
    await Provider.of<Getcategoryitems>(context, listen: false)
        .getCategoryProducts(0);

    debugPrint('object');
    await initDynamicLinks();

    Navigator.pushNamed(context, HomeScreen.routeName);
  }

  @override
  void initState() {
    getpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashContent();
  }
}
