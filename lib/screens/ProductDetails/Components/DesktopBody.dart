import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Bloc/Products/products_bloc.dart';
import 'package:shakosh/Components/CartWidget.dart';
import 'package:shakosh/Components/FavouriteWidget.dart';
import 'package:shakosh/Components/ProductsShimmer.dart';
import 'package:shakosh/Components/ProductsWidget.dart';
import 'package:shakosh/Config/Colors/ColorPalette.dart';
import 'package:shakosh/Config/Translations/Translation.dart';
import 'package:shakosh/Config/Utils/SizeConfig.dart';
import 'package:shakosh/Data/Models/ProductDetailsModel.dart';
import 'package:shakosh/Data/Models/ProductModel.dart';
import 'package:shakosh/Screens/ProductDetails/Components/ProductDescription.dart';
import 'package:shakosh/Screens/ProductDetails/Components/ProductDetailsImages.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shakosh/Components/ContextMenu.dart';

// ignore: must_be_immutable
class DesktopBody extends StatelessWidget {
  DesktopBody({super.key, required this.state});
  var state;
  String copiedText = "";

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ProductDetailsImages(
                      productDetails: productDetails,
                    )
                  ],
                )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                flex: 3,
                child: SelectionArea(
                  onSelectionChanged: (value) {
                    copiedText = value?.plainText ?? "";
                  },
                  child: Listener(
                    onPointerDown: (event) {
                      copyTextMenu(event, copiedText);
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "language_iso".tr == "ar"
                                    ? productDetails.nameAlt ?? ""
                                    : productDetails.name ?? "",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        if (productDetails.sku != null)
                          SizedBox(
                            height: 20,
                          ),
                        if (productDetails.sku != null)
                          Row(
                            children: [
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "sku".tr + ": ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: productDetails.sku ?? "",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: colors(context)
                                                .kSecondaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (productDetails.model != null)
                          SizedBox(
                            height: 20,
                          ),
                        if (productDetails.model != null)
                          Row(
                            children: [
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "model".tr + ": ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: productDetails.model ?? "",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: colors(context)
                                                .kSecondaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (productDetails.part_no != null)
                          SizedBox(
                            height: 20,
                          ),
                        if (productDetails.part_no != null)
                          Row(
                            children: [
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "part-no".tr + ": ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: productDetails.part_no ?? "",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: colors(context)
                                                .kSecondaryColor),
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
                        SizedBox(
                          height: 20,
                        ),
                        if (productDetails.price > 0)
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  productDetails.netPrice.toStringAsFixed(0) +
                                      " " +
                                      "le".tr,
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
                            SizedBox(
                                width: 200,
                                height: 55,
                                child: CartWidget(
                                  product: ProductModel.fromJson(
                                      productDetails.toJson()),
                                  fontSize: 18,
                                  iconSize: 25,
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            FavouriteWidget(
                              width: 55,
                              height: 55,
                              iconSize: 30,
                              product: ProductModel.fromJson(
                                  productDetails.toJson()),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SelectionArea(
          onSelectionChanged: (value) {
            copiedText = value?.plainText ?? "";
          },
          child: Listener(
            onPointerDown: (event) {
              copyTextMenu(event, copiedText);
            },
            child: ProductDetailsDescription(
              productDetails: productDetails,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
        ProductsWidget(products: productsSimilars)
      ],
    );
  }

  Shimmer productsDetailsShimmer() {
    return Shimmer(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: 30, top: 15),
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.4,
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
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                            ],
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              width: screenWidth * 0.4,
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
                              width: screenWidth * 0.2,
                              height: 10,
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
                              width: screenWidth * 0.2,
                              height: 10,
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
                              width: screenWidth * 0.45,
                              height: 10,
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
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ProductsShimmer(
              itemCount: mySize(8, 8, 12, 16, 20)!.toInt(),
            )
          ],
        ),
        gradient: shimmerGradientColor);
  }
}
