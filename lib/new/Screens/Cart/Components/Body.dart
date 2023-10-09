import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Cart/cart_bloc.dart';
import 'package:shakosh/new/Components/CartWidget.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:shakosh/new/Screens/Cart/Components/TotalCartWidget.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        List<ProductModel> products = state.cart;
        return screenWidth > 768
            ? Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: cartProducts(products, context),
                    ),
                  ),
                  TotalCartWidget()
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: cartProducts(products, context),
              );
      },
    );
  }

  ListView cartProducts(List<ProductModel> products, BuildContext context) {
    return ListView(
      shrinkWrap: screenWidth > 768 ? false : true,
      physics: screenWidth > 768 ? null : NeverScrollableScrollPhysics(),
      children: [
        for (var product in products)
          Column(
            children: [
              SizedBox(
                height: 135,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2, child: productImage(product.thumbnail)),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "language_iso".tr == "ar"
                                            ? product.nameAlt
                                            : product.name,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      hoverColor: Colors.transparent,
                                      onTap: () {
                                        BlocProvider.of<CartBloc>(context).add(
                                            RemoveFromCartEvent(
                                                product: product,
                                                remove: true));
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: colors(context).kprimaryColor,
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      product.netPrice.toStringAsFixed(2) +
                                          " " +
                                          "le".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              colors(context).kSecondaryColor,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: mySize(screenWidth * 0.4,
                                          screenWidth * 0.4, 150, 150, 150),
                                      child: CartWidget(
                                        product: product,
                                        height: 35,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
      ],
    );
  }

  ClipRRect productImage(String? image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(
          height: mySize(100, 100, 100, 100, 100),
          imageUrl: MyApi.media + (image ?? ""),
          fit: BoxFit.fill,
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
                height: mySize(100, 100, 100, 100, 100),
              )),
    );
  }
}
