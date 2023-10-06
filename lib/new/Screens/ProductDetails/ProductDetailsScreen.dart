import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Screens/ProductDetails/Components/DesktopBody.dart';
import 'package:shakosh/new/Screens/ProductDetails/Components/MobileBody.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({super.key, required this.product});

  ProductModel product;

  static String routeName = "product";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductsBloc>(context)
        .add(GetProductDetailsEvent(productID: widget.product.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (screenWidth > 768) {
      return ScaffoldDesktop(
        child: DesktopBody(
          product: widget.product,
        ),
      );
    } else {
      return ScaffoldMobile(
        screenName: "categories".tr,
        child: MobileBody(
          product: widget.product,
        ),
        index: -1,
      );
    }
  }
}
