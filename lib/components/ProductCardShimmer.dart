import 'package:flutter/material.dart';
import 'package:shakosh/Config/Colors/ColorPalette.dart';
import 'package:shakosh/Config/Utils/SizeConfig.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: shimmerGradientColor,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: mySize(150, 150, 150, 150, 150),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                  height: mySize(5, 5, 8, 8, 8),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                color: Colors.grey,
                width: 100,
                height: mySize(5, 5, 8, 8, 8),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: mySize(40, 40, 40, 40, 40),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
