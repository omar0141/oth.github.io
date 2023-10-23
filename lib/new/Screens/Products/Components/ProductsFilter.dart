import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ContextMenu.dart';
import 'package:shakosh/new/Config/Strings/Strings.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/BrandModel.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';
import 'package:shakosh/new/Screens/Products/ProductSearchMobileScreen.dart';
import 'package:universal_html/html.dart' as html;

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
  void deactivate() {
    if (screenWidth > 768) {
      BlocProvider.of<ProductsBloc>(context).categoryId = null;
      BlocProvider.of<ProductsBloc>(context).brandId = null;
      BlocProvider.of<ProductsBloc>(context).search = null;
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (screenWidth > 768) {
      BlocProvider.of<ProductsBloc>(context).categoryId = null;
      BlocProvider.of<ProductsBloc>(context).brandId = null;
      BlocProvider.of<ProductsBloc>(context).search = null;
    }
    super.dispose();
  }

  @override
  void initState() {
    if (BlocProvider.of<ProductsBloc>(context).categoryId == null) {
      BlocProvider.of<ProductsBloc>(context).categoryId = widget.categoryId;
    }
    if (BlocProvider.of<ProductsBloc>(context).brandId == null) {
      BlocProvider.of<ProductsBloc>(context).brandId = widget.brandId;
    }
    widget.categoryId = BlocProvider.of<ProductsBloc>(context).categoryId;
    widget.brandId = BlocProvider.of<ProductsBloc>(context).brandId;
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
              "filter-by".tr,
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
        BlocConsumer<ProductsBloc, ProductsState>(
          listener: (context, state) {
            widget.categoryId =
                BlocProvider.of<ProductsBloc>(context).categoryId;
            if (widget.categoryId == null) {
              expand[0] = false;
            } else {
              expand[0] = true;
            }
            setState(() {});
          },
          builder: (context, state) {
            return ExpansionPanelList(
              expandedHeaderPadding: EdgeInsets.zero,
              materialGapSize: 0,
              elevation: 0,
              dividerColor: colors(context).grey2,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  expand[panelIndex] = isExpanded;
                });
              },
              children: [
                categoryFilter(context, 0),
                brandFilter(context, 1),
              ],
            );
          },
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
                    if (screenWidth > 768)
                      Navigator.of(context).pushReplacementNamed(route);
                    else
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return ProductSearchMobileScreen();
                      }));
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
          height: mySize(null, null, screenHeight * 0.6, screenHeight * 0.6,
              screenHeight * 0.6),
          child: BlocBuilder<DependanciesBloc, DependanciesState>(
            builder: (context, state) {
              if (state is DependanciesLoaded) {
                List<CategoreyModel> categories = state.allCategories;
                return ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: screenWidth < 768 ? true : false,
                    physics: screenWidth < 768
                        ? NeverScrollableScrollPhysics()
                        : null,
                    itemBuilder: (context, i) {
                      CategoreyModel category = categories[i];
                      String route = "categories/${category.id}/products/1";
                      return Listener(
                        onPointerDown: (event) {
                          onPointerDown(
                              event, Uri.base.origin + urlName + "/#$route");
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
                            html.window.history
                                .replaceState(null, '', "#$route");
                            BlocProvider.of<ProductsBloc>(context).categoryId =
                                widget.categoryId;
                            BlocProvider.of<ProductsBloc>(context).add(
                                GetProductsEvent(
                                    count: mySize(8, 8, 12, 12, 16).toString(),
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
                                        ? category.nameAlt ?? ""
                                        : category.name ?? "",
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
                    if (screenWidth > 768)
                      Navigator.of(context).pushReplacementNamed(route);
                    else
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return ProductSearchMobileScreen();
                      }));
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
          height: mySize(null, null, screenHeight * 0.6, screenHeight * 0.6,
              screenHeight * 0.6),
          child: BlocBuilder<DependanciesBloc, DependanciesState>(
            builder: (context, state) {
              if (state is DependanciesLoaded) {
                List<BrandModel> brands = state.brands;
                return ListView.builder(
                    itemCount: brands.length,
                    shrinkWrap: screenWidth < 768 ? true : false,
                    physics: screenWidth < 768
                        ? NeverScrollableScrollPhysics()
                        : null,
                    itemBuilder: (context, i) {
                      BrandModel brand = brands[i];
                      String route = "brands/${brand.id}/products/1";
                      return Listener(
                        onPointerDown: (event) {
                          onPointerDown(
                              event, Uri.base.origin + urlName + "/#$route");
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
                            html.window.history
                                .replaceState(null, '', "#$route");
                            BlocProvider.of<ProductsBloc>(context).brandId =
                                widget.brandId;
                            BlocProvider.of<ProductsBloc>(context).add(
                                GetProductsEvent(
                                    count: mySize(8, 8, 12, 12, 16).toString(),
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
                                        ? brand.nameAlt ?? ""
                                        : brand.name ?? "",
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
