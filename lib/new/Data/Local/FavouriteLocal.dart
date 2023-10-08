import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Favourite/favourite_bloc.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:universal_html/html.dart' as html;

class FavouriteLocal {
  void postFavourite(List<ProductModel> favourite) {
    if (kIsWeb) {
      List<dynamic> favouriteJson = [];
      for (var element in favourite) {
        favouriteJson.add(element.toJson());
      }
      html.window.localStorage['favourite'] = jsonEncode(favouriteJson);
    }
  }

  void getFavourite({bool setState = false}) {
    if (kIsWeb) {
      List<dynamic> favouriteJson =
          jsonDecode(html.window.localStorage['favourite'] ?? "[]");
      List<ProductModel> favourite = [];
      for (var element in favouriteJson) {
        favourite.add(ProductModel.fromJson(element));
      }
      if (setState) {
        BlocProvider.of<FavouriteBloc>(navigatorKey.currentContext!)
            .add(GetLocalFavouriteEvent(favourite: favourite));
      } else {
        BlocProvider.of<FavouriteBloc>(navigatorKey.currentContext!).favourite =
            favourite;
      }
    }
  }
}
