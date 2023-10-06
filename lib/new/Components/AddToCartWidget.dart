import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';

// ignore: must_be_immutable
class AddToCartWidget extends StatelessWidget {
  AddToCartWidget({super.key, this.fontSize, this.iconSize});

  double? fontSize;
  double? iconSize;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: colors(context).kprimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: "language_iso".tr == "ar" ? 5 : 0),
            child: Text(
              "add-to-cart".tr,
              style: TextStyle(
                color: colors(context).whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize ?? mySize(12, 12, 14, 14, 14),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.shopping_cart,
              size: iconSize ?? mySize(17, 17, 20, 20, 20),
              color: colors(context).whiteColor)
        ],
      ),
    );
  }
}
