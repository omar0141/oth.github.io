import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Products/Components/ProductsFilter.dart';

// ignore: must_be_immutable
class ProductSearchMobileScreen extends StatelessWidget {
  ProductSearchMobileScreen(
      {super.key, this.search, this.categoryId, this.brandId});

  String? search;
  String? categoryId;
  String? brandId;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMobile(
      screenName: "search".tr,
      searchOpened: true,
      brandId: brandId,
      categoryId: categoryId,
      search: search,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            searchTextField(context),
            SizedBox(
              height: 20,
            ),
            ProductsFilter(
              brandId: brandId,
              categoryId: categoryId,
              search: search,
            ),
          ],
        ),
      ),
      index: -1,
    );
  }

  Widget searchTextField(context) {
    TextEditingController searchController =
        TextEditingController(text: search);
    return TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "search-placeholder".tr,
          suffixIcon: InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              search = searchController.text;
              BlocProvider.of<ProductsBloc>(context).add(ProductsNavigate(
                  brandId: brandId, categoryId: categoryId, search: search));
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
                  borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(3),
                      bottomEnd: Radius.circular(3))),
            ),
          ),
        ));
  }
}
