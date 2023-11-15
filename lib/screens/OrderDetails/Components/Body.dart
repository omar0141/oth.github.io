import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Bloc/Orders/orders_bloc.dart';
import 'package:shakosh/Config/Images/Images.dart';
import 'package:shakosh/Config/Translations/Translation.dart';
import 'package:shakosh/Config/Utils/SizeConfig.dart';
import 'package:shakosh/Data/Models/ProductModel.dart';
import 'package:shakosh/Data/Remote/MyApi.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  Body({super.key, required this.orderId});
  String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return SizedBox(
            height: mySize(null, null, screenHeight * 0.74, screenHeight * 0.74,
                screenHeight * 0.74),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is OrderDetailsLoaded) {
          List<ProductModel> products = state.products;
          return SizedBox(
            height: mySize(screenHeight * 0.85, screenHeight * 0.85,
                screenHeight * 0.74, screenHeight * 0.74, screenHeight * 0.74),
            child: ListView(
              children: [
                if (screenWidth > 768)
                  SizedBox(
                    height: 20,
                  ),
                if (screenWidth > 768)
                  Center(
                    child: Text(
                      "order-no".tr + ": " + orderId,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                if (screenWidth > 768)
                  SizedBox(
                    height: 10,
                  ),
                if (screenWidth > 768)
                  Card(
                    child: Row(
                      children: [
                        Expanded(
                          child: DataTable(
                              showCheckboxColumn: false,
                              columnSpacing:
                                  (state is OrdersLoading || products.isEmpty)
                                      ? screenWidth * 0.04
                                      : screenWidth * 0.024,
                              columns: ordersTableColumns,
                              rows: [
                                for (var product in products)
                                  ordersTableRow(product, context),
                              ]),
                        ),
                      ],
                    ),
                  )
                else
                  for (var product in products)
                    productCardMobile(product, context)
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget productCardMobile(ProductModel product, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("product/${product.id}");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                    width: mySize(100, 100, 150, 150, 150),
                    child: productImage(product.thumbnail)),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "language_iso".tr == "ar"
                          ? product.nameAlt ?? ""
                          : product.name ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    if (product.model != null)
                      Text(
                        "model".tr + ": " + (product.model ?? ""),
                        style: TextStyle(
                            fontSize: 16,
                            color: colors(context).kSecondaryColor),
                      ),
                    Text(
                      "price".tr + ": " + product.netPrice.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 16, color: colors(context).kSecondaryColor),
                    ),
                    Text(
                      "quantity".tr +
                          ": " +
                          product.quantity.toStringAsFixed(1),
                      style: TextStyle(
                          fontSize: 16, color: colors(context).normalTextColor),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  ClipRRect productImage(String? image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: FastCachedImage(
          url: MyApi.media + (image ?? ""),
          fit: BoxFit.fill,
          loadingBuilder: (context, url) => Center(
                child: SizedBox(
                  width: mySize(50, 50, 30, 30, 30),
                  height: mySize(50, 50, 30, 30, 30),
                  child: CircularProgressIndicator(
                      strokeWidth: 3, color: colors(context).kprimaryColor),
                ),
              ),
          errorBuilder: (context, url, error) => SvgPicture.asset(
                unLoadedImage,
              )),
    );
  }

  List<DataColumn> get ordersTableColumns {
    return [
      DataColumn(
        label: Text(
          ''.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'product-name'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'model'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'quantity'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'price'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  DataRow ordersTableRow(ProductModel product, context) {
    return DataRow(
        onSelectChanged: (value) {
          Navigator.of(context).pushNamed("product/${product.id}");
        },
        cells: [
          DataCell(Container(
            padding: EdgeInsets.all(5),
            width: 75,
            height: 75,
            child: productImage(product.thumbnail),
          )),
          DataCell(Text(
            "language_iso".tr == "ar"
                ? product.nameAlt ?? ""
                : product.name ?? "",
          )),
          DataCell(Text(product.model ?? "")),
          DataCell(Text(product.quantity.toStringAsFixed(1))),
          DataCell(Text(product.netPrice.toStringAsFixed(2))),
        ]);
  }
}
