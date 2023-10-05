import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ProductCard.dart';
import 'package:shakosh/new/Components/ProductCardShimmer.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Screens/Products/Components/ProductsFilter.dart';
import 'dart:html' as html;

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
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: colors(context).grey2!)),
                  child: ProductsFilter(
                    categoryId: categoryId,
                    brandId: brandId,
                  ))),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      brandId = BlocProvider.of<ProductsBloc>(context).brandId;
                      categoryId =
                          BlocProvider.of<ProductsBloc>(context).categoryId;
                      if (state is ProductsLoading) {
                        return productsShimmer();
                      } else if (state is ProductsLoaded) {
                        List<ProductModel> products = state.products;
                        return Column(
                          children: [
                            productsWidget(products),
                            Pagination(context)
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
                  ),
                ],
              ))
        ],
      ),
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
    int maxPages = BlocProvider.of<ProductsBloc>(context).pages;
    int d = int.parse(page ?? "1");
    int s = (d < 1 ? 1 : d);
    int e = (s + 4);
    if (e > maxPages) e = maxPages;
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Container(
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () async {
              if (d > 1) {
                d--;
                page = d.toString();
                BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent(
                    page: page.toString(),
                    brandId: brandId,
                    categoryId: categoryId));
                String route;
                if (brandId != null) {
                  route = "brands/${brandId}/products/$page";
                } else if (categoryId != null) {
                  route = "categories/${categoryId}/products/$page";
                } else if (brandId != null && categoryId != null) {
                  route =
                      "categories/${categoryId}/brands/${brandId}/products/$page";
                } else {
                  route = "products/$page";
                }
                html.window.history.pushState(null, '', "#$route");
              }
            },
          ),
        ),
        Container(
          child: Wrap(
            children: List.generate((maxPages < 5 ? maxPages : 5), (i) {
              int c = s + i;
              if (maxPages > c || maxPages == c) {
                return MaterialButton(
                  child: Text(
                    (c).toString(),
                    style: TextStyle(
                      color: (d != c ? Colors.black : Colors.white),
                    ),
                  ),
                  color: (d != c ? Colors.white : Colors.blue),
                  onPressed: () async {
                    if (d != c) {
                      page = c.toString();
                      BlocProvider.of<ProductsBloc>(context).add(
                          GetProductsEvent(
                              page: page.toString(),
                              brandId: brandId,
                              categoryId: categoryId));
                      String route;
                      if (brandId != null) {
                        route = "brands/${brandId}/products/$page";
                      } else if (categoryId != null) {
                        route = "categories/${categoryId}/products/$page";
                      } else if (brandId != null && categoryId != null) {
                        route =
                            "categories/${categoryId}/brands/${brandId}/products/$page";
                      } else {
                        route = "products/$page";
                      }

                      html.window.history.pushState(null, '', "#$route");
                    }
                  },
                );
              } else {
                return Container(
                  width: 0,
                  height: 0,
                );
              }
            }),
          ),
        ),
        Container(
          child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () async {
              if (d < maxPages) {
                d++;
                page = d.toString();
                BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent(
                    page: page.toString(),
                    brandId: brandId,
                    categoryId: categoryId));
                String route;
                if (brandId != null) {
                  route = "brands/${brandId}/products/$page";
                } else if (categoryId != null) {
                  route = "categories/${categoryId}/products/$page";
                } else if (brandId != null && categoryId != null) {
                  route =
                      "categories/${categoryId}/brands/${brandId}/products/$page";
                } else {
                  route = "products/$page";
                }
                html.window.history.pushState(null, '', "#$route");
              }
            },
          ),
        ),
      ],
    );
  }
}
