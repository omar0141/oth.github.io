import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Products/Components/ProductsFilter.dart';

// ignore: must_be_immutable
class ProductSearchMobileScreen extends StatelessWidget {
  ProductSearchMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldMobile(
      screenName: "search".tr,
      searchOpened: true,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            searchTextField(context),
            SizedBox(
              height: 20,
            ),
            ProductsFilter(),
          ],
        ),
      ),
      index: -1,
    );
  }

  Widget searchTextField(context) {
    String? search = BlocProvider.of<ProductsBloc>(context).search;
    TextEditingController searchController =
        TextEditingController(text: search);
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "search-placeholder".tr,
        suffixIcon: InkWell(
          hoverColor: Colors.transparent,
          onTap: () {
            String route;
            String? brandId = BlocProvider.of<ProductsBloc>(context).brandId;
            String? search =
                BlocProvider.of<ProductsBloc>(context).search ?? "";
            String? categoryId =
                BlocProvider.of<ProductsBloc>(context).categoryId;
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

            Navigator.of(context).pushReplacementNamed(route);
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
      ),
      onChanged: (value) {
        search = value;
        BlocProvider.of<ProductsBloc>(context).search = search;
      },
    );
  }
}
