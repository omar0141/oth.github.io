import 'package:flutter/material.dart';
import 'package:shakosh/Config/Colors/ColorPalette.dart';
import 'package:shakosh/Config/Utils/SizeConfig.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Shimmer(
        gradient: shimmerGradientColor,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              height: mySize(65, 65, 100, 100, 100),
              width: mySize(65, 65, 100, 100, 100),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.grey,
              width: mySize(100, 100, 150, 150, 150),
              height: mySize(5, 5, 8, 8, 8),
            ),
          ],
        ),
      ),
    );
  }
}
