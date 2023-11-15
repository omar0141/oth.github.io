import 'package:flutter/material.dart';
import 'package:shakosh/Components/ProductCardShimmer.dart';
import 'package:shakosh/Config/Utils/SizeConfig.dart';

// ignore: must_be_immutable
class ProductsShimmer extends StatelessWidget {
  ProductsShimmer({super.key, this.crossAxisCount, required this.itemCount});

  int? crossAxisCount;
  int itemCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mySize(10, 10, 30, 30, 30)!),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: mySize(260, 260, 300, 320, 310),
            crossAxisSpacing: mySize(10, 10, 20, 20, 20)!,
            mainAxisSpacing: mySize(10, 10, 20, 20, 20)!,
            crossAxisCount: crossAxisCount ?? mySize(2, 2, 3, 4, 5)!.toInt(),
          ),
          itemCount: itemCount,
          itemBuilder: (context, i) {
            return ProductCardShimmer();
          }),
    );
  }
}
