import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Cart/cart_bloc.dart';
import 'package:shakosh/new/Bloc/Favourite/favourite_bloc.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Cart/CartScreen.dart';
import 'package:shakosh/new/Screens/Favourite/FavouriteScreen.dart';
import 'package:shakosh/new/Screens/Home/HomeScreen.dart';

// ignore: must_be_immutable
class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar({super.key, required this.index});
  int index;

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 5,
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.index == -1 ? 0 : widget.index,
      selectedItemColor:
          widget.index == -1 ? Colors.grey[600] : colors(context).kprimaryColor,
      selectedLabelStyle:
          widget.index == -1 ? null : TextStyle(fontWeight: FontWeight.bold),
      onTap: (value) {
        widget.index = value;
        if (value == 0) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } else if (value == 1) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CartScreen();
          }));
        } else if (value == 2) {
          Navigator.of(context).pushNamed(FavouriteScreen.routeName);
        }
        setState(() {});
      },
      items: [
        BottomNavigationBarItem(
          activeIcon:
              Icon(widget.index == -1 ? Icons.home_outlined : Icons.home),
          icon: Icon(Icons.home_outlined),
          label: "home".tr,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.shopping_cart_outlined),
          icon: cartIcon(),
          label: "cart".tr,
        ),
        BottomNavigationBarItem(
          activeIcon: favouriteIcon(Icons.favorite),
          icon: favouriteIcon(Icons.favorite_outline),
          label: "favourite".tr,
        ),
        BottomNavigationBarItem(
          activeIcon: Image.asset(more),
          icon: Image.asset(more_outlined),
          label: "more".tr,
        ),
      ],
    );
  }

  BlocBuilder<CartBloc, CartState> cartIcon() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Badge(
            offset: Offset(-5, -5),
            backgroundColor: colors(context).kprimaryColor,
            textColor: colors(context).whiteColor,
            textStyle: TextStyle(fontWeight: FontWeight.bold),
            label: Text(state.cart.length.toString()),
            child: Icon(Icons.shopping_cart_outlined));
      },
    );
  }

  BlocBuilder<FavouriteBloc, FavouriteState> favouriteIcon(icon) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        return Badge(
            backgroundColor: colors(context).kprimaryColor,
            textColor: colors(context).whiteColor,
            textStyle: TextStyle(fontWeight: FontWeight.bold),
            label: Text(state.favourite.length.toString()),
            child: Icon(icon));
      },
    );
  }
}
