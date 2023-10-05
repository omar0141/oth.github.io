import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ProductCard.dart';
import 'package:shakosh/new/Components/ProductCardShimmer.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';

class TrendingProducts extends StatefulWidget {
  const TrendingProducts({super.key});

  @override
  State<TrendingProducts> createState() => _TrendingProductsState();
}

class _TrendingProductsState extends State<TrendingProducts> {
  @override
  void initState() {
    BlocProvider.of<ProductsBloc>(context)
        .add(GetProductsEvent(trending: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: mySize(10, 10, 20, 20, 20),
            ),
            Text(
              "trending-products".tr,
              style: TextStyle(
                  fontSize: mySize(14, 14, 19, 19, 19),
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            SizedBox(
              width: mySize(10, 10, 20, 20, 20),
            ),
          ],
        ),
        SizedBox(
          height: mySize(10, 10, 15, 15, 15),
        ),
        BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return productsShimmer();
            } else if (state is ProductsLoaded) {
              List<ProductModel> products = state.products;
              return productsWidget(products);
            } else {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Something Happened!")],
              );
            }
          },
        ),
      ],
    );
  }

  Padding productsWidget(List<ProductModel> products) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mySize(10, 10, 30, 30, 30)!),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: mySize(260, 260, 300, 320, 310),
            crossAxisSpacing: mySize(10, 10, 20, 20, 20)!,
            mainAxisSpacing: mySize(10, 10, 20, 20, 20)!,
            crossAxisCount: mySize(2, 2, 3, 4, 5)!.toInt(),
          ),
          itemCount: products.length,
          itemBuilder: (context, i) {
            ProductModel product = products[i];
            return ProductCard(
              product: product,
            );
          }),
    );
  }

  Padding productsShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mySize(10, 10, 30, 30, 30)!),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: mySize(260, 260, 300, 320, 310),
            crossAxisSpacing: mySize(10, 10, 20, 20, 20)!,
            mainAxisSpacing: mySize(10, 10, 20, 20, 20)!,
            crossAxisCount: mySize(2, 2, 3, 4, 5)!.toInt(),
          ),
          itemCount: 10,
          itemBuilder: (context, i) {
            return ProductCardShimmer();
          }),
    );
  }
}
