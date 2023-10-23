import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Screens/Products/Components/DesktopBody.dart';
import 'package:shakosh/new/Screens/Products/Components/MobileBody.dart';

// ignore: must_be_immutable
class ProductsScreen extends StatefulWidget {
  ProductsScreen(
      {super.key, this.search, this.categoryId, this.brandId, this.page});

  String? search;
  String? categoryId;
  String? brandId;
  String? page;

  static String productsOnlyRoute = "products";
  static String productsRoute = "products/:pageId";
  static String productsSearchRoute = "products/:pageId/:search";
  static String productsCategoriesRoute =
      "categories/:categoryId/products/:pageId";
  static String productsCategoriesSearchRoute =
      "categories/:categoryId/products/:pageId/:search";
  static String productsBrandsRoute = "brands/:brandId/products/:pageId";
  static String productsBrandsSearchRoute =
      "brands/:brandId/products/:pageId/:search";
  static String productsCategoriesBrandsRoute =
      "categories/:categoryId/brands/:brandId/products/:pageId";
  static String productsCategoriesBrandsSearchRoute =
      "categories/:categoryId/brands/:brandId/products/:pageId/:search";

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent(
        count: mySize(8, 8, 12, 12, 16).toString(),
        search: widget.search,
        categoryId: widget.categoryId,
        brandId: widget.brandId,
        page: widget.page));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (screenWidth > 768) {
      return ScaffoldDesktop(
        products: true,
        categoryId: widget.categoryId,
        brandId: widget.brandId,
        search: widget.search,
        child: DesktopBody(
            brandId: widget.brandId,
            categoryId: widget.categoryId,
            page: widget.page,
            search: widget.search),
      );
    } else {
      return ScaffoldMobile(
        screenName: "products".tr,
        child: MobileBody(
            brandId: widget.brandId,
            categoryId: widget.categoryId,
            page: widget.page,
            search: widget.search),
        index: -1,
      );
    }
  }
}
