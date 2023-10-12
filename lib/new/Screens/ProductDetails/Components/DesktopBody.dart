import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/CartWidget.dart';
import 'package:shakosh/new/Components/FavouriteWidget.dart';
import 'package:shakosh/new/Components/ProductsShimmer.dart';
import 'package:shakosh/new/Components/ProductsWidget.dart';
import 'package:shakosh/new/Config/Colors/ColorPalette.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Data/Models/ProductDetailsModel.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Screens/ProductDetails/Components/ProductDetailsImages.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class DesktopBody extends StatelessWidget {
  DesktopBody({super.key, required this.state});
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "language_iso".tr == "ar"
                                ? productDetails.briefAlt ?? ""
                                : productDetails.brief ?? "",
                            style: TextStyle(fontSize: 17),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: "language_iso".tr == "ar" ? 10 : 0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "language_iso".tr == "ar"
                                ? productDetails.descriptionAlt ?? ""
                                : productDetails.description ?? "",
                            style: TextStyle(fontSize: 15),
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
                            productDetails.netPrice.toStringAsFixed(2) +
                                " " +
                                "le".tr,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: colors(context).kSecondaryColor),
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
                          product:
                              ProductModel.fromJson(productDetails.toJson()),
                        )
                      ],
                    ),
                  ],
                ))
          ],
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
                              width: screenWidth * 0.45,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(2.5)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 75,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            SizedBox(
                              width: 20,
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
            ProductsShimmer()
          ],
        ),
        gradient: shimmerGradientColor);
  }
}
