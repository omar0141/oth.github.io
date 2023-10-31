import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Screens/Products/Components/ProductsFilter.dart';
import 'package:shakosh/new/Screens/Products/Components/ProductsSection.dart';

// ignore: must_be_immutable
class DesktopBody extends StatelessWidget {
  DesktopBody(
      {super.key, this.search, this.categoryId, this.brandId, this.page});

  String? search;
  String? categoryId;
  String? brandId;
  String? page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 70,
                  // ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: colors(context).grey2!)),
                      child: ProductsFilter(
                        search: search,
                        categoryId: categoryId,
                        brandId: brandId,
                      )),
                ],
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  ProductsSection(
                    brandId: brandId,
                    categoryId: categoryId,
                    page: page,
                    search: search,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
