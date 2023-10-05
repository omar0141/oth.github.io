import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
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
          activeIcon: Icon(Icons.shopping_cart),
          icon: Icon(Icons.shopping_cart_outlined),
          label: "cart".tr,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.favorite),
          icon: Icon(Icons.favorite_outline),
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
}
