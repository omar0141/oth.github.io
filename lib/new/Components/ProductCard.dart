
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/CartWidget.dart';
import 'package:shakosh/new/Components/ContextMenu.dart';
import 'package:shakosh/new/Components/FavouriteWidget.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Strings/Strings.dart';
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

  @override
  Widget build(BuildContext context) {
    String route = "product/${widget.product.id}";
    return Listener(
      onPointerDown: (event) {
        route = "product/${widget.product.id}";
        onPointerDown(event, Uri.base.origin + urlName + "/#$route");
      },
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: () {
          route = "product/${widget.product.id}";
          Navigator.of(context).pushNamed(route);
        },
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
                  Row(
                    children: [
                      Expanded(child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),child: productImage(widget.product.thumbnail))),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "language_iso".tr == "ar"
                              ? widget.product.nameAlt ?? ""
                              : widget.product.name ?? "",
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: "language_iso".tr == "ar" ? 1.5 : 1.2,
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
                          widget.product.netPrice.toStringAsFixed(0) +
                              " " +
                              "le".tr,
                          style: TextStyle(
                              height: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: mySize(18, 18, 20, 20, 20),
                              color: (widget.product.stock == 999999999999999 ||
                                      widget.product.stock == 0)
                                  ? colors(context).kprimaryColor
                                  : colors(context).kSecondaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 45,
                      child: CartWidget(
                        product: widget.product,
                      ))
                ],
              ),
              Positioned.directional(
                  textDirection: "language_iso".tr == "ar"
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  top: 5,
                  end: 5,
                  child: FavouriteWidget(
                    product: widget.product,
                  )),
              // if (widget.product.stock == 999999999999999)
              //   Positioned.directional(
              //       textDirection: "language_iso".tr == "ar"
              //           ? TextDirection.rtl
              //           : TextDirection.ltr,
              //       top: 5,
              //       start: 5,
              //       child: Container(
              //         padding: EdgeInsets.all(7),
              //         decoration: BoxDecoration(
              //             color: colors(context).kSecondaryColor,
              //             borderRadius: BorderRadius.circular(5)),
              //         child: Text(
              //           "reserve".tr,
              //           style: TextStyle(
              //               fontSize: 12,
              //               fontWeight: FontWeight.bold,
              //               color: colors(context).whiteColor),
              //         ),
              //       )),
            ],
          ),
        ),
      ),
    );
  }

  ClipRRect productImage(String? image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: FastCachedImage(

          height: mySize(100, 100, 150, 150, 150),
          url: MyApi.media + (image ?? ""),
          fit: BoxFit.contain,
          loadingBuilder: (context, url) => SizedBox(
            height: mySize(100, 100, 150, 150, 150),
            child: Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                        color: colors(context).kprimaryColor),
                  ),
                ),
          ),
          errorBuilder: (context, url, error) => SvgPicture.asset(
                unLoadedImage,
                height: mySize(100, 100, 150, 150, 150),
              )),
    );
  }
}
