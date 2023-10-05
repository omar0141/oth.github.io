import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ContextMenu.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/BrandModel.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';
import 'dart:html' as html;

// ignore: must_be_immutable
class ProductsFilter extends StatefulWidget {
  ProductsFilter({super.key, this.brandId, this.categoryId});

  String? categoryId;
  String? brandId;

  @override
  State<ProductsFilter> createState() => _ProductsFilterState();
}

class _ProductsFilterState extends State<ProductsFilter> {
  List<bool> expand = [false, false];

  @override
  void initState() {
    if (widget.categoryId != null) {
      expand[0] = true;
    }
    if (widget.brandId != null) {
      expand[1] = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "fiter-by".tr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(
              Icons.filter_alt_outlined,
              size: 20,
              color: colors(context).grey1,
            )
          ],
        ),
        Divider(),
        ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.zero,
          materialGapSize: 0,
          elevation: 0,
          dividerColor: colors(context).grey2,
          expansionCallback: (panelIndex, isExpanded) {
            expand[panelIndex] = isExpanded;
            setState(() {});
          },
          children: [
            categoryFilter(context, 0),
            brandFilter(context, 1),
          ],
        )
      ],
    );
  }

  ExpansionPanel categoryFilter(BuildContext context, index) {
    return ExpansionPanel(
        canTapOnHeader: true,
        backgroundColor: colors(context).whiteColor,
        isExpanded: expand[index],
        headerBuilder: (context, isExpanded) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "categories".tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              if (widget.categoryId != null)
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<ProductsBloc>(context).categoryId = null;
                    widget.categoryId == null;

                    String route;
                    if (widget.brandId != null) {
                      route = "brands/${widget.brandId}/products/1";
                    } else {
                      route = "products/1";
                    }

                    Navigator.of(context).pushReplacementNamed(route);
                  },
                  child: Icon(
                    Icons.close,
                    size: 20,
                  ),
                )
            ],
          );
        },
        body: SizedBox(
          height: mySize(null, null, screenHeight * 0.4, screenHeight * 0.4,
              screenHeight * 0.4),
          child: BlocBuilder<DependanciesBloc, DependanciesState>(
            builder: (context, state) {
              if (state is DependanciesLoaded) {
                List<CategoreyModel> categories = state.allCategories;
                return ListView.builder(
                    itemCount: categories.length,
                    physics: screenWidth < 768
                        ? NeverScrollableScrollPhysics()
                        : null,
                    itemBuilder: (context, i) {
                      CategoreyModel category = categories[i];
                      String route = "categories/${category.id}/products/1";
                      return Listener(
                        onPointerDown: (event) {
                          onPointerDown(event, Uri.base.origin + "/#$route");
                        },
                        child: InkWell(
                          onTap: () {
                            widget.categoryId = category.id;
                            if (widget.brandId != null &&
                                widget.categoryId != null) {
                              route =
                                  "categories/${widget.categoryId}/brands/${widget.brandId}/products/1";
                            } else
                              route = "categories/${category.id}/products/1";
                            html.window.history.pushState(null, '', "#$route");
                            BlocProvider.of<ProductsBloc>(context).categoryId =
                                widget.categoryId;
                            BlocProvider.of<ProductsBloc>(context).add(
                                GetProductsEvent(
                                    categoryId: widget.categoryId,
                                    brandId: widget.brandId));
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: widget.categoryId == category.id
                                    ? colors(context).kprimaryColor
                                    : null),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "language_iso".tr == "ar"
                                        ? category.nameAlt
                                        : category.name,
                                    style: TextStyle(
                                        color: widget.categoryId == category.id
                                            ? colors(context).whiteColor
                                            : null),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else
                return Container();
            },
          ),
        ));
  }

  ExpansionPanel brandFilter(BuildContext context, index) {
    return ExpansionPanel(
        canTapOnHeader: true,
        backgroundColor: colors(context).whiteColor,
        isExpanded: expand[index],
        headerBuilder: (context, isExpanded) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "brands".tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              if (widget.brandId != null)
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<ProductsBloc>(context).brandId = null;
                    widget.brandId == null;
                    String route;
                    if (widget.categoryId != null) {
                      route = "categories/${widget.categoryId}/products/1";
                    } else {
                      route = "products/1";
                    }

                    Navigator.of(context).pushReplacementNamed(route);
                  },
                  child: Icon(
                    Icons.close,
                    size: 20,
                  ),
                )
            ],
          );
        },
        body: SizedBox(
          height: mySize(null, null, screenHeight * 0.4, screenHeight * 0.4,
              screenHeight * 0.4),
          child: BlocBuilder<DependanciesBloc, DependanciesState>(
            builder: (context, state) {
              if (state is DependanciesLoaded) {
                List<BrandModel> brands = state.brands;
                return ListView.builder(
                    itemCount: brands.length,
                    physics: screenWidth < 768
                        ? NeverScrollableScrollPhysics()
                        : null,
                    itemBuilder: (context, i) {
                      BrandModel brand = brands[i];
                      String route = "brands/${brand.id}/products/1";
                      return Listener(
                        onPointerDown: (event) {
                          onPointerDown(event, Uri.base.origin + "/#$route");
                        },
                        child: InkWell(
                          onTap: () {
                            widget.brandId = brand.id;
                            if (widget.brandId != null &&
                                widget.categoryId != null) {
                              route =
                                  "categories/${widget.categoryId}/brands/${widget.brandId}/products/1";
                            } else
                              route = "brands/${brand.id}/products/1";
                            html.window.history.pushState(null, '', "#$route");
                            BlocProvider.of<ProductsBloc>(context).brandId =
                                widget.brandId;
                            BlocProvider.of<ProductsBloc>(context).add(
                                GetProductsEvent(
                                    categoryId: widget.categoryId,
                                    brandId: widget.brandId));
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: widget.brandId == brand.id
                                    ? colors(context).kprimaryColor
                                    : null),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "language_iso".tr == "ar"
                                        ? brand.nameAlt
                                        : brand.name,
                                    style: TextStyle(
                                        color: widget.brandId == brand.id
                                            ? colors(context).whiteColor
                                            : null),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else
                return Container();
            },
          ),
        ));
  }
}
