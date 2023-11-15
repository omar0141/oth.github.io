import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Bloc/Favourite/favourite_bloc.dart';
import 'package:shakosh/Bloc/Cart/cart_bloc.dart';
import 'package:shakosh/Bloc/User/user_bloc.dart';
import 'package:shakosh/Components/ContextMenu.dart';
import 'package:shakosh/Config/Images/Images.dart';
import 'package:shakosh/Config/Strings/Strings.dart';
import 'package:shakosh/Config/Translations/Translation.dart';
import 'package:shakosh/Config/settings/settings.dart';
import 'package:shakosh/Data/Remote/MyApi.dart';
import 'package:shakosh/Screens/Brands/BrandsScreen.dart';
import 'package:shakosh/Screens/ChangePassword/ChangePasswordScreen.dart';
import 'package:shakosh/Screens/EditProfile/EditProfileScreen.dart';
import 'package:shakosh/Screens/Favourite/FavouriteScreen.dart';
import 'package:shakosh/Screens/Home/HomeScreen.dart';
import 'package:shakosh/Screens/Login/LoginScreen.dart';
import 'package:shakosh/Screens/Orders/OrdersScreen.dart';
import 'package:shakosh/Screens/Register/RegisterScreen.dart';

// ignore: must_be_immutable
class Header2 extends StatelessWidget {
  Header2({super.key, required this.scaffoldKey});

  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colors(context).kprimaryColor,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: (screenWidth > 1500) ? 1600 : screenWidth,
              child: Row(
                children: [
                  Listener(
                    onPointerDown: (event) {
                      onPointerDown(
                          event,
                          Uri.base.origin +
                              urlName +
                              "/#${HomeScreen.routeName}");
                    },
                    child: buildMenuItem(context, "home".tr, Icons.home, () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName);
                    }),
                  ),
                  Listener(
                      onPointerDown: (event) {
                        onPointerDown(
                            event, Uri.base.origin + urlName + "/#categories");
                      },
                      child: buildMenuItem(context, "categories".tr, Icons.list,
                          () {
                        Navigator.of(context).pushNamed("categories");
                      })),
                  buildMenuItem(context, "brands".tr, Icons.local_offer, () {
                    Navigator.of(context).pushNamed(BrandsScreen.routeName);
                  }),
                  buildMenuItem(context, "about-us".tr, Icons.info, () {}),
                  SizedBox(
                    width: 10,
                  ),
                  Spacer(),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      double net = BlocProvider.of<CartBloc>(context).net;
                      return Row(
                        children: [
                          Badge(
                            offset: Offset(1, 0),
                            backgroundColor: colors(context).whiteColor,
                            textColor: colors(context).kprimaryColor,
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                            label: Text(state.cart.length.toString()),
                            child: IconButton(
                                tooltip: "cart".tr,
                                onPressed: () {
                                  scaffoldKey.currentState!.openEndDrawer();
                                },
                                icon: Icon(
                                  FontAwesomeIcons.cartShopping,
                                  color: colors(context).whiteColor,
                                )),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            net.toStringAsFixed(2) + " " + "le".tr,
                            style: TextStyle(
                                color: colors(context).whiteColor,
                                // fontSize: 18,
                                height: 2,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  BlocBuilder<FavouriteBloc, FavouriteState>(
                    builder: (context, state) {
                      return Badge(
                        offset: Offset(0, 2),
                        backgroundColor: colors(context).whiteColor,
                        textColor: colors(context).kprimaryColor,
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                        label: Text(state.favourite.length.toString()),
                        child: IconButton(
                            tooltip: "favourite".tr,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(FavouriteScreen.routeName);
                            },
                            icon: Icon(
                              FontAwesomeIcons.solidHeart,
                              color: colors(context).whiteColor,
                            )),
                      );
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  profileButton(context),
                  SizedBox(
                    width: 20,
                  ),
                  languageButton(context),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget languageButton(context) {
    return PopupMenuButton(
      child: Tooltip(
        message: "language".tr,
        child: Row(
          children: [
            Image.asset(
              "language_iso".tr == "ar" ? egypt : unitedKingdom,
              width: 35,
              height: 35,
            )
          ],
        ),
      ),
      position: PopupMenuPosition.under,
      padding: EdgeInsets.only(top: -10),
      tooltip: "",
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Row(
            children: [
              Image.asset(
                unitedKingdom,
                width: 25,
                height: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "English",
                style: TextStyle(color: colors(context).normalTextColor2),
              ),
            ],
          ),
          onTap: () async {
            await Translations.setLocale("en");
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Image.asset(
                egypt,
                width: 25,
                height: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "العربية",
                style: TextStyle(color: colors(context).normalTextColor2),
              ),
            ],
          ),
          onTap: () async {
            await Translations.setLocale("ar");
          },
        ),
      ],
    );
  }

  Widget profileButton(context) {
    return PopupMenuButton(
      child: Tooltip(
        message: "profile".tr,
        child: Row(
          children: [
            Icon(
              Icons.keyboard_arrow_down,
              color: colors(context).whiteColor,
              size: 28,
            ),
            Icon(
              FontAwesomeIcons.solidCircleUser,
              color: colors(context).whiteColor,
            ),
          ],
        ),
      ),
      position: PopupMenuPosition.under,
      padding: EdgeInsets.only(top: -10),
      tooltip: "",
      itemBuilder: (context) {
        if (MyApi.UID == "") {
          return [
            PopupMenuItem(
              child: Row(
                children: [
                  Text(
                    "sign-in".tr,
                    style: TextStyle(color: colors(context).normalTextColor2),
                  ),
                ],
              ),
              onTap: () async {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  Text(
                    "sign-up".tr,
                    style: TextStyle(color: colors(context).normalTextColor2),
                  ),
                ],
              ),
              onTap: () async {
                Navigator.of(context).pushNamed(RegisterScreen.routeName);
              },
            ),
          ];
        } else {
          return [
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: colors(context).normalTextColor2,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "edit-profile".tr,
                    style: TextStyle(color: colors(context).normalTextColor2),
                  ),
                ],
              ),
              onTap: () async {
                Navigator.of(context).pushNamed(EditProfileScreen.routeName);
              },
            ),
            if (showPassword)
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: colors(context).normalTextColor2,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "password-change".tr,
                      style: TextStyle(color: colors(context).normalTextColor2),
                    ),
                  ],
                ),
                onTap: () async {
                  Navigator.of(context)
                      .pushNamed(ChangePasswordScreen.routeName);
                },
              ),
            PopupMenuItem(
              child: Listener(
                onPointerDown: (event) {
                  onPointerDown(
                      event,
                      Uri.base.origin +
                          urlName +
                          "/#${OrdersScreen.routeName}");
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      color: colors(context).normalTextColor2,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "my-orders".tr,
                      style: TextStyle(color: colors(context).normalTextColor2),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(OrdersScreen.routeName);
              },
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "logout".tr,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              onTap: () async {
                BlocProvider.of<UserBloc>(navigatorKey.currentContext!)
                    .logout();
              },
            ),
          ];
        }
      },
    );
  }

  Padding buildMenuItem(context, text, icon, press) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          hoverColor: colors(context).hoverColor,
          onTap: press,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: colors(context).whiteColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: TextStyle(
                      height: "language_iso".tr == "ar" ? 2 : 1,
                      color: colors(context).whiteColor,
                      fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
