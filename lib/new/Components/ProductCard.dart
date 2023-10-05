import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Data/Remote/MyApi.dart';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  ProductCard({super.key, required this.product});
  ProductModel product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool hovered = false;
  bool favourite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () {},
      onHover: (value) {
        hovered = value;
        setState(() {});
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: colors(context).whiteColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: hovered
                  ? colors(context).grey2!.withOpacity(0.7)
                  : colors(context).grey2!,
            ),
            boxShadow: [
              if (hovered)
                BoxShadow(
                    color: colors(context).shadowColor!,
                    spreadRadius: 5,
                    blurRadius: 10.0,
                    offset: Offset(0, 0))
            ]),
        child: Stack(
          children: [
            Column(
              children: [
                productImage(widget.product.thumbnail),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "language_iso".tr == "ar"
                            ? widget.product.nameAlt
                            : widget.product.name,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            fontSize: mySize(13, 13, 14, 16, 16)),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.price.toStringAsFixed(2) + " " + "le".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: mySize(18, 18, 20, 20, 20),
                            color: Color.fromARGB(255, 0, 38, 255)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: colors(context).kprimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 45,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "add-to-cart".tr,
                          style: TextStyle(
                            color: colors(context).whiteColor,
                            fontSize: mySize(12, 12, 13, 13, 13),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.shopping_cart,
                          size: mySize(17, 17, 20, 20, 20),
                          color: colors(context).whiteColor)
                    ],
                  ),
                )
              ],
            ),
            Positioned.directional(
                textDirection: "language_iso".tr == "ar"
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                top: -5,
                start: -5,
                child: IconButton(
                  icon: Icon(
                    favourite ? Icons.favorite : Icons.favorite_outline,
                    color:
                        favourite ? Colors.red : colors(context).kprimaryColor,
                  ),
                  onPressed: () {
                    favourite = !favourite;
                    setState(() {});
                  },
                )),
          ],
        ),
      ),
    );
  }

  ClipRRect productImage(String? image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(
          height: mySize(100, 100, 150, 150, 150),
          width: mySize(100, 100, 150, 150, 150),
          imageUrl: MyApi.media + (image ?? ""),
          placeholder: (context, url) => Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                      color: colors(context).kprimaryColor),
                ),
              ),
          errorWidget: (context, url, error) => SvgPicture.asset(
                unLoadedImage,
                height: mySize(100, 100, 150, 150, 150),
              )),
    );
  }
}
