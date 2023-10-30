import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ProductsShimmer.dart';
import 'package:shakosh/new/Components/ProductsWidget.dart';
import 'package:shakosh/new/Config/Colors/ColorPalette.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/ProductDetailsModel.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Screens/ProductDetails/Components/ProductDescription.dart';
import 'package:shakosh/new/Screens/ProductDetails/Components/ProductDetailsImages.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class MobileBody extends StatelessWidget {
  MobileBody({super.key, required this.state});
  var state;
  @override
  Widget build(BuildContext context) {
    if (state is ProductsDetailsLoading) {
      return productsDetailsShimmer();
    } else if (state is ProductsDetailsLoaded) {
      ProductDetailsModel productDetails = state.productDetails;
      List<ProductModel> productsSimilars = state.productSimilars;
      return productsDetails(productDetails, context, productsSimilars);
    } else {
      return Container();
    }
  }

  Column productsDetails(ProductDetailsModel productDetails,
      BuildContext context, List<ProductModel> productsSimilars) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: ProductDetailsImages(productDetails: productDetails))
          ],
        ),
        productDescription(productDetails, context),
        SizedBox(
          height: 20,
        ),
        ProductDetailsDescription(productDetails: productDetails,),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "similar-products".tr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        ProductsWidget(products: productsSimilars),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Shimmer productsDetailsShimmer() {
    return Shimmer(
      gradient: shimmerGradientColor,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < 3; i++)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.7,
                      height: 12,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2.5)),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 12,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2.5)),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 200,
                      height: 12,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2.5)),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 200,
                      height: 12,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2.5)),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.55,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2.5)),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          ProductsShimmer(
            itemCount: mySize(8, 8, 12, 16, 20)!.toInt(),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Padding productDescription(
      ProductDetailsModel productDetails, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "language_iso".tr == "ar"
                      ? productDetails.nameAlt ?? ""
                      : productDetails.name ?? "",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  productDetails.netPrice.toStringAsFixed(2) + " " + "le".tr,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: (productDetails.perOrder == 1 ||
                              productDetails.stock == 0)
                          ? colors(context).kprimaryColor
                          : colors(context).kSecondaryColor),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "model".tr + ": ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: productDetails.model ?? "",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: colors(context).kSecondaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "part-no".tr + ": ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: productDetails.part_no ?? "",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: colors(context).kSecondaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: HtmlWidget(
                   "language_iso".tr == "ar"
                      ? productDetails.briefAlt ?? ""
                      : productDetails.brief ?? "",
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
