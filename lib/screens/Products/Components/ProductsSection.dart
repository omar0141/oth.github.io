import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/Bloc/Products/products_bloc.dart';
import 'package:shakosh/Components/BrandsBreadCrumbs.dart';
import 'package:shakosh/Components/CatgeoriesBreadCrumbs.dart';
import 'package:shakosh/Components/ProductsShimmer.dart';
import 'package:shakosh/Components/ProductsWidget.dart';
import 'package:shakosh/Config/Images/Images.dart';
import 'package:shakosh/Config/Translations/Translation.dart';
import 'package:shakosh/Config/Utils/SizeConfig.dart';
import 'package:shakosh/Data/Models/BrandModel.dart';
import 'package:shakosh/Data/Models/CategoreyModel.dart';
import 'package:shakosh/Data/Models/ProductModel.dart';
import 'package:shakosh/Data/Remote/MyApi.dart';

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
  bool searchWithBrands = false;

  @override
  void didPopNext() {
    BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent(
        back: true,
        search: widget.search,
        categoryId: widget.categoryId,
        brandId: widget.brandId,
        count: mySize(8, 8, 12, 12, 16).toString(),
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
  void initState() {
    searchWithBrands = BlocProvider.of<ProductsBloc>(context).searchWithBrands;
    if (widget.brandId != null &&
        widget.categoryId == null &&
        !searchWithBrands) {
      BlocProvider.of<ProductsBloc>(context).searchWithBrands = true;
      searchWithBrands = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DependanciesBloc, DependanciesState>(
          builder: (context, state) {
            if (state is DependanciesLoaded) {
              return Column(
                children: [
                  if (widget.brandId != null && searchWithBrands)
                    BrandsBreadCrumbs(brandId: widget.brandId),
                  if (!searchWithBrands)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      child: CatgeoriesBreadCrumbs(),
                    ),
                  if (widget.brandId != null &&
                      searchWithBrands &&
                      screenWidth < 768)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 60,
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            categoriesFilterWidget(context, null),
                            for (var categorey in state.categories)
                              categoriesFilterWidget(context, categorey),
                          ],
                        ),
                      ),
                    ),
                  if (!searchWithBrands && screenWidth < 768)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 60,
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            brandsFilterWidget(context, null),
                            for (var brand in state.brands)
                              brandsFilterWidget(context, brand),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
        BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
          if (state is ProductsLoading) {
            return ProductsShimmer(
              itemCount: mySize(8, 8, 12, 12, 16)!.toInt(),
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
                    height: mySize(60, 60, 20, 20, 20),
                  ),
                ],
              );
          } else {
            return SizedBox();
          }
        }),
      ],
    );
  }

  Widget Pagination(context, int numberPages) {
    double myWidth = (numberPages * 60) + mySize(85, 85, 170, 170, 170)!;
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
            onTap: widget.page == "1"
                ? null
                : () {
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 1, color: colors(context).kprimaryColor!)),
              child: Icon(
                Icons.keyboard_double_arrow_right_outlined,
                color: widget.page == "1"
                    ? colors(context).grey1
                    : colors(context).kprimaryColor,
                size: mySize(20, 20, 25, 25, 25),
              ),
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
            onTap: widget.page == numberPages.toString()
                ? null
                : () {
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 1, color: colors(context).kprimaryColor!)),
              child: Icon(
                Icons.keyboard_double_arrow_left_outlined,
                color: widget.page == numberPages.toString()
                    ? colors(context).grey1
                    : colors(context).kprimaryColor,
                size: mySize(20, 20, 25, 25, 25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void goToPage(context) {
    BlocProvider.of<ProductsBloc>(context).add(ProductsNavigate(
        brandId: widget.brandId,
        categoryId: widget.categoryId,
        search: widget.search,
        page: widget.page));
  }

  InkWell brandsFilterWidget(BuildContext context, BrandModel? brand) {
    return InkWell(
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        if (brand == null) {
          widget.brandId = null;
        } else {
          widget.brandId = brand.id;
        }
        BlocProvider.of<ProductsBloc>(context).add(ProductsNavigate(
            brandId: widget.brandId,
            categoryId: widget.categoryId,
            search: widget.search));
      },
      child: brand == null
          ? Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsetsDirectional.only(top: 10, bottom: 10, end: 10),
              decoration: BoxDecoration(
                  color: widget.brandId == null
                      ? colors(context).kprimaryColor
                      : null,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 1, color: colors(context).kprimaryColor!)),
              child: Text(
                "all".tr,
                style: TextStyle(
                    color: widget.brandId == null
                        ? colors(context).whiteColor
                        : colors(context).normalTextColor),
              ),
            )
          : Opacity(
              opacity: brand.id == widget.brandId ? 1 : 0.25,
              child: Container(
                  padding: EdgeInsets.all(0),
                  margin:
                      EdgeInsetsDirectional.only(top: 10, bottom: 10, end: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FastCachedImage(
                        url: MyApi.media + (brand.thumbnail ?? ""),
                        loadingBuilder: (context, url) => SizedBox(
                              height: 50,
                              width: 100,
                              child: Center(
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: colors(context).kprimaryColor),
                                ),
                              ),
                            ),
                        errorBuilder: (context, url, error) => SvgPicture.asset(
                              unLoadedImage,
                              height: mySize(65, 65, 100, 100, 100),
                            )),
                  )),
            ),
    );
  }

  InkWell categoriesFilterWidget(
      BuildContext context, CategoreyModel? category) {
    return InkWell(
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        if (category == null) {
          widget.categoryId = null;
        } else {
          widget.categoryId = category.id;
        }
        BlocProvider.of<ProductsBloc>(context).add(ProductsNavigate(
            brandId: widget.brandId,
            categoryId: widget.categoryId,
            search: widget.search));
      },
      child: category == null
          ? Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsetsDirectional.only(top: 10, bottom: 10, end: 10),
              decoration: BoxDecoration(
                  color: widget.categoryId == null
                      ? colors(context).kprimaryColor
                      : null,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 1, color: colors(context).kprimaryColor!)),
              child: Text(
                "all".tr,
                style: TextStyle(
                    color: widget.categoryId == null
                        ? colors(context).whiteColor
                        : colors(context).normalTextColor),
              ),
            )
          : Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsetsDirectional.only(top: 10, bottom: 10, end: 10),
              decoration: BoxDecoration(
                  color: category.id == widget.categoryId
                      ? colors(context).kprimaryColor
                      : null,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 1, color: colors(context).kprimaryColor!)),
              child: Text(
                ("language_iso".tr == "ar"
                        ? category.nameAlt
                        : category.name) ??
                    "",
                style: TextStyle(
                    color: category.id == widget.categoryId
                        ? colors(context).whiteColor
                        : colors(context).normalTextColor),
              ),
            ),
    );
  }
}
