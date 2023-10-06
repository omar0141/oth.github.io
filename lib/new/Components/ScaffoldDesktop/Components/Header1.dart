import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ContextMenu.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';
import 'package:shakosh/new/Screens/Home/HomeScreen.dart';
import 'package:universal_html/html.dart' as html;

// ignore: must_be_immutable
class Header1 extends StatelessWidget {
  Header1(
      {super.key,
      this.brandId,
      this.search,
      this.products = false,
      this.categoryId});
  String? categoryId;
  String? brandId;
  String? search;
  bool products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 85,
        child: Row(
          children: [
            Listener(
              onPointerDown: (event) {
                onPointerDown(
                    event, Uri.base.origin + "/#${HomeScreen.routeName}");
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      logo,
                      width: 200,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: BlocBuilder<DependanciesBloc, DependanciesState>(
                          builder: (context, state) {
                        if (state is DependanciesLoading) {
                          return loadingDropDown("loading".tr);
                        } else if (state is DependanciesLoaded) {
                          List<CategoreyModel> categories = state.allCategories;
                          return searchDropDown(categories);
                        } else {
                          return loadingDropDown("loading-failed".tr);
                        }
                      })),
                  Expanded(flex: 3, child: searchTextField(context)),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        "client-service".tr,
                        style: TextStyle(
                          fontSize: 18,
                          color: colors(context).grey1,
                        ),
                      ),
                      SelectableText(
                        "(+2) 01023966756",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 20, color: colors(context).kprimaryColor),
                      ),
                      SelectableText(
                        "(+2) 01221722221",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 20, color: colors(context).kprimaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFormField loadingDropDown(text) {
    return TextFormField(
      initialValue: text,
      enabled: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10),
          suffix: Icon(Icons.arrow_drop_down)),
    );
  }

  Widget searchTextField(context) {
    TextEditingController searchController =
        TextEditingController(text: search);
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          hoverColor: Colors.transparent,
          onTap: () {
            search = searchController.text;

            String route;
            if (brandId != null) {
              route = "brands/${brandId}/products/1/$search";
            } else if (categoryId != null) {
              route = "categories/${categoryId}/products/1/$search";
            } else if (brandId != null && categoryId != null) {
              route =
                  "categories/${categoryId}/brands/${brandId}/products/1/$search";
            } else {
              route = "products/1/$search";
            }
            if (products) {
              BlocProvider.of<ProductsBloc>(context).search = search;
              BlocProvider.of<ProductsBloc>(context).categoryId = categoryId;
              BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent(
                  page: "1",
                  brandId: brandId,
                  categoryId: categoryId,
                  search: search));
              html.window.history.pushState(null, '', "#$route");
            } else {
              Navigator.of(context).pushNamed(route);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 47,
            child: Icon(
              Icons.search,
              color: colors(context).whiteColor,
            ),
            decoration: BoxDecoration(
                color: colors(context).kprimaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3),
                    bottomLeft: Radius.circular(3))),
          ),
        ),
        hintText: "search-placeholder".tr,
      ),
    );
  }

  Widget searchDropDown(List<CategoreyModel> categories) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (products) {
          if (BlocProvider.of<ProductsBloc>(context).categoryId != null) {
            categoryId = BlocProvider.of<ProductsBloc>(context).categoryId;
          }
        }
        return DropdownButtonFormField(
            padding: EdgeInsets.all(0),
            value: categoryId,
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10),
            ),
            items: [
              DropdownMenuItem(value: null, child: Text("all-categories".tr)),
              for (CategoreyModel category in categories)
                DropdownMenuItem(
                    value: category.id,
                    child: Text(
                      "language_iso".tr == "ar"
                          ? category.nameAlt
                          : category.name,
                      style: TextStyle(fontSize: 14),
                      maxLines: 1,
                    )),
            ],
            onChanged: (value) {
              categoryId = value;
            });
      },
    );
  }
}
