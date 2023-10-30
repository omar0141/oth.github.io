// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import '../../../helper/translation.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard(
      {Key? key,
      required this.item_name,
      this.item_price,
      this.item_image,
      this.item_no,
      this.qty,
      this.detail,
      this.item_whl_price})
      : super(key: key);
  final item_name;
  final item_price;
  final item_whl_price;
  final item_image;
  final item_no;
  final qty;
  final detail;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
              ),
              child: Container(),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "$qty X ",
                  style: TextStyle(color: kPrimaryColor, fontSize: 16),
                ),
                SizedBox(
                    width: getProportionateScreenWidth(180),
                    child: Text(
                      item_name,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${(double.parse(item_price) * double.parse(qty)).toStringAsFixed(1)} ${Translation.get("le")}',
              style: TextStyle(color: kPrimaryColor, fontSize: 16),
            ),
          ],
        ),
      ],
    ));
  }
}
