import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Cart/cart_bloc.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';

// ignore: must_be_immutable
class CartWidget extends StatelessWidget {
  CartWidget(
      {super.key,
      this.fontSize,
      this.iconSize,
      required this.product,
      this.height});

  double? fontSize;
  double? iconSize;
  ProductModel product;
  double? height;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      List<ProductModel> cart = state.cart;
      int i = cart.indexWhere((e) => e.id == product.id);
      return SizedBox(
        height: 45,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            addedToCartWidget(i, context, cart, state),
            notInCartWidget(i, context, cart, state)
          ],
        ),
      );
    });
  }

  AnimatedContainer notInCartWidget(
      int i, BuildContext context, List<ProductModel> cart, CartState state) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      height: i == -1 ? height ?? 45 : 0,
      child: MaterialButton(
        color: (state is CartLoading && state.cartLoading.contains(product.id))
            ? colors(context).kprimaryColor!.withOpacity(0.7)
            : colors(context).kprimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: () {
          if (state is CartLoading && state.cartLoading.contains(product.id)) {
          } else {
            if (product.stock > 0) {
              BlocProvider.of<CartBloc>(context)
                  .add(AddToCartEvent(product: product));
            }
          }
        },
        child: (state is CartLoading && state.cartLoading.contains(product.id))
            ? SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: colors(context).whiteColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: "language_iso".tr == "ar" ? 5 : 0),
                    child: Text(
                      product.stock == 999999999999999
                          ? "reserve-in-cart".tr
                          : "add-to-cart".tr,
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
      ),
    );
  }

  AnimatedContainer addedToCartWidget(
      int i, BuildContext context, List<ProductModel> cart, CartState state) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      height: i > -1 ? height ?? 45 : 0,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: MaterialButton(
              height: height ?? 45,
              color: (state is CartLoading &&
                      state.cartLoading.contains(product.id))
                  ? colors(context).kprimaryColor!.withOpacity(0.7)
                  : colors(context).kprimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onPressed: () {
                if (state is CartLoading &&
                    state.cartLoading.contains(product.id)) {
                } else {
                  if (product.stock > 0) {
                    BlocProvider.of<CartBloc>(context)
                        .add(AddToCartEvent(product: product));
                  }
                }
              },
              child: (state is CartLoading &&
                      state.cartLoading.contains(product.id))
                  ? Center(
                      child: SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colors(context).whiteColor,
                          )),
                    )
                  : Center(
                      child: Icon(
                        FontAwesomeIcons.plus,
                        size: iconSize ?? mySize(12, 15, 18, 18, 18),
                        color: colors(context).whiteColor,
                      ),
                    ),
            ),
          ),
          SizedBox(
            width: mySize(5, 5, 10, 10, 10),
          ),
          Expanded(
              flex: mySize(3, 4, 4, 4, 4)!.toInt(),
              child: Container(
                height: height ?? 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: colors(context).grey2),
                child: Center(
                  child: Text(
                    i > -1 ? cart[i].cart.toStringAsFixed(0) : "0",
                    style: TextStyle(
                      height: "language_iso".tr == "ar" ? 2 : 1,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize ?? 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          SizedBox(
            width: mySize(5, 5, 10, 10, 10),
          ),
          Expanded(
            flex: 2,
            child: MaterialButton(
              height: height ?? 45,
              color: (state is CartLoading &&
                      state.cartLoading.contains(product.id))
                  ? colors(context).kprimaryColor!.withOpacity(0.7)
                  : colors(context).kprimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onPressed: () {
                if (state is CartLoading &&
                    state.cartLoading.contains(product.id)) {
                } else {
                  BlocProvider.of<CartBloc>(context)
                      .add(RemoveFromCartEvent(product: product));
                }
              },
              child: (state is CartLoading &&
                      state.cartLoading.contains(product.id))
                  ? Center(
                      child: SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colors(context).whiteColor,
                          )),
                    )
                  : Center(
                      child: Icon(
                        FontAwesomeIcons.minus,
                        size: iconSize ?? mySize(12, 15, 18, 18, 18),
                        color: colors(context).whiteColor,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
