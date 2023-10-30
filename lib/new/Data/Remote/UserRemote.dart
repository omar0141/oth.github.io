import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shakosh/new/Bloc/Address/address_bloc.dart';
import 'package:shakosh/new/Bloc/Cart/cart_bloc.dart';
import 'package:shakosh/new/Bloc/Favourite/favourite_bloc.dart';
import 'package:shakosh/new/Bloc/User/user_bloc.dart';
import 'package:shakosh/new/Data/Remote/AddressesRemote.dart';
import 'package:shakosh/new/Data/Remote/CartRemote.dart';
import 'package:shakosh/new/Data/Remote/FavouriteRemote.dart';
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/snakbars.dart';
import 'package:shakosh/new/Screens/Home/HomeScreen.dart';

class UserRemote {
  Future login({
    String? username,
    String? password,
    String? google_id,
    String? facebook_id,
    String? apple_id,
  }) async {
    try {
      var url = MyApi.login;
      var data = {"SID": MyApi.SID};
      if (google_id != null) {
        data["google_id"] = google_id;
      }
      if (facebook_id != null) {
        data["facebook_id"] = facebook_id;
      }
      if (apple_id != null) {
        data["apple_id"] = apple_id;
      }
      if (username != null) {
        data["username"] = username;
      }
      if (password != null) {
        data["password"] = password;
      }
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Login Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Login Remote Success");
        MyApi.UID = responsebody["data"]["CID"];
        preferences.setString("id", MyApi.UID);
        if (BlocProvider.of<CartBloc>(navigatorKey.currentContext!)
            .cart
            .isEmpty) {
          BlocProvider.of<CartBloc>(navigatorKey.currentContext!)
              .add(GetRemoteCartEvent());
        } else {
          await CartRemote().batchCart();
        }
        if (BlocProvider.of<FavouriteBloc>(navigatorKey.currentContext!)
            .favourite
            .isEmpty) {
          BlocProvider.of<FavouriteBloc>(navigatorKey.currentContext!)
              .add(GetRemoteFavouriteEvent());
        } else {
          await FavouriteRemote().batchFavourite();
        }
        BlocProvider.of<AddressBloc>(navigatorKey.currentContext!)
            .add(GetAddressesEvent());
        BlocProvider.of<UserBloc>(navigatorKey.currentContext!)
            .phoneLogin
            .text = "";
        BlocProvider.of<UserBloc>(navigatorKey.currentContext!)
            .passwordLogin
            .text = "";
        BlocProvider.of<UserBloc>(navigatorKey.currentContext!)
            .add(GetUserData());
        Navigator.of(navigatorKey.currentContext!)
            .pushNamed(HomeScreen.routeName);
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }

  Future register({
    required String username,
    required String password,
    required String telephone,
    required String countryID,
    required String cityID,
    required String address,
  }) async {
    try {
      var url = MyApi.register;
      var data = {
        "SID": MyApi.SID,
        "first_name": username,
        "last_name": "  ",
        "telephone": telephone,
        "password": password
      };
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Register Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Register Remote Success");
        MyApi.UID = responsebody["data"]["CID"];
        preferences.setString("id", MyApi.UID);
        bool addAdressResponse = await AddressesRemote().addAddress(
            name: address,
            countryID: countryID,
            cityID: cityID,
            telephone1: telephone,
            address1: address);
        if (addAdressResponse) {
          if (BlocProvider.of<CartBloc>(navigatorKey.currentContext!)
              .cart
              .isNotEmpty) {
            await CartRemote().batchCart();
          }
          if (BlocProvider.of<FavouriteBloc>(navigatorKey.currentContext!)
              .favourite
              .isNotEmpty) {
            await FavouriteRemote().batchFavourite();
          }
          BlocProvider.of<AddressBloc>(navigatorKey.currentContext!)
              .add(GetAddressesEvent());
          BlocProvider.of<UserBloc>(navigatorKey.currentContext!)
              .add(GetUserData());
          Navigator.of(navigatorKey.currentContext!)
              .pushNamed(HomeScreen.routeName);
        }
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }

  Future<Map<String, dynamic>> postLogin() async {
    try {
      var url = MyApi.postLogin;
      var data = {
        "SID": MyApi.SID,
        "CID": MyApi.UID,
      };
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Post Login Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Post Login Remote Success");
        MyApi.username = responsebody["data"]["clientdata"]["first_name"];
        preferences.setString("username", MyApi.username);
        return responsebody["data"]["clientdata"];
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
    return {};
  }

  Future updateUser({required String username, required String tel}) async {
    try {
      var url = MyApi.updateUser;
      var data = {
        "SID": MyApi.SID,
        "CID": MyApi.UID,
        "first_name": username,
        "last_name": "  ",
        "telephone": tel
      };
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Update User Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Update User Remote Success");
        MyApi.username = username;
        preferences.setString("username", MyApi.username);
        MySnackBar()
            .successSnack(navigatorKey.currentContext, "user-update-success");
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }

  Future updateUserPassword({required String password}) async {
    try {
      var url = MyApi.changePassword;
      var data = {
        "SID": MyApi.SID,
        "CID": MyApi.UID,
        "password": password,
      };
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Update User Password Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Update User Password Remote Success");
        MySnackBar().successSnack(
            navigatorKey.currentContext, "password-change-success");
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }
}
