import 'package:flutter/material.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar({
    super.key,
  });

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 5,
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      onTap: (value) {
        index = value;
        setState(() {});
      },
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
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
