import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ProductsShimmer.dart';
import 'package:shakosh/new/Components/ProductsWidget.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';

class TrendingProducts extends StatefulWidget {
  const TrendingProducts({super.key});

  @override
  State<TrendingProducts> createState() => _TrendingProductsState();
}

class _TrendingProductsState extends State<TrendingProducts> with RouteAware {
  @override
  void didPopNext() {
    BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent(
      trending: true,
      back: true,
      count: mySize(8, 8, 12, 16, 20).toString(),
    ));
    super.didPopNext();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void initState() {
    BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent(
      trending: true,
      count: mySize(8, 8, 12, 16, 20).toString(),
    ));
    super.initState();
  }

  @override
  void dispose() {
    MyApp.routeObserver.unsubscribe(this);
    super.dispose();
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
                  fontSize: mySize(17, 17, 19, 19, 19),
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
              return ProductsShimmer(
                itemCount: mySize(8, 8, 12, 16, 20)!.toInt(),
              );
            } else if (state is TrendingProductsLoaded) {
              List<ProductModel> products = state.products;
              return ProductsWidget(products: products);
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
