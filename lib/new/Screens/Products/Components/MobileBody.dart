import 'package:flutter/material.dart';
import 'package:shakosh/new/Screens/Products/Components/ProductsWidget.dart';

// ignore: must_be_immutable
class MobileBody extends StatelessWidget {
  MobileBody(
      {super.key, this.search, this.categoryId, this.brandId, this.page});

  String? search;
  String? categoryId;
  String? brandId;
  String? page;

  @override
  Widget build(BuildContext context) {
    return ProductsWidget(
      brandId: brandId,
      categoryId: categoryId,
      page: page,
      search: search,
    );
  }
}