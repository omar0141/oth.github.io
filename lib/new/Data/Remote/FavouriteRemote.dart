import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/new/Bloc/Favourite/favourite_bloc.dart';
import 'package:shakosh/new/Config/Utils/Ebxhr.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/snakbars.dart';

class FavouriteRemote {
  Future batchFavourite() async {
    try {
      List<ProductModel> favourite =
          BlocProvider.of<FavouriteBloc>(navigatorKey.currentContext!)
              .favourite;
      if (favourite.isNotEmpty) {
        List<String> productsId = [];
        List<String> productsFavourite = [];
        for (var item in favourite) {
          productsId.add(item.id ?? "");
          productsFavourite.add("1");
        }
        var url = MyApi.batchWishlist;
        var data = {
          "SID": MyApi.SID,
          "CID": MyApi.UID,
          "product_id": productsId,
          "wishlist": productsFavourite
        };
        EbXhr xhr = EbXhr("POST", url, data: data);
        EbXhrReponse response = await (xhr.send());
        var responsebody = response.bodyJson;
        log("Batch Favourite Remote");
        if (responsebody == null) {
          MySnackBar()
              .errorSnack(navigatorKey.currentContext, "Server Error", true);
        } else if (responsebody["status"] == 200) {
          log("Batch Favourite Remote Success");
          BlocProvider.of<FavouriteBloc>(navigatorKey.currentContext!)
              .add(GetRemoteFavouriteEvent());
        } else {
          MySnackBar().errorSnack(
              navigatorKey.currentContext, responsebody.toString(), true);
        }
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }

  Future<List<dynamic>> getFavourite() async {
    try {
      var url = MyApi.getWishlist;
      var data = {
        "SID": MyApi.SID,
        "CID": MyApi.UID,
      };
      EbXhr xhr = EbXhr("POST", url, data: data);
      EbXhrReponse response = await (xhr.send());
      var responsebody = response.bodyJson;
      log("Get Favourite Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Get Favourite Remote Success");
        return responsebody["data"]["wishlist"];
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
    return [];
  }

  Future<bool> manageFavourite(
      {required String productId, required String wishlist}) async {
    try {
      if (MyApi.UID != "") {
        var url = MyApi.manageWishlist;
        var data = {
          "SID": MyApi.SID,
          "CID": MyApi.UID,
          "product_id": productId,
          "wishlist": wishlist
        };
        print(data);
        EbXhr xhr = EbXhr("POST", url, data: data);
        EbXhrReponse response = await (xhr.send());
        var responsebody = response.bodyJson;
        log("manage Favourite Remote");
        print(responsebody);
        if (responsebody == null) {
          MySnackBar()
              .errorSnack(navigatorKey.currentContext, "Server Error", true);
        } else if (responsebody["status"] == 200) {
          log("manage Favourite Remote Success");
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
}
