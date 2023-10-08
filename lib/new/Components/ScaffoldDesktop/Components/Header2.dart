import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Favourite/favourite_bloc.dart';
import 'package:shakosh/new/Bloc/Cart/cart_bloc.dart';
import 'package:shakosh/new/Components/ContextMenu.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Brands/BrandsScreen.dart';
import 'package:shakosh/new/Screens/Favourite/FavouriteScreen.dart';
import 'package:shakosh/new/Screens/Home/HomeScreen.dart';

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
          children: [
            Expanded(
              child: Row(
                children: [
                  Listener(
                    onPointerDown: (event) {
                      onPointerDown(
                          event, Uri.base.origin + "/#${HomeScreen.routeName}");
                    },
                    child: buildMenuItem(context, "home".tr, Icons.home, () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName);
                    }),
                  ),
                  Listener(
                      onPointerDown: (event) {
                        onPointerDown(event, Uri.base.origin + "/#categories");
                      },
                      child: buildMenuItem(context, "categories".tr, Icons.list,
                          () {
                        Navigator.of(context).pushNamed("categories");
                      })),
                  buildMenuItem(context, "brands".tr, Icons.local_offer, () {
                    Navigator.of(context).pushNamed(BrandsScreen.routeName);
                  }),
                  buildMenuItem(context, "about-us".tr, Icons.info, () {}),
                  // buildMenuItem(context, "contact-us".tr, Icons.call, () {}),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
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
            Tooltip(
              message: "profile".tr,
              child: InkWell(
                  onTap: () {},
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
                  )),
            ),
            SizedBox(
              width: 20,
            ),
            languageButton(context),
            SizedBox(
              width: 20,
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
            // Text(
            //   "language".tr,
            //   style: TextStyle(
            //       color: colors(context).whiteColor, fontSize: 18, height: 1),
            // ),
            // SizedBox(
            //   width: 7,
            // ),
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
