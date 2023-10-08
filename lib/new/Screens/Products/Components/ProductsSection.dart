import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ProductsShimmer.dart';
import 'package:shakosh/new/Components/ProductsWidget.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:universal_html/html.dart' as html;

// ignore: must_be_immutable
class ProductsSection extends StatefulWidget {
  ProductsSection(
      {super.key, this.search, this.categoryId, this.brandId, this.page});

  String? search;
  String? categoryId;
  String? brandId;
  String? page;

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> with RouteAware {
  @override
  void didPopNext() {
    BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent(
        back: true,
        search: widget.search,
        categoryId: widget.categoryId,
        brandId: widget.brandId,
        page: widget.page));
    super.didPopNext();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    MyApp.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        widget.brandId = BlocProvider.of<ProductsBloc>(context).brandId;
        widget.categoryId = BlocProvider.of<ProductsBloc>(context).categoryId;
        if (state is ProductsLoading) {
          return ProductsShimmer(
            crossAxisCount: mySize(2, 2, 3, 3, 4)!.toInt(),
          );
        } else if (state is ProductsLoaded) {
          List<ProductModel> products = state.products;
          int numberPages = state.pages;
          widget.page = state.currentPage.toString();
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
                          child: Pagination(context, numberPages)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ProductsWidget(
                  products: products,
                  crossAxisCount: mySize(2, 2, 3, 3, 4)!.toInt(),
                ),
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
                    child: Pagination(context, numberPages)),
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

  Widget Pagination(context, int numberPages) {
    return NumberPaginator(
      numberPages: numberPages,
      onPageChange: (int index) {
        print(index);
        widget.page = (index + 1).toString();
        BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent(
            page: widget.page.toString(),
            brandId: widget.brandId,
            categoryId: widget.categoryId));
        String route;
        if (widget.brandId != null) {
          route = "brands/${widget.brandId}/products/${widget.page}";
        } else if (widget.categoryId != null) {
          route = "categories/${widget.categoryId}/products/${widget.page}";
        } else if (widget.brandId != null && widget.categoryId != null) {
          route =
              "categories/${widget.categoryId}/brands/${widget.brandId}/products/${widget.page}";
        } else {
          route = "products/${widget.page}";
        }
        html.window.history.pushState(null, '', "#$route");
      },
      initialPage: (int.parse(widget.page ?? "1") - 1),
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
