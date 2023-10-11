import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/controller/controllers.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Cart/cart_bloc.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Bloc/Favourite/favourite_bloc.dart';
import 'package:shakosh/new/Data/Local/CartLocal.dart';
import 'package:shakosh/new/Data/Local/FavouriteLocal.dart';
import 'package:shakosh/new/Data/Remote/UserRemote.dart';

class InitialServices {
  Future getDependancies() async {
    if (newDate > 10) {
      BlocProvider.of<DependanciesBloc>(navigatorKey.currentContext!)
          .add(GetDependanciesEvent(remote: true));
    } else {
      BlocProvider.of<DependanciesBloc>(navigatorKey.currentContext!)
          .add(GetDependanciesEvent(remote: false));
    }
    preferences.setString("date", DateTime.now().toString());
    timer = Timer.periodic(Duration(minutes: 3), (Timer timer) {
      preferences.setString("date", DateTime.now().toString());
    });
    //
    if (MyApi.UID != "") {
      UserRemote().postLogin();
      BlocProvider.of<CartBloc>(navigatorKey.currentContext!)
          .add(GetRemoteCartEvent());
      BlocProvider.of<FavouriteBloc>(navigatorKey.currentContext!)
          .add(GetRemoteFavouriteEvent());
    }
    CartLocal().getCart(setState: true);
    FavouriteLocal().getFavourite(setState: true);
    // Timer.periodic(Duration(seconds: 10), (Timer timer) async {
    //   CartLocal().getCart(setState: true);
    //   FavouriteLocal().getFavourite(setState: true);
    // });
    //
  }
}
