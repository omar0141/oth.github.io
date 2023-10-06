import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          hintText: "search-placeholder".tr, suffixIcon: Icon(Icons.search)),
      onChanged: (value) {
        search = value;
        BlocProvider.of<ProductsBloc>(context).search = search;
      },
    );
  }
}
