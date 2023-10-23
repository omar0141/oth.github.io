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
                  child: Pagination(context, numberPages),
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mySize(10, 10, 30, 30, 25)!),
                  child: Pagination(context, numberPages),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget Pagination(context, int numberPages) {
    double myWidth = (numberPages * 60) + mySize(70, 70, 150, 150, 150)!;
    double myScreenWidth = mySize(screenWidth * 0.94, screenWidth * 0.94,
        screenWidth * 0.6, screenWidth * 0.6, screenWidth * 0.6)!;
    if (myWidth > myScreenWidth) {
      if (screenWidth > 1200)
        myWidth = (screenWidth - screenWidth * 0.06);
      else
        myWidth = myScreenWidth;
    }
    if (numberPages == 1) {
      myWidth = mySize(65, 65, 80, 80, 80)! * 3;
    }
    return SizedBox(
      width: myWidth,
      child: Row(
        children: [
          InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: widget.page == "1" ? null : () {
                int currPage = int.parse(widget.page ?? "1") - 5;
                if (currPage < 1) {
                  widget.page = "1";
                } else {
                  widget.page = currPage.toString();
                }
                goToPage(context);
            },
            child: Container(
              
              padding: EdgeInsets.all(mySize(5, 5, 8, 8, 8)!),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(width: 1,color: colors(context).kprimaryColor!)),
              child: Icon(Icons.keyboard_double_arrow_right_outlined,color: widget.page == "1" ? colors(context).grey1 : colors(context).kprimaryColor,size: mySize(20, 20, 25, 25, 25),),
              ),
          ),
          Expanded(
            child: NumberPaginator(
              numberPages: numberPages,
              onPageChange: (int index) {
                widget.page = (index + 1).toString();
                goToPage(context);
              },
              initialPage: (int.parse(widget.page ?? "1") - 1),
              config: NumberPaginatorUIConfig(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            ),
          ),
          InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: widget.page == numberPages.toString() ? null : () {
                int currPage = int.parse(widget.page ?? "1") + 5;
                if (currPage >= numberPages) {
                  widget.page = numberPages.toString();
                } else {
                  widget.page = currPage.toString();
                }
                goToPage(context);
            },
            child: Container(
              
              padding: EdgeInsets.all(mySize(5, 5, 8, 8, 8)!),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(width: 1,color: colors(context).kprimaryColor!)),
              child: Icon(Icons.keyboard_double_arrow_left_outlined,color:  widget.page == numberPages.toString() ? colors(context).grey1 : colors(context).kprimaryColor,size: mySize(20, 20, 25, 25, 25),),
              ),
          ),
        ],
      ),
    );
  }

  void goToPage(context) {
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
    html.window.history.replaceState(null, '', "#$route");
  }
}
