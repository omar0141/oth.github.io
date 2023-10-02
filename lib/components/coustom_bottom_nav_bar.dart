// ignore_for_file: prefer_const_constructors

import 'package:shakosh/screens/cart/cart_screen.dart';
import 'package:shakosh/screens/orders/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shakosh/controller/items.dart';
import 'package:shakosh/screens/favourite/fav_screen.dart';
import 'package:shakosh/screens/home/home_screen.dart';
import 'package:shakosh/screens/profile/profile_screen.dart';
import '../constants.dart';
import '../controller/cart_wishlist.dart';
import '../enums.dart';
import 'package:provider/provider.dart';

import '../helper/translation.dart';
import '../size_config.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    required this.selectedMenu,
  });

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Colors.white;
    return Container(
      height: 73,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(-1, 0),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              color: MenuState.home == selectedMenu
                  ? Colors.amber
                  : inActiveIconColor,
            ),
            onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite_outline,
              color: MenuState.favourite == selectedMenu
                  ? Colors.amber
                  : inActiveIconColor,
            ),
            onPressed: () => Navigator.pushNamed(context, Favourite.routeName),
          ),
          Consumer<Cart>(builder: (context, mycart, child) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MyCart.routeName);
              },
              child: SizedBox(
                width: 40,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/cart.png',
                      color: MenuState.cart == selectedMenu
                          ? Colors.amber
                          : inActiveIconColor,
                      width: 30,
                      height: 30,
                    ),
                    if (mycart.count != 0)
                      Positioned(
                        top: 10,
                        left:
                            Translation.get('language_iso') == 'en' ? 20 : null,
                        right:
                            Translation.get('language_iso') == 'en' ? null : 20,
                        child: Container(
                          height: getProportionateScreenWidth(15),
                          width: getProportionateScreenWidth(15),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF4848),
                            shape: BoxShape.circle,
                            border: Border.all(width: 1.5, color: Colors.white),
                          ),
                          child: Center(
                            child: Text(
                              "${mycart.count}",
                              style: const TextStyle(
                                fontSize: 10,
                                height: 1,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            );
          }),
          if (Provider.of<Getcategoryitems>(context, listen: false).user_id !=
              null)
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: MenuState.profile == selectedMenu
                    ? Colors.amber
                    : inActiveIconColor,
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, ProfileScreen.routeName),
            ),
          if (Provider.of<Getcategoryitems>(context, listen: false).user_id !=
              null)
            IconButton(
              icon: Icon(
                Icons.local_shipping_outlined,
                color: MenuState.orders == selectedMenu
                    ? Colors.amber
                    : inActiveIconColor,
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, OrdersScreen.routeName),
            ),
        ],
      ),
    );
  }
}
