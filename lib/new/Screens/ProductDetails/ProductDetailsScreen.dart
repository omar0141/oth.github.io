import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/CartWidget.dart';
import 'package:shakosh/new/Components/FavouriteWidget.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Screens/ProductDetails/Components/DesktopBody.dart';
import 'package:shakosh/new/Screens/ProductDetails/Components/MobileBody.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({super.key, this.productId});

  String? productId;

  static String routeName = "product/:Id";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with RouteAware {
  @override
  void didPopNext() {
    BlocProvider.of<ProductsBloc>(context)
        .add(GetProductDetailsEvent(productID: widget.productId, back: true));
    super.didPopNext();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void initState() {
    BlocProvider.of<ProductsBloc>(context)
        .add(GetProductDetailsEvent(productID: widget.productId));
    super.initState();
  }

  @override
  void dispose() {
    MyApp.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return myScreen(state);
      },
    );
  }

  StatefulWidget myScreen(state) {
    String name = "";
    String nameAlt = "";
    try {
      name = state.productDetails.name;
      nameAlt = state.productDetails.nameAlt;
    } catch (e) {
      name = "";
      nameAlt = "";
    }
    if (screenWidth > 768) {
      return ScaffoldDesktop(
        child: DesktopBody(
          state: state,
        ),
      );
    } else {
      return ScaffoldMobile(
        screenName: "language_iso".tr == "ar" ? nameAlt : name,
        bottomNavigationBar: (state is ProductsDetailsLoaded)
            ? SizedBox(
                height: 75,
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 10, end: 10),
                          child: CartWidget(
                              product: ProductModel.fromJson(
                                  state.productDetails.toJson())),
                        )),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10),
                          child: FavouriteWidget(
                              height: 50,
                              product: ProductModel.fromJson(
                                  state.productDetails.toJson())),
                        )),
                  ],
                ),
              )
            : Container(),
        child: MobileBody(
          state: state,
        ),
        index: -1,
      );
    }
  }
}
