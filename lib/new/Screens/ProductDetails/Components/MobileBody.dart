import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ProductsShimmer.dart';
import 'package:shakosh/new/Components/ProductsWidget.dart';
import 'package:shakosh/new/Config/Colors/ColorPalette.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Data/Models/ProductDetailsModel.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
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
                      width: screenWidth * 0.55,
                      height: 8,
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
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          ProductsShimmer(),
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
                  productDetails.netPrice.toStringAsFixed(2) + " " + "le".tr,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: (productDetails.perOrder == 1 || productDetails.stock == 0) ? colors(context).kprimaryColor :  colors(context).kSecondaryColor),
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
                child: Html(data:
                  "language_iso".tr == "ar"
                      ? productDetails.briefAlt ?? ""
                      : productDetails.brief ?? "",
                      
                  
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
                child: SelectionArea(
                  
                  child: Html(
                    data:
                    "language_iso".tr == "ar"
                        ? productDetails.descriptionAlt ?? ""
                        : productDetails.description ?? "",
                    
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
