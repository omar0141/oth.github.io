import 'package:shakosh/constants.dart';
import 'package:flutter/material.dart';
import '../../../components/product_card.dart';
import '../../../controller/cart_wishlist.dart';
import 'package:provider/provider.dart';
import 'package:shakosh/models/Item.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Item> favourites = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Consumer<Cart>(builder: (context, value, _) {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.26)),
            itemCount: value.favourites.length,
            itemBuilder: (context, i) {
              if (value.favourites.isNotEmpty) {
                return ProductCard(value.favourites[i], true, kPrimaryColor);
              } else {
                return const CircularProgressIndicator();
              }
            });
      }),
    );
  }
}
