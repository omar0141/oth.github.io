import 'package:shakosh/screens/pre_sign/pre_sign_screen.dart';
import 'package:shakosh/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shakosh/constants.dart';
import 'package:provider/provider.dart';
import 'package:shakosh/controller/categories.dart';
import 'package:shakosh/controller/items.dart';

import 'package:shakosh/screens/cart/cart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shakosh/screens/favourite/fav_screen.dart';
import 'package:shakosh/screens/home/home_screen.dart';

import 'package:shakosh/screens/orders/orders_screen.dart';
import 'package:shakosh/screens/profile/profile_screen.dart';
import 'package:shakosh/screens/sign_in/sign_in_screen.dart';
import 'package:shakosh/helper/translation.dart';
import '../controller/Address.dart';
import '../controller/cart_wishlist.dart';
import '../helper/translation.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  var name = '';
  var email = '';
  String? user_id = '';
  bool isSignin = false;
  String? branch_id;
  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      name = preferences.getString('name') ?? 'Username';
      email = preferences.getString('tel') ?? 'Phone';
      user_id = preferences.getString('user_id');
      isSignin = true;
    });
  }

  delpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Provider.of<MyAddress>(context, listen: false).empty();
    Provider.of<Cart>(context, listen: false).empty();
    // Provider.of<Getcategories>(context, listen: false).empty();
    Provider.of<Getcategoryitems>(context, listen: false).empty();
    await preferences.clear();
  }

  @override
  void initState() {
    getpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: <Widget>[
              buildHeader(
                name: name,
                email: email,
              ),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    Divider(color: Colors.white70),
                    const SizedBox(height: 20),
                    buildMenuItem(
                      text: Translation.get('home'),
                      icon: Icons.home_outlined,
                      onClicked: () {
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      },
                    ),
                    user_id != null ? const SizedBox(height: 16) : Container(),
                    user_id != null
                        ? buildMenuItem(
                            text: Translation.get('favourite'),
                            icon: Icons.favorite_outline,
                            onClicked: () {
                              Navigator.pushNamed(context, Favourite.routeName);
                            },
                          )
                        : Container(),
                    user_id != null ? const SizedBox(height: 16) : Container(),
                    user_id != null
                        ? buildMenuItem(
                            text: Translation.get('orders'),
                            icon: Icons.local_shipping_outlined,
                            onClicked: () {
                              Navigator.pushNamed(
                                  context, OrdersScreen.routeName);
                            },
                          )
                        : Container(),
                    user_id != null ? const SizedBox(height: 16) : Container(),
                    user_id != null
                        ? buildMenuItem(
                            text: Translation.get('profile'),
                            icon: Icons.person_outline,
                            onClicked: () {
                              Navigator.pushNamed(
                                  context, ProfileScreen.routeName);
                            },
                          )
                        : Container(),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: Translation.get('lang-change'),
                      icon: Icons.public_outlined,
                      onClicked: () async {
                        // Provider.of<Getcategoryitems>(context, listen: false)
                        //     .empty();
                        // Provider.of<Getcategories>(context, listen: false)
                        //     .empty();
                        await Translation.setLocale(Translation.get('lang'));

                        // Provider.of<Getcategoryitems>(context, listen: false)
                        //     .getitemscat(null, context, null, null, 0, null);
                        // Provider.of<Getcategories>(context, listen: false)
                        //     .getData();
                        Provider.of<MyAddress>(context, listen: false).empty();
                        Provider.of<Cart>(context, listen: false).empty();
                        Provider.of<Getcategories>(context, listen: false)
                            .empty();
                        Provider.of<Getcategoryitems>(context, listen: false)
                            .empty();
                        Navigator.pushNamed(context, SplashScreen.routeName);
                      },
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: user_id != null
                          ? Translation.get('logout')
                          : Translation.get('sign-in-button'),
                      icon: user_id != null
                          ? Icons.logout_outlined
                          : Icons.login_outlined,
                      onClicked: () {
                        if (user_id != null) {
                          delpref();
                        }
                        Navigator.pushNamed(context, PreSignScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader({
    String? urlImage,
    required String name,
    required String email,
    VoidCallback? onClicked,
  }) =>
      Container(
        padding: padding.add(EdgeInsets.only(top: 20, bottom: 20)),
        child: Image.asset(
          'assets/images/logo.png',
          width: 150,
          height: 150,
        ),
      );

  Widget buildMenuItem({
    required String text,
    IconData? icon,
    onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color, fontSize: 15)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
