import 'package:flutter/material.dart';
import 'package:shakosh/new/Components/BrandsWidget.dart';
import 'package:shakosh/new/Components/ParentCategories.dart';
import 'package:shakosh/new/Screens/Home/Components/TrendingProducts.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ParentCategories(
            home: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BrandsWidget(
            home: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(),
        ),
        SizedBox(
          height: 20,
        ),
        TrendingProducts()
      ],
    );
  }
}
