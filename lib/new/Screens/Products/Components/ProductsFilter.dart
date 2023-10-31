import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ContextMenu.dart';
import 'package:shakosh/new/Config/Strings/Strings.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Data/Models/BrandModel.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';
import 'package:shakosh/new/Screens/Products/ProductSearchMobileScreen.dart';

// ignore: must_be_immutable
class ProductsFilter extends StatefulWidget {
  ProductsFilter({super.key, this.brandId, this.categoryId, this.search});

  String? categoryId;
  String? brandId;
  String? search;

  @override
  State<ProductsFilter> createState() => _ProductsFilterState();
}

class _ProductsFilterState extends State<ProductsFilter> {
  List<bool> expand = [true];
  List categoriesBreadCrumbs = [];
  bool searchWithBrands = false;

  @override
  void initState() {
    searchWithBrands = BlocProvider.of<ProductsBloc>(context).searchWithBrands;

    categoriesBreadCrumbs =
        BlocProvider.of<DependanciesBloc>(context).categoriesBreadCrumbs;

    if (widget.categoryId != null) {
      expand[0] = true;
    }
    if (widget.brandId != null) {
      expand[0] = true;
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
        ExpansionPanelList(
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
            if (widget.brandId != null && searchWithBrands || screenWidth < 768)
              categoryFilter(context, 0),
            if (!searchWithBrands && screenWidth > 768) brandFilter(context, 0),
          ],
        )
      ],
    );
  }

  ExpansionPanel categoryFilter(BuildContext context, index) {
    return ExpansionPanel(
        canTapOnHeader: true,
        backgroundColor: colors(context).whiteColor,
        isExpanded: expand[0],
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
                    if (screenWidth > 768) {
                      BlocProvider.of<ProductsBloc>(context).add(
                          ProductsNavigate(
                              brandId: widget.brandId,
                              categoryId: null,
                              search: widget.search));
                    } else
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return ProductSearchMobileScreen(
                          brandId: widget.brandId,
                          categoryId: null,
                          search: widget.search,
                        );
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
        body: BlocBuilder<DependanciesBloc, DependanciesState>(
          builder: (context, state) {
            if (state is DependanciesLoaded) {
              List<CategoreyModel> categories =
                  screenWidth < 768 ? state.allCategories : state.categories;
              return ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
                          if (screenWidth > 768) {
                            BlocProvider.of<ProductsBloc>(context).add(
                                ProductsNavigate(
                                    brandId: widget.brandId,
                                    categoryId: widget.categoryId,
                                    search: widget.search));
                          } else
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return ProductSearchMobileScreen(
                                brandId: widget.brandId,
                                categoryId: widget.categoryId,
                                search: widget.search,
                              );
                            }));
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
        ));
  }

  ExpansionPanel brandFilter(BuildContext context, index) {
    return ExpansionPanel(
        canTapOnHeader: true,
        backgroundColor: colors(context).whiteColor,
        isExpanded: expand[0],
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
                    print(widget.search);
                    if (screenWidth > 768) {
                      BlocProvider.of<ProductsBloc>(context).add(
                          ProductsNavigate(
                              brandId: null,
                              categoryId: widget.categoryId,
                              search: widget.search));
                    } else
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return ProductSearchMobileScreen(
                          brandId: null,
                          categoryId: widget.categoryId,
                          search: widget.search,
                        );
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
        body: BlocBuilder<DependanciesBloc, DependanciesState>(
          builder: (context, state) {
            if (state is DependanciesLoaded) {
              List<BrandModel> brands = state.brands;
              return ListView.builder(
                  itemCount: brands.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
                          if (screenWidth > 768) {
                            BlocProvider.of<ProductsBloc>(context).add(
                                ProductsNavigate(
                                    brandId: widget.brandId,
                                    categoryId: widget.categoryId,
                                    search: widget.search));
                          } else
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return ProductSearchMobileScreen(
                                brandId: widget.brandId,
                                categoryId: widget.categoryId,
                                search: widget.search,
                              );
                            }));
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
        ));
  }
}
