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
import 'package:shakosh/new/Screens/More/MoreScreen.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return test2(context);
  }

  Widget test2(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: FractionalOffset(.5, 1.0),
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                        child: Icon(Icons.call_outlined),
                        onTap: () async {
                          if (await canLaunchUrl(Uri.parse(
                              "https://api.whatsapp.com/send?phone=+2010239667560"))) {
                            await launchUrl(Uri.parse(
                                "https://api.whatsapp.com/send?phone=+201023966756"));
                          }
                        }),
                    Text("contact-us".tr)
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      child: cartIcon(),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CartScreen();
                        }));
                      },
                    ),
                    Text("cart".tr)
                  ],
                ),
              ),
              SizedBox(
                width: 60,
              ),
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      child: widget.index == 2
                          ? favouriteIcon(Icons.favorite)
                          : favouriteIcon(Icons.favorite_outline),
                      onTap: () => Navigator.pushNamed(
                          context, FavouriteScreen.routeName),
                    ),
                    Text("favourite".tr)
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      child: widget.index == 3
                          ? Image.asset(more)
                          : Image.asset(more_outlined),
                      onTap: () =>
                          Navigator.pushNamed(context, MoreScreen.routeName),
                    ),
                    Text("more".tr)
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 30,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, HomeScreen.routeName),
              child: Image.asset(
                logo2,
                width: 60,
                height: 60,
              ),
            ))
      ],
    );
  }

  Widget test() {
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
        } else if (value == 3) {
          Navigator.of(context).pushNamed(FavouriteScreen.routeName);
        } else if (value == 4) {
          Navigator.of(context).pushNamed(MoreScreen.routeName);
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
        BottomNavigationBarItem(icon: SizedBox(), label: ""),
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
