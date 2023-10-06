import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ProductCard.dart';
import 'package:shakosh/new/Components/ProductCardShimmer.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:universal_html/html.dart' as html;

// ignore: must_be_immutable
class ProductsWidget extends StatelessWidget {
  ProductsWidget(
      {super.key, this.search, this.categoryId, this.brandId, this.page});

  String? search;
  String? categoryId;
  String? brandId;
  String? page;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        brandId = BlocProvider.of<ProductsBloc>(context).brandId;
        categoryId = BlocProvider.of<ProductsBloc>(context).categoryId;
        if (state is ProductsLoading) {
          return productsShimmer();
        } else if (state is ProductsLoaded) {
          List<ProductModel> products = state.products;
          if (products.isEmpty) {
            return SizedBox(
                height: screenHeight * 0.7,
                child: Center(
                    child: Text(
                  "No Data Found",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )));
          } else
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mySize(10, 10, 30, 30, 25)!),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: mySize(
                              screenWidth * 0.94,
                              screenWidth * 0.94,
                              screenWidth * 0.5,
                              screenWidth * 0.5,
                              screenWidth * 0.4),
                          child: Pagination(context)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                productsWidget(products),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: mySize(
                        screenWidth * 0.94,
                        screenWidth * 0.94,
                        screenWidth * 0.5,
                        screenWidth * 0.5,
                        screenWidth * 0.4),
                    child: Pagination(context)),
                SizedBox(
                  height: 20,
                ),
              ],
            );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Something Happened!")],
          );
        }
      },
    );
  }

  Padding productsWidget(List<ProductModel> products) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mySize(10, 10, 30, 30, 30)!),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: mySize(260, 260, 300, 320, 310),
            crossAxisSpacing: mySize(10, 10, 20, 20, 20)!,
            mainAxisSpacing: mySize(10, 10, 20, 20, 20)!,
            crossAxisCount: mySize(2, 2, 3, 3, 4)!.toInt(),
          ),
          itemCount: products.length,
          itemBuilder: (context, i) {
            ProductModel product = products[i];
            return ProductCard(
              product: product,
            );
          }),
    );
  }

  Padding productsShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mySize(10, 10, 30, 30, 30)!),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: mySize(260, 260, 300, 320, 310),
            crossAxisSpacing: mySize(10, 10, 20, 20, 20)!,
            mainAxisSpacing: mySize(10, 10, 20, 20, 20)!,
            crossAxisCount: mySize(2, 2, 3, 3, 4)!.toInt(),
          ),
          itemCount: 10,
          itemBuilder: (context, i) {
            return ProductCardShimmer();
          }),
    );
  }

  Widget Pagination(context) {
    int numberPages = BlocProvider.of<ProductsBloc>(context).pages;
    if (int.parse(page ?? "1") > numberPages) {
      page = "1";
    } else if (int.parse(page ?? "1") >= numberPages - 1) page = "1";
    return NumberPaginator(
      numberPages: numberPages,
      onPageChange: (int index) {
        print(index);
        page = (index + 1).toString();
        BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent(
            page: page.toString(), brandId: brandId, categoryId: categoryId));
        String route;
        if (brandId != null) {
          route = "brands/${brandId}/products/$page";
        } else if (categoryId != null) {
          route = "categories/${categoryId}/products/$page";
        } else if (brandId != null && categoryId != null) {
          route = "categories/${categoryId}/brands/${brandId}/products/$page";
        } else {
          route = "products/$page";
        }
        html.window.history.pushState(null, '', "#$route");
      },
      initialPage: (int.parse(page ?? "1") - 1),
      config: NumberPaginatorUIConfig(
        height: mySize(40, 40, 50, 50, 50)!,
        buttonShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              width: 1,
              color: colors(context).kprimaryColor!,
            )),
        buttonSelectedForegroundColor: colors(context).whiteColor,
        buttonUnselectedForegroundColor: colors(context).kprimaryColor,
        buttonUnselectedBackgroundColor: colors(context).whiteColor,
        buttonSelectedBackgroundColor: colors(context).kprimaryColor,
      ),
    );
  }
}
